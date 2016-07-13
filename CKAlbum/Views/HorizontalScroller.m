//
//  HorizontalScroller.m
//  CKAlbum
//
//  Created by  泛达 on 16/5/15.
//  Copyright © 2016年 CK. All rights reserved.
//

#import "HorizontalScroller.h"

// 1
#define VIEW_PADDING 10
#define VIEW_DIMENSIONS 100
#define VIEW_OFFSET 100

// 2
@interface HorizontalScroller ()<UIScrollViewDelegate>

@end

@implementation HorizontalScroller
{
    UIScrollView *scroller;
}

- (id)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        scroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 10, frame.size.width, frame.size.height - 10)];
        scroller.delegate = self;
        [self addSubview:scroller];
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollerTapped:)];
        [scroller addGestureRecognizer:tapRecognizer];
    }
    return self;
}

#pragma mark - public methods
- (void)reload {

    // 1 - nothing to load if there's no delegate
    if (self.delegate == nil) {
        return;
    }
    
    // 2 - remove all subviews
    
    [scroller.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    // 3 - xValue is the starting point of the views inside the scroller
    CGFloat xValue = VIEW_OFFSET;
    for (int i = 0; i < [self.delegate numberOfViewsForHorizontalScroller:self]; i ++) {
        // 4 - add a view at the right position
        xValue += VIEW_PADDING;
        UIView *view = [self.delegate horizontalScroller:self viewAtIndex:i];
        view.frame = CGRectMake(xValue, VIEW_PADDING, VIEW_DIMENSIONS, VIEW_DIMENSIONS);
        [scroller addSubview:view];
        xValue += VIEW_DIMENSIONS + VIEW_PADDING;
    }
    
    // 5
    [scroller setContentSize:CGSizeMake(xValue + VIEW_OFFSET, scroller.frame.size.height)];
    
    // 6 - if an initial view is defined, center the scroller on it
    if ([self.delegate respondsToSelector:@selector(initialViewIndexForHorizontalScroller:)]) {
        NSInteger initialView = [self.delegate initialViewIndexForHorizontalScroller:self];
        [scroller setContentOffset:CGPointMake(initialView * (VIEW_DIMENSIONS + (2 * VIEW_PADDING)), 0) animated:YES];
    }
}

#pragma mark - private method
- (void)scrollerTapped:(UITapGestureRecognizer *)gesture {

    CGPoint location = [gesture locationInView:gesture.view];
    
    for (int index = 0; index < [self.delegate numberOfViewsForHorizontalScroller:self]; index ++) {
        UIView *view = scroller.subviews[index];
        if (CGRectContainsPoint(view.frame, location)) {
            [self.delegate horizontalScroller:self clickedViewAtIndex:index];
            [scroller setContentOffset:CGPointMake(view.frame.origin.x - self.frame.size.width/2 + view.frame.size.width/2, 0) animated:YES];
            break;
        }
    }
    
}

- (void)centerCurrentView {

    int xFinal = scroller.contentOffset.x + (VIEW_OFFSET/2) + VIEW_PADDING;
    int viewIndex = xFinal / (VIEW_DIMENSIONS + (2 * VIEW_PADDING));
    UIView *view = scroller.subviews[viewIndex];
    //    xFinal = viewIndex * (VIEW_DIMENSIONS+(2*VIEW_PADDING));
    xFinal = view.frame.origin.x - self.frame.size.width/2 + view.frame.size.width/2;

    [scroller setContentOffset:CGPointMake(xFinal, 0) animated:YES];
    [self.delegate horizontalScroller:self clickedViewAtIndex:viewIndex];
}

#pragma mark - scroller delegate 

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {

    if (!decelerate) {
        [self centerCurrentView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    [self centerCurrentView];
}

- (void)didMoveToSuperview {

    [self reload];
}
@end

