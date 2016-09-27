//
//  DraggableViewBackground.m
//  CardStackView
//
//  Created by Dinesh.sharma on 22/08/16.
//  Copyright © 2016 V2Solutions. All rights reserved.
//

#import "CardViewBackground.h"
#import "UIView+UpdateFrame.h"

@implementation CardViewBackground{
    NSInteger cardsLoadedIndex;
    NSMutableArray *loadedCards;
    NSInteger removedCardIndex;
}

static const float CARD_HEIGHT = 386;
static const float CARD_WIDTH = 290;
static const int MAX_BUFFER_SIZE = 4;//max number of cards loaded at any given time, must be greater than 1
static const float X_Position = 10;
static const float Y_Position = 20;
static const float ReduceScaleWidth_Position= 20;

@synthesize cardLabels;
@synthesize allCards;

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [super layoutSubviews];
        [self setUpView];
        cardLabels = [[NSArray alloc]initWithObjects:@"Card-A",@"Card-B",@"Card-C",@"Card-D",@"Card-E", nil];
        loadedCards = [[NSMutableArray alloc] init];
        allCards = [[NSMutableArray alloc]init];
        cardsLoadedIndex = 0;
        removedCardIndex = 0;
        [self loadCards];
    }
    return self;
}

-(void)setUpView{
    self.backgroundColor = [UIColor grayColor];
}

-(void)loadCards{
    if([cardLabels count] > 0) {
        NSInteger numberLoadedCards =(([cardLabels count] > MAX_BUFFER_SIZE)?MAX_BUFFER_SIZE:[cardLabels count]);
       
        for (int i = 0; i<[cardLabels count]; i++) {
            NSInteger _x = X_Position * i;
            NSInteger _y = Y_Position * i;
            CardView* newCard = [self createDraggableViewWithDataAtIndex:i withX:_x andWithY:_y];
            [allCards addObject:newCard];
            
            if (i<numberLoadedCards) {
                [loadedCards addObject:newCard];
            }
        }
        
        for (int i = 0; i<[loadedCards count]; i++) {
            if (i>0) {
                [self insertSubview:[loadedCards objectAtIndex:i] belowSubview:[loadedCards objectAtIndex:i-1]];
            } else {
                [self addSubview:[loadedCards objectAtIndex:i]];
            }
            cardsLoadedIndex++;
        }
    }
}

-(CardView *)createDraggableViewWithDataAtIndex:(NSInteger)index withX:(NSInteger)x andWithY:(NSInteger)y {
     NSInteger _w = ReduceScaleWidth_Position *index;

    /*
    NSInteger _w ;
    if(index == cardLabels.count-1){
        _w = ReduceScaleWidth_Position *(index-1);

    }else{
        _w = ReduceScaleWidth_Position *index;

    }
     */
    
    CardView *cardView = [[CardView alloc]initWithFrame:CGRectMake(((self.frame.size.width - CARD_WIDTH)/2)+ x, ((self.frame.size.height - CARD_HEIGHT)/1.25)-y, CARD_WIDTH-_w, CARD_HEIGHT)];
    cardView.viewTag = index;
    cardView.information.text = [cardLabels objectAtIndex:index];

    if(index == 0){
        cardView.panGestureRecognizer.enabled = YES;
        
    }else{
        cardView.panGestureRecognizer.enabled = NO;
    }
    if (index % 2){
        cardView.backgroundColor = [UIColor cyanColor];
    }
    else{
        cardView.backgroundColor = [UIColor magentaColor];
    }
    cardView.delegate = self;
    
    return cardView;
}


-(NSInteger)getCardIndex:(CardView*)draggableView{
    NSInteger viewIndex = draggableView.viewTag;
    return viewIndex;
}


#pragma DraggableViewDelegate

-(void)cardSwipedLeft:(CardView *)card{
    removedCardIndex = [self getCardIndex:card];
    if (cardsLoadedIndex < [allCards count]) {
        [loadedCards addObject:[allCards objectAtIndex:cardsLoadedIndex]];
        cardsLoadedIndex++;
        [self insertSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-1)] belowSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-2)]];
    }
    [self createCycleWithExistingCard];
    

}

