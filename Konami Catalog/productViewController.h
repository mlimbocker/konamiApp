//
//  productViewController.h
//  Konami Catalog
//
//  Created by Interactive Intern on 11/30/12.
//  Copyright (c) 2012 Interactive Intern. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "catItem.h"
#import "itemViewController.h"
#import "categoryViewController.h"


@interface productViewController : UIViewController{
    NSMutableArray *itemArray, *viewArray;
    UIImageView *logoView;
    int itemIndex;
}

@property (strong, nonatomic) NSString *viewCat;
@property (strong, nonatomic) catItem *item;
@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) UIPageViewController *pageViewController;

@property (strong, nonatomic) pdfHolder *pdf;

- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer;
@end
