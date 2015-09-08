//
//  GameCell.h
//  x-0
//
//  Created by Andrii Zykov on 9/8/15.
//  Copyright (c) 2015 AndriiZykov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameCell : UIView
@property (assign, nonatomic) BOOL isX;
@property (assign, nonatomic) BOOL isUsed;
@property (assign, nonatomic) int cellNumber;
@end
