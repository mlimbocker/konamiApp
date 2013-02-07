//
//  itemViewController.h
//  Konami Catalog
//
//  Created by Interactive Intern on 11/12/12.
//  Copyright (c) 2012 Interactive Intern. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreFoundation/CoreFoundation.h>
#import "catItem.h"
#import "konamiSwiper.h"
#import "pdfHolder.h"

@interface itemViewController : UIViewController{
    NSMutableArray *textLines;
    UIImageView *currView, *nextView, *prevView;
    konamiSwiper *backGest, *forwardGest;
    CGContextRef context, cleared;
    CGPDFPageRef page;
    int itemIndex, categoryLowerBound, categoryUpperBound;
    CGSize size;
}

@property (strong, nonatomic) NSString *viewCat;

@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) catItem *referralItem;

@property (strong, nonatomic) pdfHolder *pdf;

- (void)swipeForward:(UISwipeGestureRecognizer *)sender;
- (void)swipeBack:(UISwipeGestureRecognizer *)recognizer;

- (void) setItemIndex:(int)i;
- (void) setUpperBound:(int)i;
- (void) setLowerBound:(int)i;

- (int) getItemIndex;

- (void) setSize:(CGSize)size;
- (void) setContext:(CGContextRef)ctx;
- (void) setPage:(CGPDFPageRef)pdfPage;
- (itemViewController *) setCurrView:(UIImageView *)view;
- (void) setPrevView:(UIImageView *)view;
- (void) setNextView:(UIImageView *)view;

- (UIImageView *) getNextView;
- (UIImageView *) getCurrView;
- (UIImageView *) getPrevView;

@end
