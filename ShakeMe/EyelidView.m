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
   // return;
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
    
    // Configure the apperence of the circle

    circle.fillColor = [UIColor colorWithRed:100 green:255 blue:100 alpha:0.9].CGColor;
    circle.opacity=1.0f;
    circle.lineWidth = 5;
    
    // Add to parent layer
    [self.layer addSublayer:circle];
    
    // Configure animation
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation.duration            = 1.0; // "animate over 1 seconds or so.."
    drawAnimation.repeatCount         = 1.0;  // Animate only once..
    drawAnimation.removedOnCompletion = NO;   // Remain stroked after the animation..
    
    
    // Animate from no part of the stroke being drawn to the entire stroke being drawn
    drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    drawAnimation.toValue   = [NSNumber numberWithFloat:1.0f];
    
    // Experiment with timing to get the appearence to look the way you want
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    // Add the animation to the circle
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
    
    // this code creates a nose
//    int radius = 10;
//    CAShapeLayer *circle = [CAShapeLayer layer];
//    // Make a circular shape
//    circle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0*radius, 2.0*radius)
//                                             cornerRadius:radius].CGPath;
//    
//    //    // Center the shape in self.view
//    circle.position = CGPointMake(50, 50);
//    
//    // Configure the apperence of the circle
////    if (isFilled)
////    {
//        circle.fillColor = [UIColor blackColor].CGColor;
////    }
//   
//    circle.strokeColor = [UIColor blackColor].CGColor;
//    circle.lineWidth = 5;
//    
//    // Add to parent layer
//    [self.layer addSublayer:circle];
//    
//    // Configure animation
//    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    drawAnimation.duration            = 1.0; // "animate over 1 seconds or so.."
//    drawAnimation.repeatCount         = 1.0;  // Animate only once..
//    drawAnimation.removedOnCompletion = NO;   // Remain stroked after the animation..
//    
//    
//    // Animate from no part of the stroke being drawn to the entire stroke being drawn
//    drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
//    drawAnimation.toValue   = [NSNumber numberWithFloat:1.0f];
//    
//    // Experiment with timing to get the appearence to look the way you want
//    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
//    
//    // Add the animation to the circle
//    [circle addAnimation:drawAnimation forKey:@"drawCircleAnimation"];

//    UIGraphicsBeginImageContext(CGSizeMake(rect.size.width, rect.size.height));
//    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
//    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 5.0);
//    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0, 2, 0, 2);
//    CGContextBeginPath(UIGraphicsGetCurrentContext());
//    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 0, 0);
//    
//    CGContextAddCurveToPoint(UIGraphicsGetCurrentContext(), 0, 0, rect.size.width / 2, rect.size.height , rect.size.width, 0);
//    CGContextStrokePath(UIGraphicsGetCurrentContext());
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
//
//    [self addSubview:imageView];
//    
//    
//    // The keyPath to animate
//    NSString *keyPath = @"strokeEnd";//@"bounds.size.height";//@"transform.translation.y";
//
//    // Allocate a CAKeyFrameAnimation for the specified keyPath.
//    CAKeyframeAnimation *translation = [CAKeyframeAnimation animationWithKeyPath:keyPath];
//
//    // Set animation duration and repeat
//    translation.duration = 1.5f;
//    translation.repeatCount = HUGE_VAL;
//
//    // Allocate array to hold the values to interpolate
//    NSMutableArray *values = [[NSMutableArray alloc] init];
//
//    // Add the start value
//    // The animation starts at a y offset of 0.0
//    [values addObject:[NSNumber numberWithFloat:100.0f]];
//
//    CALayer *layer = imageView.layer;
//    // Add the end value
//    // The animation finishes when the ball would contact the bottom of the screen
//    // This point is calculated by finding the height of the applicationFrame
//    // and subtracting the height of the ball.
//    CGFloat height = 0.0f;//[[UIScreen mainScreen] applicationFrame].size.height - layer.frame.size.height;
//    [values addObject:[NSNumber numberWithFloat:height]];
//
//    // Set the values that should be interpolated during the animation
//    translation.values = values;
//    
//    [layer addAnimation:translation forKey:keyPath];
//
//    
//    // The keyPath to animate
//    NSString *keyPath2 = @"opacity";//@"bounds.origin.y";//@"transform.translation.y";
//    
//    // Allocate a CAKeyFrameAnimation for the specified keyPath.
//    CAKeyframeAnimation *translation2 = [CAKeyframeAnimation animationWithKeyPath:keyPath];
//    
//    // Set animation duration and repeat
//    translation2.duration = 1.5f;
//    translation2.repeatCount = HUGE_VAL;
//    
//    // Allocate array to hold the values to interpolate
//    NSMutableArray *values2 = [[NSMutableArray alloc] init];
//    
//    // Add the start value
//    // The animation starts at a y offset of 0.0
//    [values2 addObject:[NSNumber numberWithFloat:0.0f]];
//    
//    // Add the end value
//    // The animation finishes when the ball would contact the bottom of the screen
//    // This point is calculated by finding the height of the applicationFrame
//    // and subtracting the height of the ball.
//    CGFloat height2 = 1.0f;//[[UIScreen mainScreen] applicationFrame].size.height - layer.frame.size.height;
//    [values2 addObject:[NSNumber numberWithFloat:height2]];
//    
//    // Set the values that should be interpolated during the animation
//    translation2.values = values;
//    
//    [layer addAnimation:translation forKey:keyPath2];
}


@end
