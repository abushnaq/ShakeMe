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
    UIGraphicsBeginImageContext(CGSizeMake(rect.size.width, rect.size.height));
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 5.0);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0, 2, 0, 2);
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 0, 0);
    
    CGContextAddCurveToPoint(UIGraphicsGetCurrentContext(), 0, 0, rect.size.width / 2, rect.size.height , rect.size.width, 0);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];

    [self addSubview:imageView];
    
    
    // The keyPath to animate
    NSString *keyPath = @"bounds.size.height";//@"transform.translation.y";

    // Allocate a CAKeyFrameAnimation for the specified keyPath.
    CAKeyframeAnimation *translation = [CAKeyframeAnimation animationWithKeyPath:keyPath];

    // Set animation duration and repeat
    translation.duration = 1.5f;
    translation.repeatCount = HUGE_VAL;

    // Allocate array to hold the values to interpolate
    NSMutableArray *values = [[NSMutableArray alloc] init];

    // Add the start value
    // The animation starts at a y offset of 0.0
    [values addObject:[NSNumber numberWithFloat:100.0f]];

    CALayer *layer = imageView.layer;
    // Add the end value
    // The animation finishes when the ball would contact the bottom of the screen
    // This point is calculated by finding the height of the applicationFrame
    // and subtracting the height of the ball.
    CGFloat height = 0.0f;//[[UIScreen mainScreen] applicationFrame].size.height - layer.frame.size.height;
    [values addObject:[NSNumber numberWithFloat:height]];

    // Set the values that should be interpolated during the animation
    translation.values = values;
    
    [layer addAnimation:translation forKey:keyPath];

    
    // The keyPath to animate
    NSString *keyPath2 = @"bounds.origin.y";//@"transform.translation.y";
    
    // Allocate a CAKeyFrameAnimation for the specified keyPath.
    CAKeyframeAnimation *translation2 = [CAKeyframeAnimation animationWithKeyPath:keyPath];
    
    // Set animation duration and repeat
    translation2.duration = 1.5f;
    translation2.repeatCount = HUGE_VAL;
    
    // Allocate array to hold the values to interpolate
    NSMutableArray *values2 = [[NSMutableArray alloc] init];
    
    // Add the start value
    // The animation starts at a y offset of 0.0
    [values2 addObject:[NSNumber numberWithFloat:0.0f]];
    
    // Add the end value
    // The animation finishes when the ball would contact the bottom of the screen
    // This point is calculated by finding the height of the applicationFrame
    // and subtracting the height of the ball.
    CGFloat height2 = 0.0f;//[[UIScreen mainScreen] applicationFrame].size.height - layer.frame.size.height;
    [values2 addObject:[NSNumber numberWithFloat:height2]];
    
    // Set the values that should be interpolated during the animation
    translation2.values = values;
    
    [layer addAnimation:translation forKey:keyPath2];
}


@end
