//
//  KJListHeaderFooterConfigure.m
//  KJTableView
//
//  Created by mm on 17/3/24.
//  Copyright © 2017年 mm. All rights reserved.
//

#import "KJListHeaderFooterConfigure.h"
#import "KJConst.h"

@implementation KJListHeaderFooterConfigure

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.headerlastUpdatedTimeLabelTextFont = KJHeaderlastUpdatedTimeLabelTextFont;
        self.headerlastUpdatedTimeLabelTextColor = KJHeaderlastUpdatedTimeLabelTextColor;
        self.headerStateLabelTextFont = KJHeaderStateLabelTextFont;
        self.headerStateLabelTextColor = KJHeaderStateLabelTextColor;
        self.footerStateLabelTextFont = KJFooterStateLabelTextFont;
        self.footerStateLabelTextColor = KJFooterStateLabelTextColor;
        
    }
    return self;
}

@end
