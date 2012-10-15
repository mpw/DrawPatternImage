//
//  ViewController.m
//  DrawPatternImage
//
//  Created by Mark Granoff on 9/25/12.
//  Copyright (c) 2012 Hawk iMedia. All rights reserved.
//

#import "ViewController.h"
#import "MPWView_iOS.h"
#import "MPWDrawingContext.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

CGContextRef CreateBitmapContext(int width, int height, CGColorSpaceRef colorSpace, CGImageAlphaInfo alpha)
{
    CGContextRef    context = NULL;
    int bitmapBytesPerRow   = (width * 4);
    
    context = CGBitmapContextCreate (NULL, //bitmapData
                                     width,
                                     height,
                                     8,      // bits per component
                                     bitmapBytesPerRow,
                                     colorSpace,
                                     alpha);
    
    return context;
}

-(UIImage *)patternImageWithSize:(CGSize)patternSize forRectSize:(CGSize)size
{
    // Upsize the pattern dimensions to fill as evenly as possible both horizontally and vertically
    size_t myWidth = patternSize.width;
    size_t myHeight = patternSize.height;
    // Comment out these two 'while' statements to just get a pattern of the specified size, but it may
    // show partial images along the right and bottom edge if used as a background "color"
    while ((size_t)size.width % myWidth > 1)
        myWidth++;
    
    while ((size_t)size.height % myHeight > 1)
        myHeight++;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef myBitmapContext = CreateBitmapContext(myWidth, myHeight, colorSpace, kCGImageAlphaPremultipliedLast);
    CGColorSpaceRelease(colorSpace);
    
    // Fill the square with black.
    CGContextSetRGBFillColor (myBitmapContext, 0, 0, 0, 1);
    CGContextFillRect (myBitmapContext, CGRectMake (0, 0, myWidth, myHeight ));
    
    // Fill an inner diamond with red
    CGContextSetRGBFillColor(myBitmapContext, 1, 0, 0, 1);
    CGContextBeginPath(myBitmapContext);
    CGContextMoveToPoint(myBitmapContext, myWidth/2.0, 2);
    CGContextAddLineToPoint(myBitmapContext, myWidth-2.0, myHeight/2.0);
    CGContextAddLineToPoint(myBitmapContext, myWidth/2.0, myHeight-2.0);
    CGContextAddLineToPoint(myBitmapContext, 2, myHeight/2.0);
    CGContextAddLineToPoint(myBitmapContext, myWidth/2.0, 2);
    CGContextClosePath(myBitmapContext);
    CGContextFillPath(myBitmapContext);
    
    // Create an image ref from the context
    CGImageRef imageRef = CGBitmapContextCreateImage (myBitmapContext);
    CGContextRelease (myBitmapContext);

    // Turn the image ref into a UIImage that can be used with UIColor's -colorWithPatternImage:
    UIImage *image = [UIImage imageWithCGImage:imageRef scale:[[UIScreen mainScreen] scale] orientation:UIImageOrientationUp];
    
    CGImageRelease(imageRef);
    
    return image;
}

