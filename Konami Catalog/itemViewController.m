//
//  itemViewController.m
//  Konami Catalog
//
//  Created by Interactive Intern on 11/12/12.
//  Copyright (c) 2012 Interactive Intern. All rights reserved.
//

#import "itemViewController.h"
#import "categoryViewController.h"
#import "konamiSwiper.h"

@interface itemViewController ()

@end

@implementation itemViewController

- (void)setItemIndex:(int)i{
    itemIndex = i;
}

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
    
    if(UIDeviceOrientationIsLandscape([self interfaceOrientation])){
        _backButton.center = CGPointMake(32,26);
        size=CGSizeMake(1024, 768);
    }
    else{
        size=CGSizeMake(768, 1024);
    }
   
    
    
    //add gesture recognizers
    backGest = [[konamiSwiper alloc] initWithTarget:self action:@selector(swipeBack:)];
    forwardGest = [[konamiSwiper alloc] initWithTarget:self action:@selector(swipeForward:)];
    
    backGest.direction = UISwipeGestureRecognizerDirectionRight;
    forwardGest.direction = UISwipeGestureRecognizerDirectionLeft;
    
    self.view.backgroundColor = [[UIColor alloc] initWithWhite:1.0 alpha:1.0];
    [self.view addGestureRecognizer:(backGest)];
    [self.view addGestureRecognizer:(forwardGest)];
    
    [self.view addSubview:currView];
     
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    productViewController *destView = [segue destinationViewController];
    itemViewController *originView = [segue sourceViewController];
    if([[segue identifier] isEqualToString:@"backToProduct"]){
        destView.viewCat = [[originView viewCat] stringByDeletingLastPathComponent];
        destView.item = _referralItem;
        destView.pdf = _pdf;
    }
}


- (void)swipeForward:(UISwipeGestureRecognizer *)sender {
    /*
    //advances to next slide
    if(sender.direction == UISwipeGestureRecognizerDirectionLeft){
        if(itemIndex < categoryUpperBound){
            
            itemIndex++;
            //disable gestures
            backGest.enabled=NO;
            forwardGest.enabled=NO;
            //prepare views for animation
            nextView.frame=CGRectMake(1500, 60, size.width, size.height-60);
            
            [self.view addSubview:nextView];
            
            [UIView animateWithDuration:1.0 animations:^{
                nextView.center = CGPointMake(size.width/2, (size.height/2)+30);
            }];
            
            [UIView animateWithDuration:1.0 animations:^{
                currView.center = CGPointMake(-1000, (size.height/2)+30);
            }completion:^(BOOL finished){
                //update slide images
                
                prevView = [[UIImageView alloc] initWithImage:currView.image];
                
                [currView removeFromSuperview];
                currView=[[UIImageView alloc] initWithImage:nextView.image];
                currView.frame=CGRectMake(0, 60, size.width, size.height-60);
                [self.view addSubview:currView];
                
                [nextView removeFromSuperview];
                page = CGPDFDocumentGetPage([_pdf getPDF], itemIndex+1);
                CGContextFlush(context);
                CGContextDrawPDFPage(context, page);
                UIImage *pdfImg = UIGraphicsGetImageFromCurrentImageContext();
                nextView = [[UIImageView alloc] initWithImage:pdfImg];
                backGest.enabled=YES;
                forwardGest.enabled=YES;
             }];
            
            
            CGContextClearRect(context, [[UIScreen mainScreen] bounds]);

        }
    }
     */
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:NO];
    
    
    //get graphics context
    size = [[UIScreen mainScreen] bounds].size;
    UIGraphicsBeginImageContext(size);
    context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, 0, 768);
    CGContextScaleCTM(context, 1.75, -1.75);
    
    
    
}

- (void) swipeBack:(UISwipeGestureRecognizer *)recognizer{
    /*
    //returns to previous slide
    if(recognizer.direction == UISwipeGestureRecognizerDirectionRight){
        
        if(itemIndex >=categoryLowerBound){
            itemIndex--;

            //disable getures
            backGest.enabled=NO;
            forwardGest.enabled=NO;
            //prepare views for animation
            prevView.frame=CGRectMake(-1000, 60, size.width, size.height-60);
            
            [self.view addSubview:prevView];
            
            [UIView animateWithDuration:1.0 animations:^{
                prevView.center = CGPointMake(size.width/2, (size.height/2)+30);
            }];
            
            [UIView animateWithDuration:1.0 animations:^{
                currView.center = CGPointMake(1500, (size.height/2)+30);
            }completion:^(BOOL finished){
                //update slide images
                
                nextView=[[UIImageView alloc] initWithImage:currView.image];
                
                [currView removeFromSuperview];
                currView = [[UIImageView alloc] initWithImage:prevView.image];
                currView.frame=CGRectMake(0, 60, size.width, size.height-60);
                [self.view addSubview:currView];
                
                [prevView removeFromSuperview];
                page = CGPDFDocumentGetPage([_pdf getPDF], itemIndex-1);
                CGContextDrawPDFPage(context, page);
                UIImage *pdfImg = UIGraphicsGetImageFromCurrentImageContext();
                prevView = [[UIImageView alloc] initWithImage:pdfImg];
                backGest.enabled=YES;
                forwardGest.enabled=YES;
            }];
            CGContextClearRect(context, [[UIScreen mainScreen] bounds]);

        }
    }
     */
}

- (void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    _backButton.center = CGPointMake(56, 22);
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

- (void)setUpperBound:(int)i{
    
    categoryUpperBound = i;
    
}

- (void) setLowerBound:(int)i{
    
    categoryLowerBound = i;
    
}

- (int)getItemIndex{
    
    return itemIndex;
    
}

- (UIImageView *) getNextView{
    return nextView;
}

- (UIImageView *) getPrevView{
    return prevView;
}

- (UIImageView *)getCurrView{
    return currView;
}

- (void) setSize:(CGSize)screenSize{
    size = screenSize;
}

- (void) setPage:(CGPDFPageRef)pdfPage{
    page = pdfPage;
}

- (void) setNextView:(UIImageView *)view{
    nextView = view;
}

- (itemViewController *) setCurrView:(UIImageView *)view{
    currView = view;
    
    return self;
}

- (void) setPrevView:(UIImageView *)view{
    prevView = view;
}

- (void) setContext:(CGContextRef)ctx{
    context = ctx;
}

- (void)viewDidUnload {
    [self setBackButton:nil];
    [super viewDidUnload];
}
@end
