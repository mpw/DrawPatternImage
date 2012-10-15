//
//  MPWCGDrawingStream.h
//  MusselWind
//
//  Created by Marcel Weiher on 8.12.09.
//  Copyright 2009-2010 Marcel Weiher. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuartzGeometry.h"
#import "MPWDrawingContext.h"

#import "AccessorMacros.h"

@interface MPWCGDrawingContext: NSObject <MPWDrawingContext> {
	CGContextRef context;
    id currentFont;
    float fontSize;
}

scalarAccessor_h( CGContextRef, context, setContext )
-initWithCGContext:(CGContextRef)newContext;
+contextWithCGContext:(CGContextRef)c;
+currentContext;

-(void)resetTextMatrix;


#if !TARGET_OS_IPHONE
-concatNSAffineTransform:(NSAffineTransform*)transform;
#endif

@end

@interface MPWCGLayerContext : MPWCGDrawingContext 
{
    CGLayerRef layer;
}

-(id)initWithCGContext:(CGContextRef)baseContext size:(NSSize)s;

@end

@interface MPWCGPDFContext : MPWCGDrawingContext
{
}

+pdfContextWithTarget:target mediaBox:(NSRect)bbox;
+pdfContextWithTarget:target size:(NSSize)pageSize;
+pdfContextWithTarget:target;

-(void)beginPage:(NSDictionary*)parameters;
-(void)endPage;
-(void)close;

@end

@interface MPWCGBitmapContext : MPWCGDrawingContext

-initBitmapContextWithSize:(NSSize)size colorSpace:(CGColorSpaceRef)colorspace;


+rgbBitmapContext:(NSSize)size;
+cmykBitmapContext:(NSSize)size;
-image;

@end
