//
//  DWRainbowView.h
//  DWAnimatedProgress
//
//  Created by daiwei02 on 14-2-8.
//  Copyright (c) 2014年 david. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DWRainbowView : UIView

@property (nonatomic, retain) CALayer *maskLayer;
@property (nonatomic, assign) CGFloat progressValue;
@property (nonatomic, assign) BOOL isAnimating;

- (void)startAnimating;
- (void)stopAnimating;

- (void)setProgress:(CGFloat)value;
@end
