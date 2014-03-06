//
//  UIImageView+Touches.m
//  PrintAlbum
//
//  Created by gw_ysy on 14-3-6.
//  Copyright (c) 2014年 PA. All rights reserved.
//

#import "UIImageView+Touches.h"

@implementation UIImageView (Touches)

#pragma mark touch method

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesBegan");
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesMoved");
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesEnded");
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesCancelled");
}

@end
