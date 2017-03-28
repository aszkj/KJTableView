//
//  KJEmptyHandler.h
//  KJTableView
//
//  Created by mm on 17/3/21.
//  Copyright © 2017年 mm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class KJListEngine;
@interface KJListDataEmptyHandler : NSObject

- (instancetype)initWithListEngine:(KJListEngine *)listEngine;

@property (nonatomic,copy)NSString *empty_show_title;

@property (nonatomic,copy)NSString *empty_show_imageName;

@property (nonatomic,strong)UIColor *empty_backgroundColor;

@property (nonatomic,assign)BOOL needHandleEmptyCondition;

- (void)handleEmptyCondition;

@end
