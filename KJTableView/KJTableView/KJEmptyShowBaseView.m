//
//  BaseView.m
//  view继承
//
//  Created by mm on 17/3/23.
//  Copyright © 2017年 mm. All rights reserved.
//

#import "KJEmptyShowBaseView.h"

const NSInteger selfViewTag = -1000;
static NSString *defaultEmptyTitle = @"暂无数据";
static NSString *defaultEmptyImageName = @"哭脸";

@interface KJEmptyShowBaseView ()

@property (nonatomic,strong)UIView *containerView;

@end

@implementation KJEmptyShowBaseView

+ (KJEmptyShowBaseView *)createEmptyShowViewOnContainerView:(UIView *)containerView {

    KJEmptyShowBaseView *emptyShowView = [[KJEmptyShowBaseView alloc] init];
    emptyShowView.containerView = containerView;
    return emptyShowView;
}

+ (KJEmptyShowBaseView *)createEmptyShowViewWithNibName:(NSString *)nibName
                                        OnContainerView:(UIView *)containerView
{
    KJEmptyShowBaseView *emptyShowView = (KJEmptyShowBaseView *)[[[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil] lastObject];
    emptyShowView.containerView = containerView;
    return emptyShowView;
}

- (void)showEmptyWithTitle:(NSString *)title
                 imageName:(NSString *)imageName
{
    [self removeLastSelfView];
    self.tag = selfViewTag;
    [self.containerView addSubview:self];
    self.frame = CGRectMake(0, 0, CGRectGetWidth(self.containerView.bounds), CGRectGetHeight(self.containerView.bounds));
    [self setEmptyTitle:title imageName:imageName];
}

- (void)setEmptyTitle:(NSString *)title imageName:(NSString *)imageName{
    if (!title) {
        title = defaultEmptyTitle;
    }
    if (!imageName) {
        imageName = defaultEmptyImageName;
    }
    self.empty_show_title = title;
    self.empty_show_imageName = imageName;
}

- (void)removeLastSelfView {
    KJEmptyShowBaseView *lastSelfView = [self.containerView viewWithTag:selfViewTag];
    if (lastSelfView) {
        [lastSelfView removeFromSuperview];
    }
}

- (void)hideSelf {
    [self removeLastSelfView];
}


@end
