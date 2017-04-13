//
//  KJTableViewNoHeaderTestVC.m
//  KJTableView
//
//  Created by mm on 17/4/13.
//  Copyright © 2017年 mm. All rights reserved.
//

#import "KJTableViewNoHeaderTestVC.h"
#import "KJTableView.h"
#import "KJTableViewCell.h"
#import "KJTableViewTestNoHeaderVC.h"
#import "KJTableViewTestNoHeaderNoMoreDataRefreshVC.h"
#import "KJTableViewTestNoRefreshVC.h"

@interface KJTableViewNoHeaderTestVC ()

@property (weak, nonatomic) IBOutlet KJTableView *testTableView;

@end

@implementation KJTableViewNoHeaderTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _configureKJTableView];
    
    [self testReloadData];
    
}
- (void)testReloadData {
    [self.testTableView.listEngine loadDataAfterRequestTotalData:[self _testData]];
}

- (void)_configureKJTableView {
    self.testTableView.listDatasourceEngine.cellHeight = 40.0f;
    __weak typeof(self) weak_self = self;
    [self.testTableView.listDatasourceEngine configurecellNibName:@"KJTableViewCell" configurecellData:^(id listView, id listCell, id model, NSIndexPath *indexPath) {
        KJTableViewCell *cell = (KJTableViewCell *)listCell;
        KJModel *kjModel = (KJModel *)model;
        [cell setCellModel:kjModel];
    } clickCell:^(id listView, id listCell, id model, NSIndexPath *clickIndexPath) {
        UIViewController *vc = nil;
        if (clickIndexPath.row == 0) {
            vc = [[KJTableViewTestNoHeaderVC alloc] init];
        }else if (clickIndexPath.row == 1) {
            vc = [[KJTableViewTestNoHeaderNoMoreDataRefreshVC alloc] init];
        }else if (clickIndexPath.row == 2) {
            vc = [[KJTableViewTestNoRefreshVC alloc] init];
        }
        [weak_self.navigationController pushViewController:vc animated:YES];
    }];
}


- (NSArray *)_testData {
    KJModel *model1 = [[KJModel alloc] init];
    model1.name = @"有刷新测试";
    
    KJModel *model2 = [[KJModel alloc] init];
    model2.name = @"有下拉刷新，无上拉加载更多测试";
    
    KJModel *model3 = [[KJModel alloc] init];
    model3.name = @"无刷新测试";
    
    return @[model1,model2,model3];
}

@end
