//
//  KJTableViewTestNoRefreshVC.m
//  KJTableView
//
//  Created by mm on 17/4/13.
//  Copyright © 2017年 mm. All rights reserved.
//

#import "KJTableViewTestNoRefreshVC.h"
#import "KJTableView.h"
#import "KJTableViewCell.h"

@interface KJTableViewTestNoRefreshVC ()
@property (weak, nonatomic) IBOutlet KJTableView *kjTableView;

@end

@implementation KJTableViewTestNoRefreshVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _configureKJTableView];
    
    [self _requestData];
}

- (void)_configureKJTableView {
    self.kjTableView.listDatasourceEngine.cellHeight = 40.0f;
    self.kjTableView.listEngine.emptyShowTitle = @"暂无数据";
    [self.kjTableView.listDatasourceEngine configurecellNibName:@"KJTableViewCell" configurecellData:^(id listView, id listCell, id model, NSIndexPath *indexPath) {
        KJTableViewCell *cell = (KJTableViewCell *)listCell;
        KJModel *kjModel = (KJModel *)model;
        [cell setCellModel:kjModel];
    } clickCell:^(id listView, id listCell, id model, NSIndexPath *clickIndexPath) {
        
    }];
}


- (void)_requestData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.kjTableView.listEngine loadDataAfterRequestTotalData:[self _testData]];
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
