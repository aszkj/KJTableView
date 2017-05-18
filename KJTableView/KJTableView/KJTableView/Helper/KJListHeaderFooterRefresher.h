//
//  KJListHeaderFooterRefresher.h
//  KJTableView
//
//  Created by mm on 17/3/21.
//  Copyright © 2017年 mm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KJConst.h"

@class KJListEngine;
@interface KJListHeaderFooterRefresher : NSObject

/*创建KJListHeaderFooterRefresher，传入一个列表，tableView或者collectionView**/
- (instancetype)initWithListEngine:(KJListEngine *)listEngine;

- (void)beginHeaderAutoRefresh:(RefreshDataBlock)headerAutoRefresh;

- (void)beginHeaderRefresh:(RefreshDataBlock)headerRefresh;

- (void)beginFooterRefresh:(RefreshDataBlock)footerRefresh;

- (void)resetNoMoreData;

- (void)endRefreshingWithNoMoreData;

- (void)headerEndRefreshing;

- (void)footerEndRefreshing;

- (void)showHeader:(BOOL)showHeader;

- (void)showFooter:(BOOL)showFooter;

- (void)configureRefreshHeaderFooter:(KJConfigureListHeaderFooterBlock)configureListHeaderFooterBlock;


@end
