//
//  catItem.h
//  Konami Catalog
//
//  Created by Interactive Intern on 11/12/12.
//  Copyright (c) 2012 Interactive Intern. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface catItem : NSObject{
    NSString *itemName;
    NSString *itemPath;
    UIImageView *imageView;
}

- (catItem*) initWithName:(NSString *) name;
- (catItem*) initWithNameAndPath:(NSString *) name:(NSString *) path;
- (UIImageView*) getImageView;
- (NSString *) getName;
- (NSString *) getPath;
- (void) addImageView:(UIImageView *) view;

@end
