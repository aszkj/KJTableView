//
//  KJTableViewTestSingleHeaderVC.m
//  KJTableView
//
//  Created by mm on 17/3/29.
//  Copyright © 2017年 mm. All rights reserved.
//

#import "KJTableViewTestSingleHeaderVC.h"
#import "KJTableView.h"
#import "KJTableViewCell.h"
#import "TableTestHeaderView.h"

@interface KJTableViewTestSingleHeaderVC ()

@property (weak, nonatomic) IBOutlet KJTableView *kjTableView;

@end

@implementation KJTableViewTestSingleHeaderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _configureKJTableView];
}

- (void)_configureKJTableView {
    self.kjTableView.listDatasourceEngine.cellHeight = 40.0f;
    self.kjTableView.listEngine.emptyShowTitle = @"暂无数据";
    self.kjTableView.listEngine.emptyShowTitle = @"无数据";
    [self.kjTableView.listDatasourceEngine configurecellNibName:@"KJTableViewCell" configurecellData:^(id listView, id listCell, id model, NSIndexPath *indexPath) {
        KJTableViewCell *cell = (KJTableViewCell *)listCell;
        KJModel *kjModel = (KJModel *)model;
        [cell setCellModel:kjModel];
    } clickCell:^(id listView, id listCell, id model, NSIndexPath *clickIndexPath) {
        
    }];
    
    self.kjTableView.listDatasourceEngine.firstSectionHeaderHeight = KJTableTestHeaderViewHeight;
    [self.kjTableView.listDatasourceEngine configureFirstSectioHeaderNibName:@"TableTestHeaderView" configureTablefirstSectionHeaderBlock:^(id listView, id model, id firstSectionHeaderView) {
        TableTestHeaderView *firstHeaderView = (TableTestHeaderView *)firstSectionHeaderView;
        firstHeaderView.kj_label.text = @"只有第一个组头";
    }];
    
    __weak typeof(self) weak_self = self;
    //头部刷新
    [self.kjTableView.listEngine beginHeaderRefresh:^{
        [weak_self _requestData];
    }];
    //头部自动刷新
    [self.kjTableView.listEngine beginHeaderAutoRefresh:^{
        [weak_self _requestData];
    }];
    //尾部刷新
    [self.kjTableView.listEngine beginFooterRefresh:^{
        [weak_self _requestData];
    }];
}


- (void)_requestData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.kjTableView.listEngine loadDataAfterRequestPagingData:[self _testData]];
    });
}

- (NSArray *)_testData {
    KJModel *model1 = [[KJModel alloc] init];
    model1.name = @"KJTableViewTestExample";
    
    KJModel *model2 = [[KJModel alloc] init];
    model2.name = @"KJCollectionViewTestExample";
    
    KJModel *model3 = [[KJModel alloc] init];
    model3.name = @"KJTableViewTestExample";
    
    KJModel *model4 = [[KJModel alloc] init];
    model4.name = @"KJCollectionViewTestExample";
    
    KJModel *model5 = [[KJModel alloc] init];
    model5.name = @"KJCollectionViewTestExample";
    
    
    return @[model1,model2,model3,model4,model5];
}

- (NSArray *)_testNoneData {
    
    return @[];
}


@end
