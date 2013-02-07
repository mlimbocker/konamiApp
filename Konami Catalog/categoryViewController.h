//
//  categoryViewController.h
//  Konami Catalog
//
//  Created by Interactive Intern on 11/7/12.
//  Copyright (c) 2012 Interactive Intern. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mainMenuViewController.h"
#import "productViewController.h"

@interface categoryViewController : UIViewController{
    NSMutableArray *itemArray;
    NSString *category;

}
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *bgImage;
@property (strong, nonatomic) NSString *viewCat;
@property (strong, nonatomic) IBOutlet UIButton *backButton;

@property(strong,nonatomic) pdfHolder *pdf;

-(IBAction)handlePan:(UIPanGestureRecognizer *)recognizer;
@end
