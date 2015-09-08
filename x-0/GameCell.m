//
//  GameCell.m
//  x-0
//
//  Created by Andrii Zykov on 9/8/15.
//  Copyright (c) 2015 AndriiZykov. All rights reserved.
//

#import "GameCell.h"

@implementation GameCell



- (void)drawRect:(CGRect)rect {
  
    [super drawRect:rect];
    
    if (!self.isUsed) {
        return;
    }
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (self.isX) {
        
        CGContextMoveToPoint(context, 0, 0);
        
        CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
        
        CGContextSetLineWidth(context, 5);
        
        CGContextStrokePath(context);
        
        CGContextMoveToPoint(context, rect.size.width, 0);
        
        CGContextAddLineToPoint(context, 0, rect.size.height);
        
        CGContextStrokePath(context);
        
    } else {
        
        CGContextSetLineWidth(context, 5);
        
        CGContextMoveToPoint(context, rect.size.height / 2, rect.size.height / 2);
        
        CGContextAddEllipseInRect(context, CGRectMake(10, 10, rect.size.height - 20, rect.size.height - 20));
        
        CGContextStrokePath(context);
        
    }
    
    
    
}


@end
