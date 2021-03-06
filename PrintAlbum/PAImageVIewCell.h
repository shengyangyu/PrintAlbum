//
//  PAImageVIewCell.h
//  PrintAlbum
//
//  Created by gw_ysy on 14-3-5.
//  Copyright (c) 2014年 PA. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "UIScrollView+Touches.h"
//#import "UIImageView+Touches.h"

@protocol PAImageVIewCellDelegate <NSObject>

@optional

- (void)cellImageDrggingOutView:(NSInteger)viewTag withPoint:(CGPoint)tPoint;

- (void)cellImageDrggingEnd:(NSInteger)viewTag withPoint:(CGPoint)tPoint;

@end

@interface PAImageVIewCell : UIView

@property (nonatomic,strong) NSString *tempImageName;
@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UIScrollView *mainScrollerView;
@property (nonatomic,strong) UIImageView  *cellImageView;
@property (nonatomic,strong) UIImage *cellImage;
@property (nonatomic,getter=isHiddenLayer) BOOL hiddenLayer;
@property (nonatomic, assign) id /*<PAImageVIewCellDelegate>*/ delegate;

// init for iamgeview cell
- (id)initWithFrame:(CGRect)frame withImage:(NSString *)imageName;
// hidden or display layer
- (void)displayOrHiddenViewLayer:(BOOL)isHidden;
// redraw 
- (void)drawImageAddView:(NSString *)imageName withFrame:(CGRect)frame;

@end
