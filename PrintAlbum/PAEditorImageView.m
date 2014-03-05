//
//  PAEditorImageView.m
//  PrintAlbum
//
//  Created by gw_ysy on 14-3-5.
//  Copyright (c) 2014年 PA. All rights reserved.
//

#import "PAEditorImageView.h"
#import "PAImageVIewCell.h"

@interface PAEditorImageView ()<PAImageVIewCellDelegate>

@end

@implementation PAEditorImageView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        PAImageVIewCell *cell1 = [[PAImageVIewCell alloc] initWithFrame:CGRectMake(10, 20, 200, 400) withImage:@"11.png"];
        cell1.delegate = self;
        
        PAImageVIewCell *cell2 = [[PAImageVIewCell alloc] initWithFrame:CGRectMake(250, 20, 300, 400) withImage:@"22.png"];
        cell2.delegate = self;

        PAImageVIewCell *cell3 = [[PAImageVIewCell alloc] initWithFrame:CGRectMake(10, 450, 200, 100) withImage:@"33.png"];
        cell3.delegate = self;

        PAImageVIewCell *cell4 = [[PAImageVIewCell alloc] initWithFrame:CGRectMake(250, 420, 400, 400) withImage:@"44.png"];
        cell4.delegate = self;

        [self addSubview:cell1];
        [self addSubview:cell2];
        [self addSubview:cell3];
        [self addSubview:cell4];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    
    
}

- (void)cellImageRemoveFromSuperView:(NSInteger)viewTag
{
    NSLog(@"cellImageRemoveFromSuperView");
}


@end
