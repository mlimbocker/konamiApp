//
//  konamiSwiper.h
//  Konami Catalog
//
//  Created by Interactive Intern on 11/21/12.
//  Copyright (c) 2012 Interactive Intern. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface konamiSwiper : UISwipeGestureRecognizer

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer;

@end
