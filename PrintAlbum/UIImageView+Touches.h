//
//  UIImageView+Touches.h
//  PrintAlbum
//
//  Created by gw_ysy on 14-3-6.
//  Copyright (c) 2014年 PA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Touches)

// touch method
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;

@end
