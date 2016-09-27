//
//  UIView+UpdateFrame.m
//  CardStackView
//
//  Created by Dinesh.sharma on 23/08/16.
//  Copyright © 2016 V2Solutions. All rights reserved.
//

#import "UIView+UpdateFrame.h"

@implementation UIView (UpdateFrame)

# pragma mark - Setters

- (void) setFrameWidth:(CGFloat)width
{
    self.frame = CGRectMake(self.frame.origin.x,
                            self.frame.origin.y,
                            width,
                            self.frame.size.height);
}

- (void) setFrameHeight:(CGFloat)height
{
    self.frame = CGRectMake(self.frame.origin.x,
                            self.frame.origin.y,
                            self.frame.size.width,
                            height);
}

- (void) setFrameX:(CGFloat)x
{
    self.frame = CGRectMake(x,
                            self.frame.origin.y,
                            self.frame.size.width,
                            self.frame.size.height);
}

- (void) setFrameY:(CGFloat)y
{
    self.frame = CGRectMake(self.frame.origin.x,
                            y,
                            self.frame.size.width,
                            self.frame.size.height);
}

# pragma mark - Getters

- (CGFloat) frameWidth
{
    return self.frame.size.width;
}

- (CGFloat) frameHeight
{
    return self.frame.size.height;
}

- (CGFloat) frameX
{
    return self.frame.origin.x;
}

- (CGFloat) frameY
{
    return self.frame.origin.y;
}

@end
