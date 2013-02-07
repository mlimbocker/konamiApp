//
//  konamiSwiper.m
//  Konami Catalog
//
//  Created by Interactive Intern on 11/21/12.
//  Copyright (c) 2012 Interactive Intern. All rights reserved.
//

#import "konamiSwiper.h"

@implementation konamiSwiper

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    return YES;
    
}

@end
