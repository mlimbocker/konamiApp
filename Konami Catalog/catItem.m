//
//  catItem.m
//  Konami Catalog
//
//  Created by Interactive Intern on 11/12/12.
//  Copyright (c) 2012 Interactive Intern. All rights reserved.
//

#import "catItem.h"

@implementation catItem

- (catItem*) initWithName:(NSString *)name{
    itemName = name;
    
    return self;
}

- (catItem*) initWithNameAndPath:(NSString *)name :(NSString *)path{
    itemName = name;
    itemPath = path;
    
    return self;
}

- (void) addImageView:(UIImageView *)view{
    imageView = view;
}

- (UIImageView *) getImageView{
    return imageView;
}

-(NSString*)getName{
    return itemName;
}

- (NSString *)getPath{
    return itemPath;
}
@end
