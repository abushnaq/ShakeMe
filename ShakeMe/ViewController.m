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

static int radius = 20;
- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor greenColor];
	// Do any additional setup after loading the view, typically from a nib.
    CGPoint firstEye = CGPointMake(CGRectGetMidX(self.view.frame)-2.5*radius,
              CGRectGetMidY(self.view.frame)-radius);
    [self drawCircleAtCoordinates:firstEye filled:NO withRadius:radius];
    

    
    CGPoint secondEye = CGPointMake(CGRectGetMidX(self.view.frame)+0.5*radius,
                                CGRectGetMidY(self.view.frame)-radius);
    [self drawCircleAtCoordinates:secondEye filled:NO withRadius:radius];
    

    
    
    CGPoint thirdEye = CGPointMake(CGRectGetMidX(self.view.frame)+0.5*radius+15,
                                    CGRectGetMidY(self.view.frame)+(radius-5));
    [self drawCircleAtCoordinates:thirdEye filled:YES withRadius:radius/3];
    
    CGPoint fourthEye = CGPointMake(CGRectGetMidX(self.view.frame)-2.5*radius+15,
                                   CGRectGetMidY(self.view.frame)+(radius-5));
    [self drawCircleAtCoordinates:fourthEye filled:YES withRadius:radius/3];
    
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
    EyelidView *eyelid = [[EyelidView alloc] initWithFrame:CGRectMake(coordinate.x-2*radius, coordinate.y-radius, radius*2, radius*2.5)];
    [self.view addSubview:eyelid];
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
    number = arc4random() % 40;
    if (number ==0)
    {
        number = 1;
    }
   // NSLog(@"Segment: %d number %d phraseCount %d", segment, number, phraseCount);
    sqlite3 *database;
    NSString *dbPath =@"phrases.sqlite";
    NSArray *documentsPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDir = [documentsPaths objectAtIndex:0];
    
    NSString *_databasePath = [documentDir stringByAppendingPathComponent:dbPath];
    
    int res = sqlite3_open_v2([_databasePath UTF8String], &database, SQLITE_OPEN_CREATE | SQLITE_OPEN_READWRITE, NULL);
    NSLog (@"Number is %d", number);
    
    NSString *statement = [NSString stringWithFormat:@"SELECT PHRASE FROM PHRASES WHERE ID=%d" , number];
    
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
    dialog = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 100)];
    dialog.backgroundColor = [UIColor clearColor];
    dialog.font = [UIFont systemFontOfSize:15.0f];
    dialog.text = @"";
    dialog.numberOfLines = 0;
    dialog.lineBreakMode = NSLineBreakByWordWrapping;
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
    circle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0*radius, 2.5*radius)
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
    [self.view addSubview:[[MouthView alloc] initWithFrame:CGRectMake(100,CGRectGetMidY(self.view.frame)+60, 120, 150)]];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
