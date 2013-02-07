//
//  mainMenuViewController.m
//  Konami Catalog
//
//  Created by Interactive Intern on 11/5/12.
//  Copyright (c) 2012 Interactive Intern. All rights reserved.
//

#import "mainMenuViewController.h"
#import "categoryViewController.h"

@interface mainMenuViewController ()

@end

@implementation mainMenuViewController

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
    
    _videoImg.center = CGPointMake(1070, 150);
    _stepperImg.center = CGPointMake(1070, 502);
    _ppImg.center = CGPointMake(1070, 834);
    
    if(UIDeviceOrientationIsLandscape([self interfaceOrientation])){
        self.view.frame = CGRectMake(0, 0, 1024, 768);
        
         _videoView.frame   = CGRectMake(0, 1, 1024, 256);
         _stepperView.frame = CGRectMake(0, 256, 1024, 256);
         _ppView.frame      = CGRectMake(0, 512, 1024, 256);
        
         
    }
    
    [UIView animateWithDuration:1.0 delay:0.5 options:UIViewAnimationCurveEaseOut
            animations:^{
                _videoImg.center = CGPointMake(170, 128);
            }
                     completion:NULL
     ];
    
    
    [UIView animateWithDuration:1.0 delay:0.5 options:UIViewAnimationCurveEaseOut
                     animations:^{
                         _stepperImg.center = CGPointMake(170, 128);
                     }
                     completion:NULL
     ];
    
    
    [UIView animateWithDuration:1.0 delay:0.5 options:UIViewAnimationCurveEaseOut
                     animations:^{
                         _ppImg.center = CGPointMake(170, 128);
                     }
                     completion:NULL
     ];
 
    _videoLbl.alpha = 0;
    [UIView animateWithDuration:1.0 delay:1.5 options:UIViewAnimationCurveLinear
                     animations:^{
                         _videoLbl.alpha = 1.0;
                     }
                     completion:NULL
     ];
    
    _stepperLbl.alpha = 0;
    [UIView animateWithDuration:1.0 delay:1.5 options:UIViewAnimationCurveLinear
                     animations:^{
                         _stepperLbl.alpha = 1.0;
                     }
                     completion:NULL
     ];
    
    _premLbl.alpha = 0;
    [UIView animateWithDuration:1.0 delay:1.5 options:UIViewAnimationCurveLinear
                     animations:^{
                         _premLbl.alpha = 1.0;
                     }
                     completion:NULL
     ];
    
    _ampLbl.alpha = 0;
    [UIView animateWithDuration:1.0 delay:1.5 options:UIViewAnimationCurveLinear
                     animations:^{
                         _ampLbl.alpha = 1.0;
                     }
                     completion:NULL
     ];
    
    _progLbl.alpha = 0;
    [UIView animateWithDuration:1.0 delay:1.5 options:UIViewAnimationCurveLinear
                     animations:^{
                         _progLbl.alpha = 1.0;
                     }
                     completion:NULL
     ];
    if(!_pdf)
        _pdf = [[pdfHolder alloc] initialize:CFBundleCopyResourceURL(CFBundleGetMainBundle(), CFSTR("KONA_Product_Catalog_2012_FA"), CFSTR("pdf"), NULL)];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)videoTap:(UITapGestureRecognizer *)recognizer {
    [self performSegueWithIdentifier:@"videoSegue" sender:self];
    
}

- (IBAction)stepperTap:(UITapGestureRecognizer *)sender {
    [self performSegueWithIdentifier:@"stepperSegue" sender:self];
}

- (IBAction)ppTap:(UITapGestureRecognizer *)sender {
    [self performSegueWithIdentifier:@"ppSegue" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    categoryViewController *destView = [segue destinationViewController];
    
    
    destView.pdf = _pdf;
    if ([[segue identifier] isEqualToString:@"videoSegue"]) {
        destView.viewCat = @"/Video";
    }
    else if ([[segue identifier] isEqualToString:@"stepperSegue"]){
        destView.viewCat = @"/Stepper";
    }
    else if ([[segue identifier] isEqualToString:@"ppSegue"]){
        destView.viewCat = @"/PandP";
    }
}

- (void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    CGRect screen = CGRectMake(0, 0, 1004, 768);
    if(toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight){
        _ppView.frame = CGRectMake(0, 512, screen.size.width, 256);
        _stepperView.frame = CGRectMake(0, 256, screen.size.width, 256);
        _videoView.frame = CGRectMake(0, 0, screen.size.width, 256);
    }
    else{
        _ppView.frame = CGRectMake(0, 512, screen.size.width, 256);
        _stepperView.frame = CGRectMake(0, 256, screen.size.width, 256);
        _videoView.frame = CGRectMake(0, 0, screen.size.width, 256);
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
    [self setVideoView:nil];
    [self setStepperView:nil];
    [self setPpView:nil];
    [super viewDidUnload];
}
@end
