//
//  KJCustomCollectionViewEmptyTestVC.m
//  KJTableView
//
//  Created by mm on 17/4/25.
//  Copyright © 2017年 mm. All rights reserved.
//

#import "KJCustomCollectionViewEmptyTestVC.h"
#import "KJCollectionView.h"
#import "KJCustomEmptyListShowView.h"
#import "KJCollectionViewCell.h"

@interface KJCustomCollectionViewEmptyTestVC ()
@property (weak, nonatomic) IBOutlet KJCollectionView *kjTestCollectionView;
@property (nonatomic,strong) KJCustomEmptyListShowView *customEmptyListShowView;

@end

@implementation KJCustomCollectionViewEmptyTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _configureKJCollectionView];
}

- (void)_configureKJCollectionView {
    
    [self.kjTestCollectionView.listEngine setCustomEmptyShowView:self.customEmptyListShowView];
    self.kjTestCollectionView.listEngine.emptyShowTitle = @"暂无数据";
    self.kjTestCollectionView.listEngine.emptyShowImageName = @"无数据";
    [self.kjTestCollectionView.listDatasourceEngine configurecellNibName:@"KJCollectionViewCell" configurecellData:^(id listView, id listCell, id model, NSIndexPath *indexPath) {
        KJCollectionViewCell *cell = (KJCollectionViewCell *)listCell;
        KJModel *kjModel = (KJModel *)model;
        [cell setCellModel:kjModel];
    } clickCell:^(id listView, id listCell, id model, NSIndexPath *clickIndexPath) {
        
    }];
    
    __weak typeof(self) weak_self = self;
    //头部刷新
    [self.kjTestCollectionView.listEngine beginHeaderRefresh:^{
        [weak_self _requestData];
    }];
    //头部自动刷新
    [self.kjTestCollectionView.listEngine beginHeaderAutoRefresh:^{
        [weak_self _requestData];
    }];
    //尾部刷新
    [self.kjTestCollectionView.listEngine beginFooterRefresh:^{
        [weak_self _requestData];
    }];
}


- (void)_requestData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.kjTestCollectionView.listEngine loadDataAfterRequestPagingData:[self _testNoneData]];
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
        _customEmptyListShowView = (KJCustomEmptyListShowView *)[KJCustomEmptyListShowView createEmptyShowViewWithNibName:@"KJCustomEmptyListShowView" OnContainerView:self.kjTestCollectionView];
    }
    return _customEmptyListShowView;
}

@end
