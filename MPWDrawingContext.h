//
//  MPWDrawingContext.h
//  MusselWind
//
//  Created by Marcel Weiher on 11/18/10.
//  Copyright 2010 Marcel Weiher. All rights reserved.
//

#import <MPWFoundation/PhoneGeometry.h>


@protocol MPWDrawingContext <NSObject>


-(id <MPWDrawingContext>)translate:(float)x :(float)y;
-(id <MPWDrawingContext>)scale:(float)x :(float)y;
-(id <MPWDrawingContext>)rotate:(float)degrees;

-(id <MPWDrawingContext>)gsave;
-(id <MPWDrawingContext>)grestore;
-(id <MPWDrawingContext>)setdashpattern:array phase:(float)phase;
-(id <MPWDrawingContext>)setlinewidth:(float)width;


-(id)colorRed:(float)r green:(float)g blue:(float)b alpha:(float)alpha;
-(id)colorsRed:r green:g blue:b alpha:alpha;

-(id)colorCyan:(float)c magenta:(float)m yellow:(float)y black:(float)k alpha:(float)alpha;
-(id)colorsCyan:c magenta:m yellow:y black:k alpha:alpha;

-(id)colorGray:(float)gray alpha:(float)alpha;
-(id)colorsGray:gray alpha:alpha;

-(id <MPWDrawingContext>)setFillColor:(id)aColor;
-(id <MPWDrawingContext>)setStrokeColor:(id)aColor;

-(id <MPWDrawingContext>)setFillColorGray:(float)gray alpha:(float)alpha;


-(id <MPWDrawingContext>)setAlpha:(float)alpha;
-(id <MPWDrawingContext>)setAntialias:(BOOL)doAntialiasing;
-(id <MPWDrawingContext>)setShadowOffset:(NSSize)offset blur:(float)blur color:(id)aColor;
-(id <MPWDrawingContext>)clearShadow;


-(id <MPWDrawingContext>)concat:(float)m11 :(float)m12  :(float)m21  :(float)m22  :(float)tx  :(float)ty;
-(id <MPWDrawingContext>)concat:someArray;

-(id <MPWDrawingContext>)setTextMatrix:(float)m11 :(float)m12  :(float)m21  :(float)m22  :(float)tx  :(float)ty;
-(id <MPWDrawingContext>)setFontSize:(float)newSize;

-(id <MPWDrawingContext>)setTextModeFill:(BOOL)fill stroke:(BOOL)stroke clip:(BOOL)clip;
-(id <MPWDrawingContext>)setCharaterSpacing:(float)newSpacing;
-(id <MPWDrawingContext>)selectMacRomanFontName:(NSString*)fontname size:(float)fontSize;

-(id)fontWithName:(NSString*)name size:(float)size;
-(id <MPWDrawingContext>)showTextString:str at:(NSPoint)position;
-(id <MPWDrawingContext>)showGlyphBuffer:(unsigned short*)glyphs length:(int)len at:(NSPoint)position;
-(id <MPWDrawingContext>)showGlyphs:glyphArray at:(NSPoint)position;


-(id <MPWDrawingContext>)drawLinearGradientFrom:(NSPoint)startPoint to:(NSPoint)endPoint colors:(NSArray*)colors offsets:(NSArray*)offsets;
-(id <MPWDrawingContext>)drawRadialGradientFrom:(NSPoint)startPoint radius:(float)startRadius to:(NSPoint)endPoint radius:(float)endRadius colors:(NSArray*)colors offsets:(NSArray*)offsets;


-(void)clip;
-(void)fill;
-(void)eofill;
-(void)eofillAndStroke;
-(void)fillAndStroke;
-(void)stroke;
-(void)fillRect:(NSRect)r;

-(NSRect)cliprect;

-(id <MPWDrawingContext>)nsrect:(NSRect)r;
-(id <MPWDrawingContext>)moveto:(float)x :(float)y;
-(id <MPWDrawingContext>)lineto:(float)x :(float)y;
-(id <MPWDrawingContext>)curveto:(float)cp1x :(float)cp1y :(float)cp2x :(float)cp2y :(float)x :(float)y;
-(id <MPWDrawingContext>)closepath;
-(id <MPWDrawingContext>)arcWithCenter:(NSPoint)center radius:(float)radius startDegrees:(float)start endDegrees:(float)stop  clockwise:(BOOL)clockwise;
-(id <MPWDrawingContext>)arcFromPoint:(NSPoint)p1 toPoint:(NSPoint)p2 radius:(float)radius;
-(id <MPWDrawingContext>)ellipseInRect:(NSRect)r;

-(id <MPWDrawingContext>)drawImage:anImage;

-(id <MPWDrawingContext>)show:(id)someText;             // NS(Attributed)String
-(id <MPWDrawingContext>)setTextPosition:(NSPoint)p;
-(id <MPWDrawingContext>)setFont:aFont;

#if NS_BLOCKS_AVAILABLE
typedef void (^DrawingBlock)(id <MPWDrawingContext>);

-ingsave:(DrawingBlock)drawingCommands;
-(id)drawLater:(DrawingBlock)drawingCommands;
-layerWithSize:(NSSize)size content:(DrawingBlock)drawingCommands;
-laterWithSize:(NSSize)size content:(DrawingBlock)drawingCommands;
-page:(NSDictionary*)parameters content:(DrawingBlock)drawingCommands;

#endif

@end
