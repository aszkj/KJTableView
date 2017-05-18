//
//  KJTableViewTestVC.m
//  KJTableView
//
//  Created by mm on 17/3/28.
//  Copyright © 2017年 mm. All rights reserved.
//

#import "KJTableViewTestVC.h"
#import "KJTableView.h"
#import "KJTableViewCell.h"
#import "KJTableViewTestHasHeaderVC.h"
#import "KJTableViewNoHeaderTestVC.h"
#import "KJCustomTableViewEmptyTestVC.h"

@interface KJTableViewTestVC ()
@property (weak, nonatomic) IBOutlet KJTableView *testTableView;

@end

@implementation KJTableViewTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"kjTableView测试";
    
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
            vc = [[KJTableViewNoHeaderTestVC alloc] init];
        }else if (clickIndexPath.row == 1) {
            vc = [[KJTableViewTestHasHeaderVC alloc] init];
        }else if (clickIndexPath.row == 2) {
            vc = [[KJCustomTableViewEmptyTestVC alloc] init];
        }
        [weak_self.navigationController pushViewController:vc animated:YES];
    }];
}


- (NSArray *)_testData {
    KJModel *model1 = [[KJModel alloc] init];
    model1.name = @"无组头测试";
    
    KJModel *model2 = [[KJModel alloc] init];
    model2.name = @"有组头测试";
    
    KJModel *model3 = [[KJModel alloc] init];
    model3.name = @"自定义空视图测试";

    return @[model1,model2,model3];
}




@end
