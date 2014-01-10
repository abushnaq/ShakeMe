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
    CGContextAddCurveToPoint(UIGraphicsGetCurrentContext(), 0, 0, rect.size.width / 2, (rect.size.height / 2) + (rect.size.height / 4), rect.size.width, 0);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.opaque =  NO;
    self.opaque = NO;
    [self addSubview:imageView];
}


@end