-(UIImage *)filledDoughnutForSize:(CGSize)size
{
    size_t myWidth = size.width;
    size_t myHeight = size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef myBitmapContext = CreateBitmapContext(myWidth, myHeight, colorSpace, kCGImageAlphaPremultipliedLast);
    CGColorSpaceRelease(colorSpace);

    // Draw a circle in the square
    CGFloat offsetX = 2;
    CGFloat offsetY = 2;
    CGFloat diameter = MIN(myWidth-2, myHeight-2);
    if (myWidth < myHeight)
        offsetY += (myHeight - myWidth) / 2.0;
    if (myHeight < myWidth)
        offsetX += (myWidth - myHeight) / 2.0;
    
    // Fill an inner circle with green
    CGContextSetRGBFillColor(myBitmapContext, 0, 1, 0, 1);
    CGContextAddPath(myBitmapContext, [UIBezierPath bezierPathWithRoundedRect:CGRectMake(offsetX, offsetY, diameter, diameter)
                                                            byRoundingCorners:UIRectCornerAllCorners
                                                                  cornerRadii:CGSizeMake(diameter/2.0, diameter/2.0)].CGPath);
    CGContextFillPath(myBitmapContext);
    
    // Fill a circle inside the first one with white
    CGFloat adjustment = myWidth/4;
    offsetX += adjustment;
    offsetY += adjustment;
    diameter -= 2*adjustment;
    CGContextSetRGBFillColor(myBitmapContext, 1, 1, 1, 1);
    CGContextAddPath(myBitmapContext, [UIBezierPath bezierPathWithRoundedRect:CGRectMake(offsetX, offsetY, diameter, diameter)
                                                            byRoundingCorners:UIRectCornerAllCorners
                                                                  cornerRadii:CGSizeMake(diameter/2.0, diameter/2.0)].CGPath);
    CGContextFillPath(myBitmapContext);
    
    // Create an image ref from the context
    CGImageRef imageRef = CGBitmapContextCreateImage (myBitmapContext);
    CGContextRelease (myBitmapContext);
    
    // Turn the image ref into a UIImage 
    UIImage *image = [UIImage imageWithCGImage:imageRef scale:[[UIScreen mainScreen] scale] orientation:UIImageOrientationUp];
    
    CGImageRelease(imageRef);
    
    return image;
}

-(UIImage *)emptyDoughnutForSize:(CGSize)size
{
    size_t myWidth = size.width;
    size_t myHeight = size.height;
    
    // Draw a circle in the square
    CGFloat offsetX = 2;
    CGFloat offsetY = 2;
    CGFloat diameter = MIN(myWidth-2, myHeight-2);
    if (myWidth < myHeight)
        offsetY += (myHeight - myWidth) / 2.0;
    if (myHeight < myWidth)
        offsetX += (myWidth - myHeight) / 2.0;
    
    CGImageRef imageRef;
    {
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGContextRef myBitmapContext = CreateBitmapContext(myWidth, myHeight, colorSpace, kCGImageAlphaPremultipliedLast);
        CGColorSpaceRelease(colorSpace);
        
        // Fill an inner circle with green
        CGContextSetRGBFillColor(myBitmapContext, 0, 1, 0, 1);
        CGContextAddPath(myBitmapContext, [UIBezierPath bezierPathWithRoundedRect:CGRectMake(offsetX, offsetY, diameter, diameter)
                                                                byRoundingCorners:UIRectCornerAllCorners
                                                                      cornerRadii:CGSizeMake(diameter/2.0, diameter/2.0)].CGPath);
        CGContextFillPath(myBitmapContext);
        
        // Create an image ref from the context
        imageRef = CGBitmapContextCreateImage (myBitmapContext);
        CGContextRelease (myBitmapContext);
    }
    
    // We need to create a mask for the area of our drawing that we want no color to appear.
    // We do that using a greyscale context.

    CGImageRef maskImageRef;
    {
        CGColorSpaceRef colorSpaceGray = CGColorSpaceCreateDeviceGray();
        CGContextRef myBitmapContextGray = CreateBitmapContext(myWidth, myHeight, colorSpaceGray, kCGImageAlphaNone);
        CGColorSpaceRelease( colorSpaceGray );

        // Fill the square with white. This is the part to keep.
        CGContextSetGrayFillColor(myBitmapContextGray, 1, 1);
        CGContextAddRect(myBitmapContextGray, CGRectMake(0, 0, myWidth, myHeight));
        CGContextFillPath(myBitmapContextGray);

        // Fill a circle inside the first one with black. This is the part to discard.
        CGFloat adjustment = myWidth/4;
        offsetX += adjustment;
        offsetY += adjustment;
        diameter -= 2*adjustment;
        CGContextSetGrayFillColor(myBitmapContextGray, 0, 1);
        CGContextAddPath(myBitmapContextGray, [UIBezierPath bezierPathWithRoundedRect:CGRectMake(offsetX, offsetY, diameter, diameter)
                                                                byRoundingCorners:UIRectCornerAllCorners
                                                                      cornerRadii:CGSizeMake(diameter/2.0, diameter/2.0)].CGPath);
        CGContextFillPath(myBitmapContextGray);
        
        // Create an image ref from the context
        maskImageRef = CGBitmapContextCreateImage (myBitmapContextGray);
        CGContextRelease (myBitmapContextGray);
    }
    
    // Now, we have to merge the two images to create the final image with a transparent inner circle
    CGImageRef finalImage = CGImageCreateWithMask(imageRef, maskImageRef);
    
    // Turn the image ref into a UIImage
    UIImage *image = [UIImage imageWithCGImage:finalImage scale:[[UIScreen mainScreen] scale] orientation:UIImageOrientationUp];
    
    CGImageRelease(imageRef);
    CGImageRelease(maskImageRef);
    CGImageRelease(finalImage);
    
    return image;
}

