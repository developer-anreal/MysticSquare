//
//  Common.m
//  Mystic Square
//
//  Created by Anton Serov on 3/23/15.
//  Copyright (c) 2015 hexforge. All rights reserved.
//

#import "Common.h"

void DrawLinearGradient(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef endColor) {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    
    NSArray *colors = @[(__bridge id) startColor, (__bridge id) endColor];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    
    CGContextSaveGState(context);
    CGContextAddRect(context, rect);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

void DrawGlossAndGradient(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef endColor) {
    DrawLinearGradient(context, rect, startColor, endColor);
    
    UIColor *glossColor1 = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.35];
    UIColor *glossColor2 = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.1];
    
    CGRect topHalf = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height / 2);
    
    DrawLinearGradient(context, topHalf, glossColor1.CGColor, glossColor2.CGColor);
}