//
//  KJCustomEmptyShowViewTestVC.m
//  KJTableView
//
//  Created by mm on 17/3/30.
//  Copyright © 2017年 mm. All rights reserved.
//

#import "KJCustomEmptyShowViewTestVC.h"
#import "KJTableView.h"
#import "KJTableViewCell.h"
#import "KJCustomEmptyListShowView.h"


@interface KJCustomEmptyShowViewTestVC ()
@property (weak, nonatomic) IBOutlet KJTableView *kjTableView;

@property (nonatomic,strong) KJCustomEmptyListShowView *customEmptyListShowView;

@end

@implementation KJCustomEmptyShowViewTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _configureKJTableView];
}

- (void)_configureKJTableView {
    self.kjTableView.listDatasourceEngine.cellHeight = 40.0f;
    [self.kjTableView.listEngine setCustomEmptyShowView:self.customEmptyListShowView];
    self.kjTableView.listEngine.emptyShowTitle = @"暂无数据";
    self.kjTableView.listEngine.emptyShowImageName = @"无数据";
    [self.kjTableView.listDatasourceEngine configurecellNibName:@"KJTableViewCell" configurecellData:^(id listView, id listCell, id model, NSIndexPath *indexPath) {
        KJTableViewCell *cell = (KJTableViewCell *)listCell;
        KJModel *kjModel = (KJModel *)model;
        [cell setCellModel:kjModel];
    } clickCell:^(id listView, id listCell, id model, NSIndexPath *clickIndexPath) {
        
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
        [self.kjTableView.listEngine loadDataAfterRequestPagingData:[self _testNoneData]];
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

- (KJCustomEmptyListShowView *)customEmptyListShowView {
    
    if (!_customEmptyListShowView) {
        _customEmptyListShowView = (KJCustomEmptyListShowView *)[KJCustomEmptyListShowView createEmptyShowViewWithNibName:@"KJCustomEmptyListShowView" OnContainerView:self.kjTableView];
    }
    return _customEmptyListShowView;
}

@end