-(void)viewDidAppear_old:(BOOL)animated
{
    [super viewDidAppear:animated];

    CGFloat scale = [[UIScreen mainScreen] scale];
    CGAffineTransform transform = CGAffineTransformScale(CGAffineTransformIdentity, scale, scale);

    // Create a 16x16 image that is a red diamond on a black background
    UIImage *image = [self patternImageWithSize:CGSizeApplyAffineTransform(CGSizeMake(16,16), transform)
                                    forRectSize:CGSizeApplyAffineTransform(self.view.frame.size, transform)];

    // Fill the background of the main view with this pattern
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    // Using similar techniques, illustrate how to create an image with holes in it utilizing an image mask
    
    // Create a UIImageView, and an image
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 20, 120, 120)];
    imageView.image = [self filledDoughnutForSize:CGSizeApplyAffineTransform(imageView.frame.size, transform)];
    
    [self.view addSubview:imageView];  // Green doughnut with white center
    
    // Wouldn't it be cool, though, if we could have a green ring with no center?
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 150, 120, 120)];
    imageView.image = [self emptyDoughnutForSize:CGSizeApplyAffineTransform(imageView.frame.size,transform)];
    
    [self.view addSubview:imageView];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSRect r=[[self view] frame];
    MPWView *patternView = [[MPWView alloc] initWithFrame:r];
    [patternView setDrawingBlock:^(id <MPWDrawingContext> context){
        NSSize patternSize=NSMakeSize(16,16);
        id diamond = [context laterWithSize:patternSize content:^(id <MPWDrawingContext> context){
            [context setFillColor:[context colorRed:1.0 green:0.0 blue:0.0 alpha:1.0]];
            [[context moveto:patternSize.width/2 :2] lineto:patternSize.width-2 :patternSize.height/2 ];
            [[context lineto:patternSize.width/2 :patternSize.height-2] lineto:2 :patternSize.height/2];
            [[context closepath] fill];
        }];
        [context setFillColor:diamond];
        [[context nsrect:r] fill];
        [context setFillColor:[context colorRed:0.2 green:1.0 blue:0.3 alpha:1.0]];
        NSPoint centerPoint = NSMakePoint(r.size.width/2, 150);
        [context arcWithCenter:centerPoint  radius:50 startDegrees:0 endDegrees:360  clockwise:YES];
        [context arcWithCenter:centerPoint  radius:100 startDegrees:0 endDegrees:360  clockwise:NO];
        [context eofill];
        [context translate: 0 : 250];
        [context arcWithCenter:centerPoint  radius:100 startDegrees:0 endDegrees:360  clockwise:NO];
        [context fill];
        [context setFillColor:[context colorGray: 1.0 alpha:1.0]];
        [context arcWithCenter:centerPoint  radius:50 startDegrees:0 endDegrees:360  clockwise:NO];
        [context fill];

        

    }];
    [[self view] addSubview:patternView];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
