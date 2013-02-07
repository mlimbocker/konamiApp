//
//  mainMenuViewController.h
//  Konami Catalog
//
//  Created by Interactive Intern on 11/5/12.
//  Copyright (c) 2012 Interactive Intern. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "categoryViewController.h"
#import "pdfHolder.h"

@interface mainMenuViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *videoImg;
@property (strong, nonatomic) IBOutlet UIImageView *stepperImg;
@property (strong, nonatomic) IBOutlet UIImageView *ppImg;
@property (strong, nonatomic) IBOutlet UILabel *stepperLbl;
@property (strong, nonatomic) IBOutlet UILabel *videoLbl;
@property (strong, nonatomic) IBOutlet UILabel *premLbl;
@property (strong, nonatomic) IBOutlet UILabel *ampLbl;
@property (strong, nonatomic) IBOutlet UILabel *progLbl;
@property (strong, nonatomic) IBOutlet UIView *videoView;
@property (strong, nonatomic) IBOutlet UIView *stepperView;
@property (strong, nonatomic) IBOutlet UIView *ppView;

@property (strong,nonatomic) pdfHolder *pdf;

- (IBAction)videoTap:(UITapGestureRecognizer *)recognizer;
- (IBAction)stepperTap:(UITapGestureRecognizer *)sender;
- (IBAction)ppTap:(UITapGestureRecognizer *)sender;


@end
