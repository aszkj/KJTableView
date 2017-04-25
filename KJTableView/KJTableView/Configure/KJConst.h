//
//  KJConst.h
//  KJTableView
//
//  Created by mm on 17/3/21.
//  Copyright © 2017年 mm. All rights reserved.
//

#ifndef KJConst_h
#define KJConst_h
#import <UIKit/UIKit.h>
#import "KJListHeaderFooterConfigure.h"

typedef void(^RefreshDataBlock)();
typedef void(^KJConfigureListHeaderFooterBlock)(KJListHeaderFooterConfigure *headerFooterConfigure);

//block调用
#define KJCallBlock(block,...)  if (block) {\
block(__VA_ARGS__);\
}

//刷新header中UpdatedTimeLabel配置
#define KJHeaderlastUpdatedTimeLabelTextColor   [UIColor lightGrayColor]
#define KJHeaderlastUpdatedTimeLabelTextFont    [UIFont systemFontOfSize:12.0f]

//刷新header中StateLabel配置
#define KJHeaderStateLabelTextColor             [UIColor lightGrayColor]
#define KJHeaderStateLabelTextFont              [UIFont systemFontOfSize:12.0f]

//刷新footer中StateLabel配置
#define KJFooterStateLabelTextColor             [UIColor lightGrayColor]
#define KJFooterStateLabelTextFont              [UIFont systemFontOfSize:12.0f]

#endif /* KJConst_h */
