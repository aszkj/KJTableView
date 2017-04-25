//
//  KJCollectionView.h
//  KJTableView
//
//  Created by mm on 17/3/24.
//  Copyright © 2017年 mm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KJListEngine.h"
#import "KJListDatasoureEngine.h"


@interface KJCollectionView : UICollectionView

/**
 配置上下拉刷新，分页的数据累加，分页请求，空处理
 */
@property (nonatomic,strong)KJListEngine *listEngine;

/**
 配置collection的数据源，代理方法
 */
@property (nonatomic,strong)KJListDatasoureEngine *listDatasourceEngine;

@end
