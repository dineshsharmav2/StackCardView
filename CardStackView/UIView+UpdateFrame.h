//
//  UIView+UpdateFrame.h
//  CardStackView
//
//  Created by Dinesh.sharma on 23/08/16.
//  Copyright © 2016 V2Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (UpdateFrame)
- (void) setFrameWidth:(CGFloat)width;
- (void) setFrameHeight:(CGFloat)height;
- (void) setFrameX:(CGFloat)x;
- (void) setFrameY:(CGFloat)y;

- (CGFloat) frameWidth;
- (CGFloat) frameHeight;
- (CGFloat) frameX;
- (CGFloat) frameY;
@end
