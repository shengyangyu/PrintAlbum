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

@property (nonatomic,strong)UIImageView *tempImageView;

@end

@implementation PAEditorImageView
@synthesize tempImageView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        PAImageVIewCell *cell1 = [[PAImageVIewCell alloc] initWithFrame:CGRectMake(10, 20, 200, 400) withImage:@"11.png"];
        cell1.tag = 101;
        cell1.delegate = self;
        
        PAImageVIewCell *cell2 = [[PAImageVIewCell alloc] initWithFrame:CGRectMake(250, 20, 300, 400) withImage:@"22.png"];
        cell2.tag = 102;
        cell2.delegate = self;

        PAImageVIewCell *cell3 = [[PAImageVIewCell alloc] initWithFrame:CGRectMake(10, 450, 200, 100) withImage:@"33.png"];
        cell3.tag = 103;
        cell3.delegate = self;

        PAImageVIewCell *cell4 = [[PAImageVIewCell alloc] initWithFrame:CGRectMake(250, 420, 400, 400) withImage:@"44.png"];
        cell4.tag = 104;
        cell4.delegate = self;

        [self addSubview:cell1];
        [self addSubview:cell2];
        [self addSubview:cell3];
        [self addSubview:cell4];
        
        // temp imageview
        tempImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        tempImageView.hidden = YES;
        [self addSubview:tempImageView];
        
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    
    
}

#pragma mark cellImagdDelegate

- (void)cellImageDrggingOutView:(NSInteger)viewTag withPoint:(CGPoint)tPoint
{
    PAImageVIewCell *cell = (PAImageVIewCell *)[self viewWithTag:viewTag];
    // set temp imageview
    if (tempImageView.tag != viewTag) {
        UIImage *img = [UIImage imageNamed:@"11.png"];
        tempImageView.tag = viewTag;
        tempImageView.image = img;
        tempImageView.frame = CGRectMake(tPoint.x, tPoint.y, img.size.width/6, img.size.height/6);
    }
    // display temp imageview
    if (tempImageView.hidden == YES && cell.backView.hidden == YES) {
        tempImageView.hidden = NO;
    }
    // set temp imageview center to touch piont
    tempImageView.center = tPoint;
}

- (void)cellImageDrggingEnd:(NSInteger)viewTag
{
    // hidden temp imageview when dragging end
    tempImageView.hidden = YES;
}

@end
