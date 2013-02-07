//
//  productViewController.m
//  Konami Catalog
//
//  Created by Interactive Intern on 11/30/12.
//  Copyright (c) 2012 Interactive Intern. All rights reserved.
//

#import "productViewController.h"

@interface productViewController ()

@end

@implementation productViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    CGRect bounds = [[UIScreen mainScreen] bounds];
    self.pageViewController.view.frame = CGRectMake(0, 86, bounds.size.width, bounds.size.height-86);
    UIImage *logo = [[UIImage alloc] initWithContentsOfFile:[_item getPath]];
    
    logoView = [[UIImageView alloc] initWithImage:logo];
    logoView.frame = CGRectMake((self.view.frame.size.width/2)-300, 400, 600, 650);
    logoView.center = CGPointMake(self.view.frame.size.width/2, 600);
    logoView.contentMode = UIViewContentModeScaleAspectFit;
    
    if(UIDeviceOrientationIsLandscape([self interfaceOrientation])){
        _titleLabel.center = CGPointMake(512, 60);
        _backButton.center = CGPointMake(32,26);
        logoView.center = CGPointMake(512,475);
    }
    
    _titleLabel.text = [[NSString alloc] initWithString:[[_item getName] stringByDeletingPathExtension]];
    
    [self.view addSubview:logoView];
    
    NSBundle *bundle = [NSBundle mainBundle];
    
    NSString *productDir = [[NSString alloc] initWithString:[[[_item getPath] stringByDeletingPathExtension] lastPathComponent]];
    
       
    _viewCat = [_viewCat stringByAppendingPathComponent:productDir];
    
    
    NSArray *files = [[NSArray alloc] initWithArray:[bundle pathsForResourcesOfType:@"png" inDirectory:_viewCat]];
    NSString *str;
    
    UIImage *img;
    CGRect viewRect;
    UIImageView *newImage;
    catItem * newItem;
    
    NSEnumerator *enumerator;
    
    itemArray = [[NSMutableArray alloc] initWithCapacity:[files count]];
    enumerator = [files objectEnumerator];
    while (str = [enumerator nextObject]){
        //initialize ImageView from file
        img = [[UIImage alloc] initWithContentsOfFile:str];
        newImage = [[UIImageView alloc] initWithImage:img];
        
        NSString *itemName = @"";
        NSString *s;
        
        NSArray *nameParts = [str componentsSeparatedByString:@"/"];
        nameParts = [[nameParts lastObject] componentsSeparatedByString:@"-"];
        for(s in nameParts){
            if([s rangeOfString:@"Logo"].location == NSNotFound){
                itemName = [itemName stringByAppendingString:s];
                itemName = [itemName stringByAppendingString:@" "];
            }
        }
        
        newItem = [[catItem alloc] initWithNameAndPath:itemName :str];
        
        //establish frame for ImageView
        viewRect = CGRectMake([itemArray count]*300 +10, 75, 200, 300);
        newImage.frame=viewRect;
        newImage.userInteractionEnabled=YES;
        newImage.contentMode=UIViewContentModeScaleAspectFit;
        
        [newImage addGestureRecognizer:([[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemTap:)])];
        
        [newItem addImageView:newImage];
        
        //render image on screen and add to array
        [itemArray addObject:newItem];
        [self.view addSubview:newImage];
        
    }
}

- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer{
    UIImageView *currImage, *temp;
    catItem *currItem;
    
    if(recognizer.state == UIGestureRecognizerStateChanged){
        for(currItem in itemArray){
            currImage = [currItem getImageView];
            CGPoint translation = [recognizer translationInView:self.view];
            currImage.center= CGPointMake(currImage.center.x+translation.x,currImage.center.y);
        }
        [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    }
    else if(recognizer.state ==UIGestureRecognizerStateEnded){
        //check bounds of finishing animation
        CGPoint velocity = [recognizer velocityInView:self.view];
        velocity.x/=2;
        float animTime=1.0;
        temp= [[itemArray objectAtIndex:0] getImageView];
        if(temp.center.x + velocity.x > self.view.frame.size.width/2){
            velocity.x = self.view.frame.size.width/2 - temp.center.x;
            animTime=.5;
        }
        temp= [[itemArray lastObject] getImageView];
        if(temp.center.x + ([[temp image] size].width/2) + velocity.x < 0){
            velocity.x = -(temp.center.x) + ([[temp image] size].width/2);
            animTime=.5;
        }
        //animate velocity of images
        for(currItem in itemArray){
            currImage = [currItem getImageView];
            [UIView animateWithDuration:animTime delay:0.0
                                options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAllowUserInteraction
                             animations:^{
                                 currImage.center = CGPointMake(currImage.center.x + velocity.x, currImage.center.y);
                             }
                             completion:nil];
        }
    }
}

- (void)itemTap:(UITapGestureRecognizer *)recognizer{
    
    itemViewController *newChild = [[itemViewController alloc] init];
    
    catItem *tmp;
    NSString *name;
    
    for(tmp in itemArray){
        if([tmp getImageView] == recognizer.view){
            name= [[tmp getPath] lastPathComponent];
            name= [name stringByDeletingPathExtension];
            name= [name stringByReplacingOccurrencesOfString:@"-Logo" withString:@""];
            
            NSString *path = [[NSString alloc] initWithString:[[NSBundle mainBundle] pathForResource:@"ToC" ofType:@"txt" inDirectory:_viewCat]];
            NSString *fileString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
            
            NSArray *contents = [fileString componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            
            NSString *str;
            
            [newChild setLowerBound:[[contents objectAtIndex:1] intValue]];
            [newChild setUpperBound:[[contents objectAtIndex:[contents count]-1] intValue]];
            newChild.referralItem = _item;
            
            for(str in contents){
                if([str isEqualToString:name]){
                    NSString *indexStr = [contents objectAtIndex:[contents indexOfObject:str]+1];
                    [newChild setItemIndex:[indexStr intValue]];
                    break;
                }
            }
            break;
        }
    }
    
    NSBlockOperation *pdfLoader = [NSBlockOperation blockOperationWithBlock:^{
        
        //get graphics context
        CGSize size = [[UIScreen mainScreen] bounds].size;
        UIGraphicsBeginImageContext(size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextTranslateCTM(context, 0, 768);
        CGContextScaleCTM(context, 1.75, -1.75);
        
        itemIndex = [newChild getItemIndex];
        
        //createPreviousView
        CGContextClearRect(context, [[UIScreen mainScreen] bounds]);
        CGPDFPageRef page = CGPDFDocumentGetPage([_pdf getPDF], itemIndex-1);
        CGContextDrawPDFPage(context, page);
        UIImage *pdfImg = UIGraphicsGetImageFromCurrentImageContext();
        UIImageView *prevView = [[UIImageView alloc] initWithImage:pdfImg];
        
        [newChild setPrevView:prevView];
        
        viewArray = [[NSMutableArray alloc] initWithCapacity:3];
        
        //createCurrentView
        CGContextClearRect(context, [[UIScreen mainScreen] bounds]);
        page = CGPDFDocumentGetPage([_pdf getPDF], itemIndex);
        CGContextDrawPDFPage(context, page);
        pdfImg = UIGraphicsGetImageFromCurrentImageContext();
        UIImageView *currView = [[UIImageView alloc] initWithImage:pdfImg];
        currView.frame=CGRectMake(0, 60, size.width, size.height-60);
        
        [newChild setCurrView:currView];
        [viewArray addObject:newChild];
        
        
        //createNextView
        CGContextClearRect(context, [[UIScreen mainScreen] bounds]);
        page = CGPDFDocumentGetPage([_pdf getPDF], itemIndex+1);
        CGContextDrawPDFPage(context, page);
        pdfImg = UIGraphicsGetImageFromCurrentImageContext();
        UIImageView *nextView = [[UIImageView alloc] initWithImage:pdfImg];
        
        [newChild setNextView:nextView];
        
        //clean up
        CGContextClearRect(context, [[UIScreen mainScreen] bounds]);
        [newChild setContext:context];
        
    }];
    
    [pdfLoader start];
    
    while(pdfLoader.isExecuting){/*wait*/}
    //[self.view addSubview:[[viewArray objectAtIndex:1] view]];
    [self.pageViewController setViewControllers:viewArray direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    self.pageViewController.view.backgroundColor = [[UIColor alloc] initWithWhite:1.0 alpha:1.0];
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    self.view.gestureRecognizers = self.pageViewController.gestureRecognizers;
    
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(itemViewController *)viewController{
    
    itemViewController *newView = [[itemViewController alloc] init];
    UIImageView *newPrev;
    UIImageView *newNext = [viewController getCurrView];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    //load new previous page
    CGContextClearRect(context, [[UIScreen mainScreen] bounds]);
    CGPDFPageRef page = CGPDFDocumentGetPage([_pdf getPDF], itemIndex-1);
    CGContextDrawPDFPage(context, page);
    UIImage *pdfImg = UIGraphicsGetImageFromCurrentImageContext();
    newPrev = [[UIImageView alloc] initWithImage:pdfImg];
    
    itemIndex--;
    //initialize new view
    [newView setCurrView:[viewController getPrevView]];
    [newView setPrevView:newPrev];
    [newView setNextView:newNext];
    CGContextClearRect(context, [[UIScreen mainScreen] bounds]);
    
    return newView;
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(itemViewController *)viewController{
    
    itemViewController *newView = [[itemViewController alloc] init];
    UIImageView *newPrev = [viewController getCurrView]; 
    UIImageView *newNext;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextClearRect(context, [[UIScreen mainScreen] bounds]);
    CGPDFPageRef page = CGPDFDocumentGetPage([_pdf getPDF], itemIndex+1);
    CGContextDrawPDFPage(context, page);
    UIImage *pdfImg = UIGraphicsGetImageFromCurrentImageContext();
    newNext = [[UIImageView alloc] initWithImage:pdfImg];
    
    itemIndex++;
    //initialize new view
    [newView setCurrView:[viewController getNextView]];
    [newView setPrevView:newPrev];
    [newView setNextView:newNext];
    CGContextClearRect(context, [[UIScreen mainScreen] bounds]);
    
    return newView;
    
}

- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation{
    if(UIInterfaceOrientationIsPortrait(orientation)){
        UIViewController *currentViewController = [self.pageViewController.viewControllers objectAtIndex:0];
        NSArray *viewControllers = [NSArray arrayWithObject:currentViewController];
        [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
        
        self.pageViewController.doubleSided = NO;
        
        return UIPageViewControllerSpineLocationMin;
    }
    else{
        NSArray *viewControllers = nil;
        itemViewController *currentViewController = [self.pageViewController.viewControllers objectAtIndex:0];
        
        NSUInteger currentIndex = [currentViewController getItemIndex];
        if(currentIndex == 0 || currentIndex % 2 ==0){
            itemViewController *nextViewController = [self pageViewController:self.pageViewController viewControllerAfterViewController:currentViewController];
            viewControllers = [NSArray arrayWithObjects:currentViewController, nextViewController, nil];
        }
        else{
            
            UIViewController *previousViewController = [self pageViewController:self.pageViewController viewControllerBeforeViewController:currentViewController];
            viewControllers = [NSArray arrayWithObjects:previousViewController, currentViewController, nil];
            
        }
        [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
        
        return UIPageViewControllerSpineLocationMid;
    }
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //old function for creating itemControllerView. now uses pageViewcontroller structure
    /*
    productViewController *originView = [segue sourceViewController];
    
    if([[segue identifier] isEqualToString:@"showItem"]){
        
        //initialize and start activity indicator
        UIActivityIndicatorView *indicator;
        
        if(!indicator){
            CGSize size = [[UIScreen mainScreen] bounds].size;
            indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            
            indicator.color=[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
            
            indicator.frame=CGRectMake(size.width/2, size.height/2, 25, 25);
            indicator.hidesWhenStopped = YES;
        }
        
        [originView.view addSubview:indicator];
        [indicator startAnimating];
        
        itemViewController *destView = [segue destinationViewController];
        catItem *tmp;
        NSString *name;
        destView.viewCat = [originView viewCat];
        destView.pdf = _pdf;
        for(tmp in itemArray){
            if([tmp getImageView] == sender){
                name= [[tmp getPath] lastPathComponent];
                name= [name stringByDeletingPathExtension];
                name= [name stringByReplacingOccurrencesOfString:@"-Logo" withString:@""];
                
                NSString *path = [[NSString alloc] initWithString:[[NSBundle mainBundle] pathForResource:@"ToC" ofType:@"txt" inDirectory:_viewCat]];
                NSString *fileString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
                
                NSArray *contents = [fileString componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                        
                NSString *str;
                
                [destView setLowerBound:[[contents objectAtIndex:1] intValue]];
                [destView setUpperBound:[[contents objectAtIndex:[contents count]-1] intValue]];
                destView.referralItem = _item;
                
                for(str in contents){
                    if([str isEqualToString:name]){
                        NSString *indexStr = [contents objectAtIndex:[contents indexOfObject:str]+1];
                        [destView setItemIndex:[indexStr intValue]];
                        break;
                    }
                }
                break;
            }
        }
        //set up asynchronous block operation
        NSBlockOperation *pdfLoader = [NSBlockOperation blockOperationWithBlock:^{
            
            //get graphics context
            CGSize size = [[UIScreen mainScreen] bounds].size;
            UIGraphicsBeginImageContext(size);
            CGContextRef context = UIGraphicsGetCurrentContext();
            
            CGContextTranslateCTM(context, 0, 768);
            CGContextScaleCTM(context, 1.75, -1.75);
            
            int itemIndex = [destView getItemIndex];
            
            //createCurrentView
            CGPDFPageRef page = CGPDFDocumentGetPage([_pdf getPDF], itemIndex);
            CGContextDrawPDFPage(context, page);
            UIImage *pdfImg = UIGraphicsGetImageFromCurrentImageContext();
            UIImageView *currView = [[UIImageView alloc] initWithImage:pdfImg];
            currView.frame=CGRectMake(0, 60, size.width, size.height-60);
            [destView setCurrView:currView];
            
            //createPreviousView
            CGContextClearRect(context, [[UIScreen mainScreen] bounds]);
            page = CGPDFDocumentGetPage([_pdf getPDF], itemIndex-1);
            CGContextDrawPDFPage(context, page);
            pdfImg = UIGraphicsGetImageFromCurrentImageContext();
            UIImageView *prevView = [[UIImageView alloc] initWithImage:pdfImg];
            [destView setPrevView:prevView];
            
            //createNextView
            CGContextClearRect(context, [[UIScreen mainScreen] bounds]);
            page = CGPDFDocumentGetPage([_pdf getPDF], itemIndex+1);
            CGContextDrawPDFPage(context, page);
            pdfImg = UIGraphicsGetImageFromCurrentImageContext();
            UIImageView *nextView = [[UIImageView alloc] initWithImage:pdfImg];
            [destView setNextView:nextView];
            
            //clean up
            CGContextClearRect(context, [[UIScreen mainScreen] bounds]);
            [destView setContext:context];
            
        }];
        
        [pdfLoader setCompletionBlock:^{
            [indicator stopAnimating];
            [indicator removeFromSuperview];
        }];
        
        //execute asynchronous block
        [pdfLoader start];        
        
    }
    else if([[segue identifier] isEqualToString:@"backToCat"]){
        categoryViewController *destView = [segue destinationViewController];
        
        destView.viewCat = [[_viewCat stringByDeletingLastPathComponent] stringByDeletingPathExtension];
        destView.pdf = _pdf;
    }
    */
}
- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

- (void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    if(toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight){
        _titleLabel.center = CGPointMake(512, 60);
        _backButton.center = CGPointMake(54,22);
        logoView.center = CGPointMake(512,475);
    }
    else{
        _titleLabel.center = CGPointMake(384, 60);
        logoView.center = CGPointMake((self.view.frame.size.width/2), 600);
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    if ((orientation == UIInterfaceOrientationPortrait) || (orientation == UIInterfaceOrientationPortraitUpsideDown) ||
        (orientation == UIInterfaceOrientationLandscapeLeft) || (orientation == UIInterfaceOrientationLandscapeRight))
        return YES;
    
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTitleLabel:nil];
    [self setBackButton:nil];
    [super viewDidUnload];
}
@end
