//
//  DraggableView.h
//  CardStackView
//
//  Created by Dinesh.sharma on 22/08/16.
//  Copyright © 2016 V2Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CardViewDelegate <NSObject>

-(void)cardSwipedLeft:(UIView *)card;
-(void)cardSwipedRight:(UIView *)card;

@end

@interface CardView : UIView
@property (weak) id<CardViewDelegate> delegate;
@property (nonatomic,strong) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic)CGPoint originalPoint;
@property (nonatomic,strong)UILabel* information;
@property (assign,nonatomic)NSInteger viewTag;

@end
