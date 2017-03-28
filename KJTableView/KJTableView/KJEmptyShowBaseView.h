//
//  BaseView.h
//  view继承
//
//  Created by mm on 17/3/23.
//  Copyright © 2017年 mm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KJEmptyShowBaseView : UIView

@property (nonatomic,copy)NSString *empty_show_title;

@property (nonatomic,copy)NSString *empty_show_imageName;

/**
 @param containerView 装载KJEmptyShowBaseView的父view

 @return 代码方式初始化的KJEmptyShowBaseView
 */
+ (KJEmptyShowBaseView *)createEmptyShowViewOnContainerView:(UIView *)containerView;

/**

 @param nibName       xib名字
 @param containerView  装载KJEmptyShowBaseView的父view
 
 @return xib创建的KJEmptyShowBaseView
 */
+ (KJEmptyShowBaseView *)createEmptyShowViewWithNibName:(NSString *)nibName
                                        OnContainerView:(UIView *)containerView;

/**

 @param title     空情况下展示的标题
 @param imageName 空情况下展示的图片名称
 */
- (void)showEmptyWithTitle:(NSString *)title
                 imageName:(NSString *)imageName;

- (void)hideSelf;

@end
