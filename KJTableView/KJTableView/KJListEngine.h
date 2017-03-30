//
//  KJListEngine.h
//  KJTableView
//
//  Created by mm on 17/3/24.
//  Copyright © 2017年 mm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KJConst.h"

@interface KJListEngine : NSObject

/**
 创建KJListEngine
 */
- (instancetype)initWithListView:(id)listView;

/**
 列表数据
 */
@property (nonatomic,copy) NSArray *listDatas;

/**
 列表视图
 */
@property (nonatomic,weak)id listView;

#pragma mark - 数据加载
/**
 开始头部自动刷新
 */
- (void)beginHeaderAutoRefresh:(RefreshDataBlock)headerAutoRefresh;

/**
 开始头部刷新
 */
- (void)beginHeaderRefresh:(RefreshDataBlock)headerRefresh;

/**
 开始尾部刷新
 */
- (void)beginFooterRefresh:(RefreshDataBlock)footerRefresh;

/**
 分页后加载数据
 
 @param pagingDatas 每次分页请求的数据
 */
- (void)loadDataAfterRequestPagingData:(NSArray *)pagingDatas;

/**
 加载总数据，
 */
- (void)loadDataAfterRequestTotalData:(NSArray *)tatalDatas;


#pragma mark - 空处理
/**
 处理数据为空
 */
- (void)handleListDataEmptyCondition;

/**
 空情况，显示标题,默认暂无数据
 */
@property (nonatomic,copy)NSString *emptyShowTitle;

/**
 空情况，显示图片，默认哭脸
 */
@property (nonatomic,copy)NSString *emptyShowImageName;

/**
 是否需要处理列表为空情况，默认YES
 */
@property (nonatomic,assign)BOOL needHandleEmptyCondition;


#pragma mark - 分页请求
/**
 从哪一页开始请求
 */
@property (nonatomic, assign)NSInteger requestFromPage;

/**
 总页数
 */
@property (nonatomic, assign)NSInteger totalPage;

/**
 一页请求多少
 */
@property (nonatomic, assign)NSInteger requestPageSize;

/**
 是否是要分页
 */
@property (nonatomic,assign)BOOL needPaging;

/**
 设置自己的空展示视图，但是该视图必须得遵守以下规则
 1.继承KJEmptyShowBaseView
 2.调用KJEmptyShowBaseView的两个创建方法之一创建
 //代码创建的view
 + (KJEmptyShowBaseView *)createEmptyShowViewOnContainerView:(UIView *)containerView;
 //xib创建的
 + (KJEmptyShowBaseView *)createEmptyShowViewWithNibName:(NSString *)nibName
 OnContainerView:(UIView *)containerView;
 3.实现KJEmptyShowBaseView的- (void)showEmptyWithTitle:(NSString *)title
 imageName:(NSString *)imageName;方法，并在方法里面调用super的这个方法,之后写该视图自己的逻辑
 */
- (void)setCustomEmptyShowView:(id)customEmptyShowView;

#pragma mark - 头尾
/**
 显示/隐藏刷新头部
 */
- (void)showRefreshHeader:(BOOL)show;

/**
 显示/隐藏刷新尾部
 */
- (void)showRefreshFooter:(BOOL)show;

/**
 配置header,footer
 
 @param configureListHeaderFooterBlock 在回调中配置
 */
- (void)configureRefreshHeaderFooter:(KJConfigureListHeaderFooterBlock)configureListHeaderFooterBlock;



@end
