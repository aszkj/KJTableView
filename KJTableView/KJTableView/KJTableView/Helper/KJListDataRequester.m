//
//  KJRefreshRequester.m
//  KJTableView
//
//  Created by mm on 17/3/21.
//  Copyright © 2017年 mm. All rights reserved.
//

#import "KJListDataRequester.h"

@implementation KJListDataRequester

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.requestFromPage = 1;
        self.requestPageSize = 5;
        self.headerAutoRefresh = YES;
        self.hasFinishedHeaderAutoFresh = NO;
        self.needPaging = YES;
    }
    return self;
}

- (void)headerAutoRefreshConfigure {
    self.headerAutoRefresh = YES;
    [self resetRequestPage];
}

- (void)resetRequestPage {
    self.requestFromPage = 1;
}

- (void)hasFinishedAutoRefreshConfigure {
    self.hasFinishedHeaderAutoFresh = YES;
    self.headerAutoRefresh = NO;
}

- (void)goNextPage {
    self.requestFromPage ++;
}



@end
