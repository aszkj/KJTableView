//
//  KJRefreshRequester.h
//  KJTableView
//
//  Created by mm on 17/3/21.
//  Copyright © 2017年 mm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KJListDataRequester : NSObject

/**从哪一页开始请求*/
@property (nonatomic, assign)NSInteger requestFromPage;

/**总页数*/
@property (nonatomic, assign)NSInteger totalPage;

/**一页请求多少*/
@property (nonatomic, assign)NSInteger requestPageSize;

/**是否是要分页*/
@property (nonatomic,assign)BOOL needPaging;

/**是否是头部自动刷新*/
@property (nonatomic, assign,getter=isHeaderAutoRefresh)BOOL headerAutoRefresh;

/**是否已经自动刷新了*/
@property (nonatomic, assign)BOOL hasFinishedHeaderAutoFresh;

/**自动刷新配置*/
- (void)headerAutoRefreshConfigure;

/**重置请求页*/
- (void)resetRequestPage;

/**完成自动刷新配置*/
- (void)hasFinishedAutoRefreshConfigure;

/**翻页*/
- (void)goNextPage;

@end
