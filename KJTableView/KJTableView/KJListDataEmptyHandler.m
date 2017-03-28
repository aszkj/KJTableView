//
//  KJEmptyHandler.m
//  KJTableView
//
//  Created by mm on 17/3/21.
//  Copyright © 2017年 mm. All rights reserved.
//

#import "KJListDataEmptyHandler.h"
#import "KJEmptyShowBaseView.h"
#import "KJListEmptyShowView.h"
#import "KJListEngine.h"

@interface KJListDataEmptyHandler ()

@property (nonatomic,weak)KJListEngine *listEngine;

@property (nonatomic,strong) KJEmptyShowBaseView *listEmptyShowView;

@end

@implementation KJListDataEmptyHandler

- (instancetype)initWithListEngine:(KJListEngine *)listEngine;{

    if (self = [super init]) {
        self.needHandleEmptyCondition = YES;
        self.listEngine = listEngine;
        self.listEmptyShowView = [KJListEmptyShowView createEmptyShowViewWithNibName:@"KJListEmptyShowView" OnContainerView:self.listEngine.listView];
    }
    return self;
}

- (void)handleEmptyCondition {
    if (!self.needHandleEmptyCondition) {
        return;
    }
    NSArray *listDatas = self.listEngine.listDatas;
    if (!listDatas.count) {
        [self.listEmptyShowView showEmptyWithTitle:self.empty_show_title imageName:self.empty_show_imageName];
        if (self.empty_backgroundColor) {
            self.listEmptyShowView.backgroundColor = self.empty_backgroundColor;
        }
    }else {
        [self.listEmptyShowView hideSelf];
    }
}


@end
