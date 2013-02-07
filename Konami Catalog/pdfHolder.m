//
//  pdfHolder.m
//  Konami Catalog
//
//  Created by Interactive Intern on 12/5/12.
//  Copyright (c) 2012 Interactive Intern. All rights reserved.
//

#import "pdfHolder.h"

@implementation pdfHolder


-(pdfHolder *)initialize:(CFURLRef)url{

    pdfurl=url;
    pdf=CGPDFDocumentCreateWithURL(pdfurl);
    
    return self;
}

-(void)setPDF:(pdfHolder *)obj{

    pdfurl=obj->pdfurl;
    pdf=obj->pdf;

}

-(CGPDFDocumentRef)getPDF{
    
    return pdf;
    
}
@end
