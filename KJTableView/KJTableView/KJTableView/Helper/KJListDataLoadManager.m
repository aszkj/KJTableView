//
//  KJDataLoader.m
//  KJTableView
//
//  Created by mm on 17/3/21.
//  Copyright © 2017年 mm. All rights reserved.
//

#import "KJListDataLoadManager.h"
#import "KJListHeaderFooterRefresher.h"
#import "KJListDataRequester.h"
#import "KJListDataEmptyHandler.h"
#import "KJListEngine.h"
#import <UIKit/UIKit.h>

@interface KJListDataLoadManager ()

@property (nonatomic,strong)KJListHeaderFooterRefresher *listHeaderFooterRefresher;

@property (nonatomic,strong)KJListDataRequester *listDataRequester;

@property (nonatomic,strong)KJListDataEmptyHandler *listDataEmptyHandler;

@property (nonatomic,weak)KJListEngine *listEngine;


@end

@implementation KJListDataLoadManager

- (instancetype)initWithListHeaderFooterRefresher:(KJListHeaderFooterRefresher *)           listHeaderFooterRefresher
                                listDataRequester:(KJListDataRequester *)listDataRequester
                             listDataEmptyHandler:(KJListDataEmptyHandler *)listDataEmptyHandler
                                       listEngine:(KJListEngine*)listEngine

{
    
    if (self = [super init]) {
        self.listHeaderFooterRefresher = listHeaderFooterRefresher;
        self.listDataRequester = listDataRequester;
        self.listDataEmptyHandler = listDataEmptyHandler;
        self.listEngine = listEngine;
    }
    return self;
}


- (void)beginHeaderAutoRefresh:(RefreshDataBlock)headerAutoRefresh {
    [self.listDataRequester headerAutoRefreshConfigure];
    [self.listHeaderFooterRefresher beginHeaderAutoRefresh:headerAutoRefresh];
}

- (void)beginHeaderRefresh:(RefreshDataBlock)headerRefresh {
    __weak typeof(self) weak_self = self;
    [self.listHeaderFooterRefresher beginHeaderRefresh:^{
        //下拉刷新
        if (!weak_self.listDataRequester.isHeaderAutoRefresh) {//如果不是自动刷新
            [weak_self.listDataRequester resetRequestPage];
            //重置nomoredata
            [weak_self.listHeaderFooterRefresher resetNoMoreData];
            KJCallBlock(headerRefresh);
        }
    }];
}

- (void)beginFooterRefresh:(RefreshDataBlock)footerRefresh {
    [self.listHeaderFooterRefresher beginFooterRefresh:footerRefresh];
}

- (void)loadDataAfterRequestPagingData:(NSArray *)pagingDatas {
    NSArray *originalListDatas = self.listEngine.listDatas;
    NSMutableArray *newListDatas = [NSMutableArray arrayWithArray:originalListDatas];
    
    if (self.listDataRequester.totalPage > 0) {
        if (self.listDataRequester.requestFromPage > self.listDataRequester.totalPage) {
            [self.listHeaderFooterRefresher endRefreshingWithNoMoreData];
            [self.listHeaderFooterRefresher showFooter:NO];
            return;
        }else {
            [self.listHeaderFooterRefresher showFooter:YES];
            [self.listHeaderFooterRefresher resetNoMoreData];
        }
    }
    
    //自动刷新
    if (self.listDataRequester.isHeaderAutoRefresh) {
        //标志完成自动刷新
        [self.listDataRequester hasFinishedAutoRefreshConfigure];
        [self.listHeaderFooterRefresher headerEndRefreshing];
    }
    
    //处理停止上下拉刷新逻辑
    if (self.listDataRequester.requestFromPage == 1 && !self.listDataRequester.isHeaderAutoRefresh) {//下拉非自动刷新
        [self.listHeaderFooterRefresher headerEndRefreshing];
    }else {//上拉加载更多
        [self.listHeaderFooterRefresher footerEndRefreshing];
    }

    //如果是加载更多，数据源拼在后面，下拉或自动刷新，替换数据源
    if (self.listDataRequester.requestFromPage == 1) {
        newListDatas = [NSMutableArray arrayWithArray:pagingDatas];
    }else {
        [newListDatas addObjectsFromArray:pagingDatas];
    }
    
    self.listEngine.listDatas = [newListDatas copy];
    [self reloadListView];
    
    if (self.listDataRequester.needPaging) {
        [self.listDataRequester goNextPage];
    }
    
    if (pagingDatas.count < self.listDataRequester.requestPageSize) {
        [self.listHeaderFooterRefresher endRefreshingWithNoMoreData];
        [self.listHeaderFooterRefresher showFooter:NO];
    }else {
        [self.listHeaderFooterRefresher showFooter:YES];
        [self.listHeaderFooterRefresher resetNoMoreData];
    }

    [self.listDataEmptyHandler handleEmptyCondition];
}

- (void)loadDataAfterRequestTotalData:(NSArray *)tatalDatas {
    self.listEngine.listDatas = [tatalDatas copy];
    [self reloadListView];
    [self.listDataEmptyHandler handleEmptyCondition];
}

- (void)handleListDataEmptyCondition {
    [self.listDataEmptyHandler handleEmptyCondition];
}

- (void)showRefreshHeader:(BOOL)show {
    [self.listHeaderFooterRefresher showHeader:show];
}

- (void)showRefreshFooter:(BOOL)show {
    [self.listHeaderFooterRefresher showFooter:show];
}


- (void)reloadListView {
    if ([self.listEngine.listView isKindOfClass:[UITableView class]]) {
        [(UITableView *)self.listEngine.listView reloadData];
    }else if ([self.listEngine.listView isKindOfClass:[UICollectionView class]]) {
        [(UICollectionView *)self.listEngine.listView reloadData];
    }
}



@end
