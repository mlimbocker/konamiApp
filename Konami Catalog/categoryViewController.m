//
//  categoryViewController.m
//  Konami Catalog
//
//  Created by Interactive Intern on 11/7/12.
//  Copyright (c) 2012 Interactive Intern. All rights reserved.
//

#import "categoryViewController.h"
#import "itemViewController.h"
#import "catItem.h"


@interface categoryViewController ()

@end

@implementation categoryViewController

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
        _bgImage.center = CGPointMake(512, 384);
        _titleLabel.center = CGPointMake(512, 60);
        _backButton.center = CGPointMake(32,26);
    }
    
    NSString *bgPath;
    
    if([_viewCat isEqualToString:@"/Video"]){
        _titleLabel.text = @"Video Products";
        bgPath = [[NSString alloc] initWithString:[[NSBundle mainBundle] pathForResource:@"Video-Cover-Lg" ofType:@"png"]];
        _bgImage.image = [[UIImage alloc] initWithContentsOfFile:bgPath];
    }
    else if([_viewCat isEqualToString:@"/PandP"]){
        _titleLabel.text = @"Premiums & Progressives";
        bgPath = [[NSString alloc] initWithString:[[NSBundle mainBundle] pathForResource:@"PP-Cover-Lg" ofType:@"png"]];
        _bgImage.image = [[UIImage alloc] initWithContentsOfFile:bgPath];
    }
    else if([_viewCat isEqualToString:@"/Stepper"]){
        _titleLabel.text = @"Steppers";
        bgPath = [[NSString alloc] initWithString:[[NSBundle mainBundle] pathForResource:@"Stepper-Cover-Lg" ofType:@"png"]];
        _bgImage.image = [[UIImage alloc] initWithContentsOfFile:bgPath];
    }
    
    NSBundle *bundle = [NSBundle mainBundle];
    
    NSString *directory = [_viewCat stringByAppendingString:@"/Products"];
    
    NSArray *files = [[NSArray alloc] initWithArray:[bundle pathsForResourcesOfType:@"png" inDirectory:directory]];
    NSString *str;
    
    UIImage *img;
    CGRect viewRect;
    UIImageView *newImage;
    catItem *newItem;
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    productViewController *destView = [segue destinationViewController];
    categoryViewController *originView = [segue sourceViewController];
    catItem *tmp;
    
    destView.pdf = _pdf;
    if([[segue identifier] isEqualToString:@"productSegue"]){
        destView.viewCat = [originView viewCat];
        for(tmp in itemArray){
            if([tmp getImageView] == sender){
                destView.item = tmp;
                destView.viewCat = _viewCat;
            }
        }
    }
    else{
        destView.pdf = _pdf;
    }
    
}

- (void)itemTap:(UITapGestureRecognizer *)recognizer{
    [self performSegueWithIdentifier:@"productSegue" sender:recognizer.view];
    
}

- (void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    if(toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight){
        _bgImage.center = CGPointMake(512, 384);
        _titleLabel.center = CGPointMake(512, 60);
        _backButton.center = CGPointMake(54,22);
    }
    else{
        _bgImage.center = CGPointMake(384, 620);
        _titleLabel.center = CGPointMake(384, 60);
    }
}

- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    if ((orientation == UIInterfaceOrientationPortrait) || (orientation == UIInterfaceOrientationPortraitUpsideDown) ||
        (orientation == UIInterfaceOrientationLandscapeLeft) || (orientation == UIInterfaceOrientationLandscapeRight))
        return YES;
    
    return NO;
}
- (void)viewDidUnload {
    [self setBackButton:nil];
    [super viewDidUnload];
}
@end
