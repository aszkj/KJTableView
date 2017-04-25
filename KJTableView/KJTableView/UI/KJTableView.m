//
//  KJTableView.m
//  KJTableView
//
//  Created by mm on 17/3/21.
//  Copyright © 2017年 mm. All rights reserved.
//

#import "KJTableView.h"
#import "KJTableViewDatasource.h"

@interface KJTableView ()

@property (nonatomic, strong)KJTableViewDatasource *kJTableViewDatasource;

@end
@implementation KJTableView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.listEngine = [[KJListEngine alloc] initWithListView:self];
    self.listDatasourceEngine = [[KJListDatasoureEngine alloc] initWithListEngine:self.listEngine];
    self.kJTableViewDatasource = [[KJTableViewDatasource alloc] initWithKJTableView:self];
}



@end
