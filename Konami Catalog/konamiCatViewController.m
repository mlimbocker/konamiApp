//
//  konamiCatViewController.m
//  Konami Catalog
//
//  Created by Interactive Intern on 11/5/12.
//  Copyright (c) 2012 Interactive Intern. All rights reserved.
//

#import "konamiCatViewController.h"

@interface konamiCatViewController ()

@end

@implementation konamiCatViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    if(UIDeviceOrientationIsLandscape([self interfaceOrientation])){
        self.view.frame = CGRectMake(0, 0, 1024, 768);
        
        _titleLbl.center = CGPointMake(self.view.frame.size.width/2, 625);
        _swipeLbl.center = CGPointMake(self.view.frame.size.width/2, 700);
        _titleView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)titleSwipe:(UISwipeGestureRecognizer *)sender {
    [self performSegueWithIdentifier:@"titleToMenu" sender:self];
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    CGRect screen = [[UIScreen mainScreen] bounds];
    float pos_y, pos_x;
    pos_y = UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation]) ? screen.size.width/2  : screen.size.height/2;
    pos_x = UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation]) ? screen.size.height/2 : screen.size.width/2;
    
    _titleView.center = CGPointMake(pos_x, pos_y);
    
    if((toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) || (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)){
        _titleLbl.center = CGPointMake(pos_x, 625);
        _swipeLbl.center = CGPointMake(pos_x, 700);
    }
    else{
        _titleLbl.center = CGPointMake(pos_x, 783);
        _swipeLbl.center = CGPointMake(pos_x, 928);
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

- (void)viewDidUnload {
    [self setTitleLbl:nil];
    [self setSwipeLbl:nil];
    [super viewDidUnload];
}
@end
