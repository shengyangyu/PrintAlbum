//
//  PAImageVIewCell.h
//  PrintAlbum
//
//  Created by gw_ysy on 14-3-5.
//  Copyright (c) 2014年 PA. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PAImageVIewCellDelegate <NSObject>

@optional
- (void)cellImageRemoveFromSuperView:(NSInteger)viewTag;

@end

@interface PAImageVIewCell : UIView

// init for iamgeview cell
- (id)initWithFrame:(CGRect)frame withImage:(NSString *)imageName;

@property (nonatomic, assign) id /*<PAImageVIewCellDelegate>*/ delegate;

@end
