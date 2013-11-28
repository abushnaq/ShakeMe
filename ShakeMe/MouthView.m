//
//  MouthView.m
//  ShakeMe
//
//  Created by Ahmad Bushnaq on 11/24/13.
//  Copyright (c) 2013 Ahmad Bushnaq. All rights reserved.
//

#import "MouthView.h"

@implementation MouthView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
//    CGPoint currentPoint = CGPointMake(10, 10);
//    CGPoint lastPoint = CGPointMake(0, 0);
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIGraphicsBeginImageContext(CGSizeMake(rect.size.width, rect.size.height));
    //[drawImage.image drawInRect:CGRectMake(0, 0, 320, 568)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 5.0);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0, 2, 0, 2);
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 0, 0);
//    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
//    CGContextAddArcToPoint(UIGraphicsGetCurrentContext(), 150, 100, 150, 100, 60);
    CGContextAddCurveToPoint(UIGraphicsGetCurrentContext(), 0, 0, rect.size.width / 2, (rect.size.height / 2) + (rect.size.height / 4), rect.size.width, 0);
//    CGContextAddEllipseInRect(UIGraphicsGetCurrentContext(), CGRectMake(10, 20, 30, 30));
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    
    
//    [drawImage setFrame:CGRectMake(0, 0, 320, 568)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
//    lastPoint = currentPoint;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.opaque =  NO;
    self.opaque = NO;
    imageView.backgroundColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor greenColor];
    [self addSubview:imageView];
    // Drawing code
    
//    UIGraphicsBeginImageContext(CGSizeMake(150, 150));
//    CGContextRef currentContext = UIGraphicsGetCurrentContext();
//    CGContextMoveToPoint(currentContext, 150, 150);
//    CGContextSetAlpha(currentContext, 0.7f);
//    CGContextAddArcToPoint(currentContext, 100, 100, 150, 150, 40);
//    
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
////    [image drawInRect:rect];
//    UIGraphicsEndImageContext();
////    CGContextDrawImage(UIGraphicsGetCurrentContext(), rect, image.CGImage);
//        [image drawInRect:rect];

//    [self addSubview:[[UIImageView alloc] initWithImage: image] ];

}


@end
