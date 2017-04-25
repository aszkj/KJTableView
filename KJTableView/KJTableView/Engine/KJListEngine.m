//
//  KJListEngine.m
//  KJTableView
//
//  Created by mm on 17/3/24.
//  Copyright © 2017年 mm. All rights reserved.
//

#import "KJListEngine.h"
#import "KJListHeaderFooterRefresher.h"
#import "KJListDataRequester.h"
#import "KJListDataEmptyHandler.h"
#import "KJListDataLoadManager.h"

@interface KJListEngine ()

@property (nonatomic,strong)KJListHeaderFooterRefresher *listHeaderFooterRefresher;

@property (nonatomic,strong)KJListDataRequester *listDataRequester;

@property (nonatomic,strong)KJListDataEmptyHandler *listDataEmptyHandler;

@property (nonatomic,strong)KJListDataLoadManager *listDataLoadManager;

@end

@implementation KJListEngine

- (instancetype)initWithListView:(id)listView {
    
    if (self = [super init]) {
        self.listView = listView;
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.listHeaderFooterRefresher = [[KJListHeaderFooterRefresher alloc] initWithListEngine:self];
    self.listDataRequester = [[KJListDataRequester alloc] init];
    self.listDataEmptyHandler = [[KJListDataEmptyHandler alloc] initWithListEngine:self];
    self.listDataLoadManager = [[KJListDataLoadManager alloc] initWithListHeaderFooterRefresher:self.listHeaderFooterRefresher listDataRequester:self.listDataRequester listDataEmptyHandler:self.listDataEmptyHandler listEngine:self];
}
#pragma mark ---------------------Public Method------------------------------
#pragma mark - listDataLoadManager done
- (void)beginHeaderAutoRefresh:(RefreshDataBlock)headerAutoRefresh {
    [self.listDataLoadManager beginHeaderAutoRefresh:headerAutoRefresh];
}

- (void)beginHeaderRefresh:(RefreshDataBlock)headerRefresh {
    
    [self.listDataLoadManager beginHeaderRefresh:headerRefresh];
    
}

- (void)beginFooterRefresh:(RefreshDataBlock)footerRefresh {
    [self.listDataLoadManager beginFooterRefresh:footerRefresh];
    
}

- (void)loadDataAfterRequestPagingData:(NSArray *)pagingDatas {
    [self.listDataLoadManager loadDataAfterRequestPagingData:pagingDatas];
}

- (void)loadDataAfterRequestTotalData:(NSArray *)tatalDatas {
    [self.listDataLoadManager loadDataAfterRequestTotalData:tatalDatas];
}

#pragma mark - listDataEmptyHandler done
- (void)handleListDataEmptyCondition {
    [self.listDataEmptyHandler handleEmptyCondition];
}

- (void)setEmptyShowTitle:(NSString *)emptyShowTitle {
    self.listDataEmptyHandler.empty_show_title = emptyShowTitle;
}

- (void)setEmptyShowImageName:(NSString *)emptyShowImageName {
    self.listDataEmptyHandler.empty_show_imageName = emptyShowImageName;
}

- (void)setNeedHandleEmptyCondition:(BOOL)needHandleEmptyCondition {
    self.listDataEmptyHandler.needHandleEmptyCondition = needHandleEmptyCondition;
}

- (void)setCustomEmptyShowView:(id)customEmptyShowView {
    [self.listDataEmptyHandler setCustomEmptyShowView:customEmptyShowView];
}

#pragma mark - listDataRequester done
- (void)setRequestFromPage:(NSInteger)requestFromPage {
    self.listDataRequester.requestFromPage = requestFromPage;
}

- (NSInteger)requestFromPage {
    return self.listDataRequester.requestFromPage;
}

- (void)setTotalPage:(NSInteger)totalPage {
    self.listDataRequester.totalPage = totalPage;
}

- (void)setRequestPageSize:(NSInteger)requestPageSize {
    self.listDataRequester.requestPageSize = requestPageSize;
}

- (NSInteger)requestPageSize {
    return self.listDataRequester.requestPageSize;
}

- (void)setNeedPaging:(BOOL)needPaging {
    self.listDataRequester.needPaging = needPaging;
}

#pragma mark - listHeaderFooterRefresher done
- (void)showRefreshHeader:(BOOL)show {
    [self.listHeaderFooterRefresher showHeader:show];
}

- (void)showRefreshFooter:(BOOL)show {
    [self.listHeaderFooterRefresher showFooter:show];
}

- (void)configureRefreshHeaderFooter:(KJConfigureListHeaderFooterBlock)configureListHeaderFooterBlock {
    [self.listHeaderFooterRefresher configureRefreshHeaderFooter:configureListHeaderFooterBlock];
}

@end