-(void)cardSwipedRight:(CardView *)card{
    removedCardIndex = [self getCardIndex:card];
    
    if (cardsLoadedIndex < [allCards count]) {
        [loadedCards addObject:[allCards objectAtIndex:cardsLoadedIndex]];
        cardsLoadedIndex++;
        [self insertSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-1)] belowSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-2)]];
    }
    [self createCycleWithExistingCard];

}

-(void)createCycleWithExistingCard{
    
    NSMutableArray *tempLoadCards = [[NSMutableArray alloc] init];
    for (int i = 0; i<[loadedCards count]; i++) {
        CardView* card;
        CGRect frame;
        NSInteger _x = X_Position * i;
        NSInteger _y = Y_Position * i;

        if(i== [loadedCards count]-1 || i>[loadedCards count]){

            card =  [loadedCards objectAtIndex:0];
            frame = [self updateFrameAtIndex:MAX_BUFFER_SIZE-1];
            [card setFrame:frame];

            card.panGestureRecognizer.enabled = NO;
            card.transform = CGAffineTransformIdentity;
            card.layer.anchorPoint = CGPointMake(0.5, 0.5);
            card.layer.bounds = CGRectMake(0, 0, frame.size.width, CARD_HEIGHT);

            
            //set label position in card view

            CGRect informationLabelFrame = card.information.frame;
            informationLabelFrame.size.width = frame.size.width;
            card.information.frame =  informationLabelFrame;
            
            card.information.transform = CGAffineTransformIdentity;
            card.information.layer.anchorPoint = CGPointMake(0.5, 0.5);
            card.information.layer.bounds = CGRectMake(0, 0, frame.size.width, 100);
            
            
        }else{
            card =  [loadedCards objectAtIndex:i+1];
            NSInteger _w = ReduceScaleWidth_Position *i;
            //NSLog(@"%@",NSStringFromCGRect(card.information.frame));

            [card setFrameX:((self.frame.size.width - CARD_WIDTH)/2)+ _x];
            [card setFrameY:((self.frame.size.height - CARD_HEIGHT)/1.25)-_y];
            [card setFrameWidth:CARD_WIDTH-_w];
            [card setFrameHeight:CARD_HEIGHT];
            
            //set label position in card view
            CGRect informationLabelFrame = card.information.frame;
            informationLabelFrame.size.width = CARD_WIDTH-_w;
            card.information.frame =  informationLabelFrame;
            
            card.information.transform = CGAffineTransformIdentity;
            card.information.layer.anchorPoint = CGPointMake(0.5, 0.5);
            card.information.layer.bounds = CGRectMake(0, 0, CARD_WIDTH-_w, 100);
            
            if(i == 0){
                card.panGestureRecognizer.enabled = YES;
                
            }else{
                card.panGestureRecognizer.enabled = NO;
            }
           
        }
        [tempLoadCards addObject:card];
    }
    
    
    
    [loadedCards removeAllObjects];
    [loadedCards addObjectsFromArray:tempLoadCards];
    
    [tempLoadCards removeAllObjects];
    tempLoadCards = nil;
    
    for (int i = 0; i<[loadedCards count]; i++) {
        
        if (i>0) {
            [self insertSubview:[loadedCards objectAtIndex:i] belowSubview:[loadedCards objectAtIndex:i-1]];
        } else {
            [self addSubview:[loadedCards objectAtIndex:i]];
        }
        
        
    }

}

-(CGRect)updateFrameAtIndex:(NSInteger)index{
    
    NSInteger _x = X_Position * index;
    NSInteger _y = Y_Position * index;
    NSInteger _w = ReduceScaleWidth_Position *index;

    CGRect frame;
    frame.origin.x = ((self.frame.size.width - CARD_WIDTH)/2)+ _x;
    frame.origin.y = ((self.frame.size.height - CARD_HEIGHT)/1.25)-_y;
    frame.size.width = CARD_WIDTH-_w;
    frame.size.height = CARD_HEIGHT;

    return frame;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
