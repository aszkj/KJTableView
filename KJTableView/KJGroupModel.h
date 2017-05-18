//
//  KJGroupModel.h
//  KJTableView
//
//  Created by mm on 17/3/29.
//  Copyright © 2017年 mm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KJModel.h"

@interface KJGroupModel : NSObject

@property (nonatomic,copy)NSString *groupName;

@property (nonatomic,copy)NSArray<KJGroupModel *> *groupItems;

@end
