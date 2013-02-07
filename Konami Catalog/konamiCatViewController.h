//
//  konamiCatViewController.h
//  Konami Catalog
//
//  Created by Interactive Intern on 11/5/12.
//  Copyright (c) 2012 Interactive Intern. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface konamiCatViewController : UIViewController{
    
    NSMutableArray *imgArray;
    
}
@property (strong, nonatomic) IBOutlet UIImageView *titleView;
@property (strong, nonatomic) IBOutlet UILabel *titleLbl;
@property (strong, nonatomic) IBOutlet UILabel *swipeLbl;
- (IBAction)titleSwipe:(UISwipeGestureRecognizer *)sender;


@end
