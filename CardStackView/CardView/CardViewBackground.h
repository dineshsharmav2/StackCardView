//
//  DraggableViewBackground.h
//  CardStackView
//
//  Created by Dinesh.sharma on 22/08/16.
//  Copyright © 2016 V2Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardView.h"


@interface CardViewBackground : UIView <CardViewDelegate>

@property (retain, nonatomic) NSArray *cardLabels;
@property (retain, nonatomic) NSMutableArray *allCards;

@end
