//
//  PAImageVIewCell.m
//  PrintAlbum
//
//  Created by gw_ysy on 14-3-5.
//  Copyright (c) 2014年 PA. All rights reserved.
//

#import "PAImageVIewCell.h"

@interface PAImageVIewCell ()<UIGestureRecognizerDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *mainScrollerView;
@property (nonatomic,strong) UIImageView  *cellImageView;
@property (nonatomic,strong) UIImage *cellImage;

@end

@implementation PAImageVIewCell
@synthesize mainScrollerView;
@synthesize cellImage;
@synthesize cellImageView;
@synthesize delegate;

static CGFloat lastScale = 0.0;

- (id)initWithFrame:(CGRect)frame withImage:(NSString *)imageName
{
    self = [super initWithFrame:frame];
    if (self) {
        self.cellImage = [UIImage imageNamed:imageName];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
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
    mainScrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    [mainScrollerView setContentSize:CGSizeMake(currentSize.width + 1, currentSize.height + 1)];
    mainScrollerView.multipleTouchEnabled=YES;
    mainScrollerView.minimumZoomScale=1.0;
    mainScrollerView.maximumZoomScale=3.0;
    mainScrollerView.delegate=self;
    mainScrollerView.showsHorizontalScrollIndicator = NO;
    mainScrollerView.showsVerticalScrollIndicator = NO;
    mainScrollerView.scrollEnabled = YES;
    mainScrollerView.backgroundColor = [UIColor grayColor];
    
    // cell imageview
    cellImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, currentSize.width, currentSize.height)];
    cellImageView.image = cellImage;
    cellImageView.userInteractionEnabled = YES;
    cellImageView.backgroundColor = [UIColor clearColor];
    [mainScrollerView addSubview:cellImageView];
    
    // GestureRecognizer
    UIPinchGestureRecognizer *pinGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinMethod:)];
    [pinGesture setDelegate:self];
    //[cellImageView addGestureRecognizer:pinGesture];
    
    
    
    [self addSubview:mainScrollerView];
    //mainScrollerView.center = self.center;
    self.clipsToBounds = YES;
    
}

- (void)pinMethod:(UIPinchGestureRecognizer *)sender
{
    // when pin end scale = 1.0
    if([sender state] == UIGestureRecognizerStateEnded)
    {
        lastScale = 1.0;
        return;
    }
    CGFloat scale = 1.0 - (lastScale - [(UIPinchGestureRecognizer*)sender scale]);
    CGAffineTransform currentTransform = cellImageView.transform;
    CGAffineTransform nextTransform = CGAffineTransformScale(currentTransform, scale, scale);
    [cellImageView setTransform:nextTransform];
    lastScale = [sender scale];
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(((fabs(scrollView.contentOffset.x) / self.frame.size.width) > 0.3) ||
       ((fabs(scrollView.contentOffset.y) / self.frame.size.height) > 0.3)){
        if ([delegate respondsToSelector:@selector(cellImageRemoveFromSuperView:)]) {
            [delegate cellImageRemoveFromSuperView:0];
        }
    }
}

@end
