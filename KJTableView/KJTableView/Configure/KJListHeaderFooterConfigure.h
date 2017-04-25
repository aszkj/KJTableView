//
//  KJListHeaderFooterConfigure.h
//  KJTableView
//
//  Created by mm on 17/3/24.
//  Copyright © 2017年 mm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KJListHeaderFooterConfigure : NSObject

#pragma mark - header
@property (nonatomic,strong)UIColor *headerlastUpdatedTimeLabelTextColor;

@property (nonatomic,strong)UIFont *headerlastUpdatedTimeLabelTextFont;

@property (nonatomic,strong)UIColor *headerStateLabelTextColor;

@property (nonatomic,strong)UIFont *headerStateLabelTextFont;

#pragma mark - footer
@property (nonatomic,strong)UIColor *footerStateLabelTextColor;

@property (nonatomic,strong)UIFont *footerStateLabelTextFont;

@end
