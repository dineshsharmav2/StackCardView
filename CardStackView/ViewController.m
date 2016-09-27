//
//  ViewController.m
//  CardStackView
//
//  Created by Dinesh.sharma on 22/08/16.
//  Copyright © 2016 V2Solutions. All rights reserved.
//

#import "ViewController.h"
#import "CardViewBackground.h"


@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CardViewBackground *draggableViewBackground = [[CardViewBackground alloc] initWithFrame:self.view.frame];
    [self.view addSubview:draggableViewBackground];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
