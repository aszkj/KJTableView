//
//  KJDataLoader.h
//  KJTableView
//
//  Created by mm on 17/3/21.
//  Copyright © 2017年 mm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KJConst.h"

@class KJListHeaderFooterRefresher;
@class KJListDataRequester;
@class KJListDataEmptyHandler;
@class KJListEngine;
@interface KJListDataLoadManager : NSObject

- (instancetype)initWithListHeaderFooterRefresher:(KJListHeaderFooterRefresher *)           listHeaderFooterRefresher
                                listDataRequester:(KJListDataRequester *)listDataRequester
                             listDataEmptyHandler:(KJListDataEmptyHandler *)listDataEmptyHandler
                                       listEngine:(KJListEngine *)listEngine;


- (void)beginHeaderAutoRefresh:(RefreshDataBlock)headerAutoRefresh;

- (void)beginHeaderRefresh:(RefreshDataBlock)headerRefresh;

- (void)beginFooterRefresh:(RefreshDataBlock)footerRefresh;

- (void)loadDataAfterRequestPagingData:(NSArray *)pagingDatas;

- (void)loadDataAfterRequestTotalData:(NSArray *)tatalDatas;

- (void)handleListDataEmptyCondition;

- (void)showRefreshHeader:(BOOL)show;

- (void)showRefreshFooter:(BOOL)show;

@end
