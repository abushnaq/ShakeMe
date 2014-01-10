//
//  EyelidView.m
//  ShakeMe
//
//  Created by Ahmad Bushnaq on 11/28/13.
//  Copyright (c) 2013 Ahmad Bushnaq. All rights reserved.
//

#import "EyelidView.h"

@implementation EyelidView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.opaque = NO;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    int width = rect.size.width / 2;
    int height = rect.size.height / 2.25;
    CAShapeLayer *circle = [CAShapeLayer layer];

    UIBezierPath *eyeclosed = [UIBezierPath bezierPath];
    [eyeclosed moveToPoint:CGPointMake(15, height)];
    [eyeclosed addQuadCurveToPoint:CGPointMake(rect.size.width+5, height) controlPoint:CGPointMake(12+rect.size.width/2, rect.size.height+5)];
   
    UIBezierPath *eyeopen = [UIBezierPath bezierPath];
    [eyeopen moveToPoint:CGPointMake(10, height)];
    
    [eyeopen addQuadCurveToPoint:CGPointMake(rect.size.width+10, height) controlPoint:CGPointMake(width, height)];
    CGPathRef eyeOpen = eyeopen.CGPath;
    
    
    
    circle.path = eyeclosed.CGPath;
    circle.position = CGPointMake(30, 30);
    
    
    circle.fillColor = [UIColor colorWithRed:100 green:255 blue:100 alpha:0.9].CGColor;
    circle.opacity=1.0f;
    circle.lineWidth = 5;
    
    [self.layer addSublayer:circle];
    
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation.duration            = 1.0; 
    drawAnimation.repeatCount         = 1.0;
    drawAnimation.removedOnCompletion = NO;
    
    
    drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    drawAnimation.toValue   = [NSNumber numberWithFloat:1.0f];
    
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    [circle addAnimation:drawAnimation forKey:@"drawCircleAnimation"];

    CABasicAnimation *blink = [CABasicAnimation animationWithKeyPath:@"path"];
    
    blink.duration = 1.0;
    blink.repeatCount = HUGE_VAL;
    blink.autoreverses = YES;
    blink.removedOnCompletion = NO;
    blink.fromValue = (__bridge id)eyeclosed.CGPath;
    blink.toValue = (__bridge id)eyeOpen;
    
    
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];

    [circle addAnimation:blink forKey:@"blinkAnimation"];
}


@end
