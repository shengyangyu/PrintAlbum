//
//  PAImageVIewCell.m
//  PrintAlbum
//
//  Created by gw_ysy on 14-3-5.
//  Copyright (c) 2014年 PA. All rights reserved.
//

#import "PAImageVIewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+Touches.h"


@interface PAImageVIewCell ()<UIGestureRecognizerDelegate,UIScrollViewDelegate>



@end

@implementation PAImageVIewCell
@synthesize backView;
@synthesize mainScrollerView;
@synthesize cellImage;
@synthesize cellImageView;
@synthesize delegate;
@synthesize hiddenLayer;

- (id)initWithFrame:(CGRect)frame withImage:(NSString *)imageName
{
    self = [super initWithFrame:frame];
    if (self) {
        self.cellImage = [UIImage imageNamed:imageName];
        self.backgroundColor = [UIColor grayColor];
        self.layer.borderColor = [[UIColor redColor] CGColor];
        hiddenLayer = YES;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    backView = [[UIView alloc] initWithFrame:rect];
    
    CGSize currentSize;
    // adapt to small size
    if (rect.size.width < rect.size.height) {
        // first adapt to image
        CGFloat wscale = rect.size.width/cellImage.size.width;
        currentSize = CGSizeMake(cellImage.size.width*wscale, cellImage.size.height*wscale);
        // second adapt to dispaly view
        CGFloat hscale = rect.size.height / currentSize.height;
        if (hscale > 1.0) {
            currentSize = CGSizeMake(currentSize.width * hscale, currentSize.height * hscale);
        }
    }
    // adapt to other size
    else
    {
        // first adapt to image
        CGFloat hscale = rect.size.height/cellImage.size.height;
        currentSize = CGSizeMake(cellImage.size.width*hscale, cellImage.size.height*hscale);
        // second adapt to dispaly view
        CGFloat wscale = rect.size.width / currentSize.width;
        if (wscale > 1.0) {
            currentSize = CGSizeMake(currentSize.width * wscale, currentSize.height * wscale);
        }
    }
    
    // main scrollerview
    mainScrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width,rect.size.height)];
    [mainScrollerView setContentSize:CGSizeMake(currentSize.width + 1, currentSize.height + 1)];
    mainScrollerView.multipleTouchEnabled=YES;
    mainScrollerView.minimumZoomScale=1.1;
    mainScrollerView.maximumZoomScale=3.0;
    mainScrollerView.delegate=self;
    mainScrollerView.showsHorizontalScrollIndicator = NO;
    mainScrollerView.showsVerticalScrollIndicator = NO;
    mainScrollerView.scrollEnabled = YES;
    mainScrollerView.backgroundColor = [UIColor grayColor];
    mainScrollerView.canCancelContentTouches = YES;
    mainScrollerView.delaysContentTouches = NO;
    // cell imageview
    cellImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, currentSize.width, currentSize.height)];
    cellImageView.image = cellImage;
    cellImageView.userInteractionEnabled = YES;
    cellImageView.backgroundColor = [UIColor clearColor];
    [mainScrollerView addSubview:cellImageView];
    
    // GestureRecognizer
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMethod:)];
    [tapGesture setDelegate:self];
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.numberOfTouchesRequired = 1;
    [cellImageView addGestureRecognizer:tapGesture];
    
    [backView addSubview:mainScrollerView];
    [self addSubview:backView];
    backView.clipsToBounds = YES;
    
}

- (void)tapMethod:(UITapGestureRecognizer *)sender
{
    [self displayOrHiddenViewLayer:!hiddenLayer];
}

#pragma mark set view layer
- (void)displayOrHiddenViewLayer:(BOOL)isHidden
{
    if (isHidden == YES) {
        self.layer.borderWidth = 0;
        hiddenLayer = YES;
    }else{
        self.layer.borderWidth = 4;
        hiddenLayer = NO;
    }
}

#pragma mark UIScrollView delegate methods
// image scale
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    return cellImageView;
}
// image center
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?(scrollView.bounds.size.width - scrollView.contentSize.width)/2 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?(scrollView.bounds.size.height - scrollView.contentSize.height)/2 : 0.0;
    self.cellImageView.center = CGPointMake(scrollView.contentSize.width/2 + offsetX,scrollView.contentSize.height/2 + offsetY);
}
// hidden scrollerview
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self displayOrHiddenViewLayer:YES];
    if (scrollView.dragging == NO) {
        return;
    }
    if(((fabs(scrollView.contentOffset.x) / self.frame.size.width) > 0.3) ||
       ((fabs(scrollView.contentOffset.y) / self.frame.size.height) > 0.3)){
        if ([delegate respondsToSelector:@selector(cellImageRemoveFromSuperView:)]) {
            [delegate cellImageRemoveFromSuperView:self.tag];
        }
    }
}
// if dragging end scrllerview need dispaly
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    self.backView.hidden = NO;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesBegan1");
}

@end
