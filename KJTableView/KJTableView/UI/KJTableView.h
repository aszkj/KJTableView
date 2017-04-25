//
//  KJTableView.h
//  KJTableView
//
//  Created by mm on 17/3/21.
//  Copyright © 2017年 mm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KJListEngine.h"
#import "KJListDatasoureEngine.h"

@interface KJTableView : UITableView

/**
 配置上下拉刷新，分页的数据累加，分页请求，空处理
 */
@property (nonatomic,strong)KJListEngine *listEngine;

/**
 配置table的数据源，代理等
 */
@property (nonatomic,strong)KJListDatasoureEngine *listDatasourceEngine;

@end
