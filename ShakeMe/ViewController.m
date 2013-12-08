//
//  ViewController.m
//  ShakeMe
//
//  Created by Ahmad Bushnaq on 11/3/13.
//  Copyright (c) 2013 Ahmad Bushnaq. All rights reserved.
//

#import "ViewController.h"
#import "MouthView.h"
#import "EyelidView.h"
#import <QuartzCore/CAShapeLayer.h>
#import <QuartzCore/CAAnimation.h>
#import <QuartzCore/CAMediaTimingFunction.h>
#import <sqlite3.h>
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
    
    CGPoint thirdEye = CGPointMake(CGRectGetMidX(self.view.frame)+radius+20,
                                    CGRectGetMidY(self.view.frame)+(radius-20));
    [self drawCircleAtCoordinates:thirdEye filled:YES withRadius:10];
    
    CGPoint fourthEye = CGPointMake(CGRectGetMidX(self.view.frame)-radius+20,
                                   CGRectGetMidY(self.view.frame)+(radius-20));
    [self drawCircleAtCoordinates:fourthEye filled:YES withRadius:10];
    
    [self addMouthLayer];
    
   [self addEyelid:firstEye];    
   [self addEyelid:secondEye];
    UITapGestureRecognizer *trigger = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    trigger.numberOfTapsRequired = 1;
    trigger.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:trigger];
    
    
    [self addDialogLabel];
}

- (void) addEyelid:(CGPoint) coordinate
{
    EyelidView *eyelid = [[EyelidView alloc] initWithFrame:CGRectMake(coordinate.x-30, coordinate.y-30, 60, 100)];
    [self.view addSubview:eyelid];
  
//    [UIView animateWithDuration:100.0f animations:^{
//        eyelid.frame = CGRectMake(coordinate.x, coordinate.y+15, 60, 200);
//    }];
    
//    // The keyPath to animate
//    NSString *keyPath = @"transform.scale.y";//@"bounds.size.height";//@"transform.translation.y";
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
//    CALayer *layer = eyelid.layer;
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
 
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
        [self showNextText];
    }
}

static int number = 0;

- (NSString*) selectNextText
{
    number = arc4random() % 20;
    sqlite3 *database;
    NSString *dbPath =@"phrases.sqlite";
    NSArray *documentsPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDir = [documentsPaths objectAtIndex:0];
    
    NSString *_databasePath = [documentDir stringByAppendingPathComponent:dbPath];
    
    int res = sqlite3_open_v2([_databasePath UTF8String], &database, SQLITE_OPEN_CREATE | SQLITE_OPEN_READWRITE, NULL);
    
    NSString *statement = [NSString stringWithFormat:@"SELECT PHRASE FROM PHRASES WHERE ID=%d", number];
    
    sqlite3_stmt *sqliteStatement;
    res = sqlite3_prepare(database, [statement UTF8String], strlen([statement UTF8String]), &sqliteStatement, NULL);

    res = sqlite3_step(sqliteStatement);
    const unsigned char *phrase = sqlite3_column_text(sqliteStatement, 0);
    
    return [[NSString alloc] initWithUTF8String:(const char*)phrase];//  [NSString stringWithFormat:@"Blah - %d", number];
    
}
- (void) showNextText
{
    [UIView animateWithDuration:1.0 animations:^{
        dialog.text = @"";
        cover.frame = dialog.frame;
        dialog.text = [self selectNextText];
        
        CGRect frame = cover.frame;
        int total = frame.origin.x + frame.size.width;
        frame.origin.x = total;
        frame.size.width = 0;
        cover.frame = frame;
    }];
    
    
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
    dialog = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame) / 2, 100, 18)];
    dialog.backgroundColor = [UIColor clearColor];
    dialog.text = @"";
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
        [self showNextText];
    }
}

- (void) drawCircleAtCoordinates:(CGPoint) point filled:(BOOL) isFilled withRadius:(int) radius
{

    CAShapeLayer *circle = [CAShapeLayer layer];
    // Make a circular shape
    circle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0*radius, 2.0*radius)
                                             cornerRadius:radius].CGPath;

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

- (void) addMouthLayer
{

    [self.view addSubview:[[MouthView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame)-40,CGRectGetMidY(self.view.frame)+40, 150, 150)]];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
