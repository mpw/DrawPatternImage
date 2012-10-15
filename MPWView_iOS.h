//
//  MPWView_iOS.h
//  EGOS
//
//  Created by Marcel Weiher on 3/22/12.
//  Copyright (c) 2012 metaobject ltd. All rights reserved.
//


#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
#import <EGOS/MPWDrawingContext.h>


@interface MPWView : UIView {
    id  drawingBlock;
}

-(void)drawRect:(NSRect)rect onContext:(id <MPWDrawingContext>)context;

@property(nonatomic,retain) id drawingBlock;


@end
