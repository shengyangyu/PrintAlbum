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

@property (nonatomic,strong)UIImageView    *tempImageView;
@property (nonatomic,strong)NSMutableArray *cellArray;

@end

@implementation PAEditorImageView
@synthesize tempImageView;
@synthesize cellArray;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        PAImageVIewCell *cell1 = [[PAImageVIewCell alloc] initWithFrame:CGRectMake(10, 10, 300, 300) withImage:@"11.png"];
        cell1.tag = 101;
        cell1.delegate = self;
        
        PAImageVIewCell *cell2 = [[PAImageVIewCell alloc] initWithFrame:CGRectMake(320, 10, 300, 300) withImage:@"22.png"];
        cell2.tag = 102;
        cell2.delegate = self;

        PAImageVIewCell *cell3 = [[PAImageVIewCell alloc] initWithFrame:CGRectMake(10, 320, 300, 300) withImage:@"33.png"];
        cell3.tag = 103;
        cell3.delegate = self;

        PAImageVIewCell *cell4 = [[PAImageVIewCell alloc] initWithFrame:CGRectMake(320, 320, 300, 300) withImage:@"44.png"];
        cell4.tag = 104;
        cell4.delegate = self;

        // add rect array
        cellArray = [NSMutableArray array];
        [cellArray addObject:cell1];
        [cellArray addObject:cell2];
        [cellArray addObject:cell3];
        [cellArray addObject:cell4];
        
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
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"%d%d.png",viewTag-100,viewTag-100]];
        tempImageView.tag = viewTag;
        tempImageView.image = img;
        tempImageView.frame = CGRectMake(tPoint.x, tPoint.y, img.size.width/6, img.size.height/6);
    }
    // display temp imageview
    if (tempImageView.hidden == YES && cell.backView.hidden == YES) {
        tempImageView.hidden = NO;
    }
    // check view and display red layer
    for (PAImageVIewCell *cellInfo in cellArray) {
        //NSLog(@"--%@,%@",NSStringFromCGPoint(tPoint),NSStringFromCGRect(cellInfo.frame));
        [cellInfo displayOrHiddenViewLayer:YES];
        if (cellInfo.tag != viewTag) {
            if (CGRectContainsPoint(cellInfo.frame,tPoint)) {
                [cellInfo displayOrHiddenViewLayer:NO];
            }
        }
    }
    // set temp imageview center to touch piont
    tempImageView.center = tPoint;
    
}

- (void)cellImageDrggingEnd:(NSInteger)viewTag withPoint:(CGPoint)tPoint
{
    // hidden temp imageview when dragging end
    tempImageView.hidden = YES;
    // when touch end if other view selected will exchange
    for (PAImageVIewCell *cellSecond in cellArray) {
        [cellSecond displayOrHiddenViewLayer:YES];
        if (cellSecond.tag != viewTag) {
            if (CGRectContainsPoint(cellSecond.frame,tPoint)) {
                PAImageVIewCell *cellFirst = (PAImageVIewCell *)[self viewWithTag:viewTag];
                CGRect rectFirst = cellFirst.frame;
                CGRect rectSecond = cellSecond.frame;
                [cellFirst setFrame:rectSecond];
                [cellSecond setFrame:rectFirst];
                return;
            }
        }
    }
}

@end
