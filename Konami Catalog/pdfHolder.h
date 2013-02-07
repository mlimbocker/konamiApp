//
//  pdfHolder.h
//  Konami Catalog
//
//  Created by Interactive Intern on 12/5/12.
//  Copyright (c) 2012 Interactive Intern. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface pdfHolder : NSObject{
    
    CFURLRef pdfurl;
    CGPDFDocumentRef pdf;

}

-(pdfHolder *) initialize:(CFURLRef) pdfurl;

- (void) setPDF:(pdfHolder *)obj;

-(CGPDFDocumentRef) getPDF;

@end
