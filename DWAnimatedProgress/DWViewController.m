//
//  DWViewController.m
//  DWAnimatedProgress
//
//  Created by daiwei02 on 14-2-8.
//  Copyright (c) 2014年 david. All rights reserved.
//

#import "DWViewController.h"

@interface DWViewController ()

@end

@implementation DWViewController
@synthesize rainbowView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    rainbowView = [[DWRainbowView alloc] initWithFrame:CGRectMake(0, 22.0, 320, 1.0)];
    [self.view addSubview:rainbowView];
    
    UILabel *testLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 200, 30)];
    testLabel.text = @"david test";
    [self.view addSubview:testLabel];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self simulateProgress];
    //[self.rainbowView setProgress:0.5];
    [self.rainbowView startAnimating];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Customize Method
- (void)simulateProgress {
    
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        CGFloat increment = (arc4random() % 5) / 10.0f + 0.1;
        CGFloat progress  = self.rainbowView.progressValue + increment;
        [self.rainbowView setProgress:progress];
        if (progress < 1.0) {
            
            [self simulateProgress];
        }
    });
}

@end
