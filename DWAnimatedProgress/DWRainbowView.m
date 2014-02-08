//
//  DWRainbowView.m
//  DWAnimatedProgress
//
//  Created by daiwei02 on 14-2-8.
//  Copyright (c) 2014年 david. All rights reserved.
//

#import "DWRainbowView.h"

@implementation DWRainbowView
@synthesize maskLayer;
@synthesize progressValue;
@synthesize isAnimating;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // Use a horizontal gradient
        CAGradientLayer *layer = (id)[self layer];
        [layer setStartPoint:CGPointMake(0.0, 0.5)];
        [layer setEndPoint:CGPointMake(1.0, 0.5)];
        
        // Create colors using hues in +5 increments
        NSMutableArray *colors = [NSMutableArray array];
        for (NSInteger hue=0; hue<=360; hue += 5) {
            UIColor *color = nil;
            color = [UIColor colorWithHue:1.0*hue/360.0 saturation:1.0 brightness:1.0 alpha:1.0];
            [colors addObject:(id)[color CGColor]];
        }
        
        [layer setColors:colors];
        
        self.maskLayer = [CALayer layer];
        [self.maskLayer setFrame:CGRectMake(0, 0, 0, frame.size.height)];
        [self.maskLayer setBackgroundColor:[[UIColor redColor] CGColor]];
        [layer setMask:self.maskLayer];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

+ (Class)layerClass
{
    return [CAGradientLayer class];
}

- (NSArray*)shiftColors:(NSArray*)colors
{
    // Move the last color in the array to the front
    // Shifting all the other colors
    NSMutableArray *mutable = [colors mutableCopy];
    id lastColor = [mutable lastObject];
    [mutable removeLastObject];
    [mutable insertObject:lastColor atIndex:0];
    NSArray * shiftedColors = [NSArray arrayWithArray:mutable];
    return shiftedColors;
}

- (void)performAnimation {
    NSLog(@"performAnimation start ...");
    // Update the colors on the model layer
    
    CAGradientLayer *layer = (id)[self layer];
    NSArray *fromColors = [layer colors];
    NSArray *toColors = [self shiftColors:fromColors];
    [layer setColors:toColors];
    
    // Create an animation to slowly move the hue gradient left to right.
    
    CABasicAnimation *animation;
    animation = [CABasicAnimation animationWithKeyPath:@"colors"];
    [animation setFromValue:fromColors];
    [animation setToValue:toColors];
    [animation setDuration:0.08];
    [animation setRemovedOnCompletion:YES];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [animation setDelegate:self];
    
    // Add the animation to our layer
    
    [layer addAnimation:animation forKey:@"animateGradient"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"animationDidStop start ...");
    if (isAnimating) {
        [self performAnimation];
    }
}

- (void)startAnimating
{
    if (!isAnimating) {
        isAnimating = YES;
        [self performAnimation];
    }
}

- (void)stopAnimating
{
    if (isAnimating) {
        isAnimating = NO;
    }
}

- (void)setProgress:(CGFloat)value
{
    NSLog(@"setProgress value[%f]", value);
    if (self.progressValue != value) {
        // Progress values go from 0.0 to 1.0
        self.progressValue = MIN(1.0, fabs(value));
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews
{
    NSLog(@"layoutSubviews start ...");
    // Resize our mask layer based on the current progress
    CGRect maskRect = [self.maskLayer frame];
    maskRect.size.width = CGRectGetWidth([self bounds]) * self.progressValue;
    [self.maskLayer setFrame:maskRect];
}
@end
