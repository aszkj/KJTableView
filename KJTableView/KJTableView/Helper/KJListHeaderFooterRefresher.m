//
//  KJListHeaderFooterRefresher.m
//  KJTableView
//
//  Created by mm on 17/3/21.
//  Copyright © 2017年 mm. All rights reserved.
//

#import "KJListHeaderFooterRefresher.h"
#import <UIKit/UIKit.h>
#import "MJRefresh.h"
#import "KJListEngine.h"
#import "KJListHeaderFooterConfigure.h"

@interface KJListHeaderFooterRefresher ()

@property (nonatomic,weak)UIScrollView *refreshListView;

@property (nonatomic,strong) KJListHeaderFooterConfigure *listHeaderFooterConfigure;

@end

@implementation KJListHeaderFooterRefresher

- (instancetype)initWithListEngine:(KJListEngine *)listEngine{
    
    if (self = [super init]) {
        self.refreshListView = (UIScrollView *)listEngine.listView;
        self.listHeaderFooterConfigure = [[KJListHeaderFooterConfigure alloc] init];
    }
    return self;
}

- (void)beginHeaderAutoRefresh:(RefreshDataBlock)headerAutoRefresh {

    [self.refreshListView.mj_header beginRefreshing];
    KJCallBlock(headerAutoRefresh);
    
}

- (void)beginHeaderRefresh:(RefreshDataBlock)headerRefresh {

    //上下拉刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        KJCallBlock(headerRefresh);
    }];
    self.refreshListView.mj_header = header;
    [self configureHeader];
}

- (void)beginFooterRefresh:(RefreshDataBlock)footerRefresh {
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //上拉刷新
        KJCallBlock(footerRefresh);
    }];
    self.refreshListView.mj_footer = footer;
    [self configureFooter];
}

- (void)resetNoMoreData {
    [self.refreshListView.mj_footer resetNoMoreData];
}

- (void)endRefreshingWithNoMoreData {
    [self.refreshListView.mj_footer endRefreshingWithNoMoreData];
}

- (void)headerEndRefreshing {
    [self.refreshListView.mj_header endRefreshing];
}

- (void)footerEndRefreshing {
    [self.refreshListView.mj_footer endRefreshing];
}

- (void)showHeader:(BOOL)showHeader {
    self.refreshListView.mj_header.hidden = !showHeader;
}

- (void)showFooter:(BOOL)showFooter {
    self.refreshListView.mj_footer.hidden = !showFooter;
}

- (void)configureRefreshHeaderFooter:(KJConfigureListHeaderFooterBlock)configureListHeaderFooterBlock {
    configureListHeaderFooterBlock(self.listHeaderFooterConfigure);
    [self configureHeader];
    [self configureFooter];
}

- (void)configureHeader {
    MJRefreshNormalHeader *header = (MJRefreshNormalHeader *)self.refreshListView.mj_header;
    header.lastUpdatedTimeLabel.textColor = self.listHeaderFooterConfigure.headerlastUpdatedTimeLabelTextColor;
    header.lastUpdatedTimeLabel.font = self.listHeaderFooterConfigure.headerlastUpdatedTimeLabelTextFont;
    header.stateLabel.textColor = self.listHeaderFooterConfigure.headerStateLabelTextColor;
    header.stateLabel.font = self.listHeaderFooterConfigure.headerStateLabelTextFont;
}

- (void)configureFooter {
    MJRefreshAutoNormalFooter *footer = (MJRefreshAutoNormalFooter *)self.refreshListView.mj_footer;
    footer.stateLabel.textColor = self.listHeaderFooterConfigure.footerStateLabelTextColor;
    footer.stateLabel.font = self.listHeaderFooterConfigure.footerStateLabelTextFont;

}


@end
