//
//  KJTableViewTestHasHeaderVC.m
//  KJTableView
//
//  Created by mm on 17/3/29.
//  Copyright © 2017年 mm. All rights reserved.
//

#import "KJTableViewTestHasHeaderVC.h"
#import "KJTableView.h"
#import "KJTableViewCell.h"
#import "KJTableViewTestSingleHeaderVC.h"
#import "KJTableViewTestMutiplHeaderVC.h"

@interface KJTableViewTestHasHeaderVC ()
@property (weak, nonatomic) IBOutlet KJTableView *testTableView;

@end

@implementation KJTableViewTestHasHeaderVC

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
            vc = [[KJTableViewTestSingleHeaderVC alloc] init];
        }else if (clickIndexPath.row == 1) {
            vc = [[KJTableViewTestMutiplHeaderVC alloc] init];
        }
        [weak_self.navigationController pushViewController:vc animated:YES];

    }];
}


- (NSArray *)_testData {
    KJModel *model1 = [[KJModel alloc] init];
    model1.name = @"单组头测试";
    
    KJModel *model2 = [[KJModel alloc] init];
    model2.name = @"多组相同组头测试";
    return @[model1,model2];
}



@end
