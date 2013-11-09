//
//  ViewController.m
//  ShakeMe
//
//  Created by Ahmad Bushnaq on 11/3/13.
//  Copyright (c) 2013 Ahmad Bushnaq. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/CAShapeLayer.h>
#import <QuartzCore/CAAnimation.h>
#import <QuartzCore/CAMediaTimingFunction.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    int radius = 30;
	// Do any additional setup after loading the view, typically from a nib.
    CGPoint firstEye = CGPointMake(CGRectGetMidX(self.view.frame)-radius,
              CGRectGetMidY(self.view.frame)-radius);
    [self drawCircleAtCoordinates:firstEye filled:NO withRadius:30];
    
    CGPoint secondEye = CGPointMake(CGRectGetMidX(self.view.frame)+radius,
                                CGRectGetMidY(self.view.frame)-radius);
    [self drawCircleAtCoordinates:secondEye filled:NO withRadius:30];
    
    CGPoint thirdEye = CGPointMake(CGRectGetMidX(self.view.frame)+radius,
                                    CGRectGetMidY(self.view.frame)-radius);
    [self drawCircleAtCoordinates:thirdEye filled:YES withRadius:10];
    
    CGPoint fourthEye = CGPointMake(CGRectGetMidX(self.view.frame)+radius,
                                   CGRectGetMidY(self.view.frame)-radius);
    [self drawCircleAtCoordinates:fourthEye filled:YES withRadius:10];
    
    
    
    UITapGestureRecognizer *trigger = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    trigger.numberOfTapsRequired = 1;
    trigger.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:trigger];
    
    
    [self addDialogLabel];
}


- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
        [UIView animateWithDuration:1.0 animations:^{
            CGRect frame = cover.frame;
            int total = frame.origin.x + frame.size.width;
            frame.origin.x = total;
            frame.size.width = 0;
            cover.frame = frame;
        }];
    }
}

-(BOOL)canBecomeFirstResponder {
    return YES;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self resignFirstResponder];
    [super viewWillDisappear:animated];
}

- (void) addDialogLabel
{
    dialog = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame) / 2, 45, 18)];
    dialog.backgroundColor = [UIColor clearColor];
    dialog.text = @"hello";
    dialog.hidden = NO;
    
    cover = [[UIView alloc] initWithFrame:dialog.frame];
    cover.opaque = YES;
    cover.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:dialog];
    [self.view addSubview:cover];
}

- (void)tapped:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {         // handling code
        [UIView animateWithDuration:1.0 animations:^{
            CGRect frame = cover.frame;
            int total = frame.origin.x + frame.size.width;
            frame.origin.x = total;
            frame.size.width = 0;
            cover.frame = frame;
        }];
        
    }
}

- (void) drawCircleAtCoordinates:(CGPoint) point filled:(BOOL) isFilled withRadius:(int) radius
{

    CAShapeLayer *circle = [CAShapeLayer layer];
    // Make a circular shape
    circle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0*radius, 2.0*radius)
                                             cornerRadius:radius].CGPath;
//

    
//    circle.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(30, 30) radius:30 startAngle:0 endAngle:600 clockwise:NO].CGPath;
//    // Center the shape in self.view
    circle.position = point;
    
    // Configure the apperence of the circle
    if (isFilled)
    {
        circle.fillColor = [UIColor blackColor].CGColor;
    }
    else
    {
        circle.fillColor = [UIColor clearColor].CGColor;
    }
    circle.strokeColor = [UIColor blackColor].CGColor;
    circle.lineWidth = 5;
    
    // Add to parent layer
    [self.view.layer addSublayer:circle];
    
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

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
