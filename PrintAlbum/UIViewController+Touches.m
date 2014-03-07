//
//  UIViewController+Touches.m
//  PrintAlbum
//
//  Created by gw_ysy on 14-3-7.
//  Copyright (c) 2014年 PA. All rights reserved.
//

#import "UIViewController+Touches.h"

@implementation UIViewController (Touches)

#pragma mark touch method

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"UIViewController:touchesBegan");
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"UIViewController:touchesMoved");
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"UIViewController:touchesEnded");
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"UIViewController:touchesCancelled");
}

@end
