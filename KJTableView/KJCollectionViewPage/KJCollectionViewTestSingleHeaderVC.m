//
//  KJCollectionViewTestSingleHeaderVC.m
//  KJTableView
//
//  Created by mm on 17/4/25.
//  Copyright © 2017年 mm. All rights reserved.
//

#import "KJCollectionViewTestSingleHeaderVC.h"
#import "KJCollectionView.h"
#import "KJCollectionViewCell.h"
#import "KJCollectionSectionHeaderView.h"

@interface KJCollectionViewTestSingleHeaderVC ()
@property (weak, nonatomic) IBOutlet KJCollectionView *kjTestCollectionView;

@end

@implementation KJCollectionViewTestSingleHeaderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _configureKJCollectionView];
}

- (void)_configureKJCollectionView {
    
    self.kjTestCollectionView.listEngine.emptyShowTitle = @"无数据";
    [self.kjTestCollectionView.listDatasourceEngine configurecellNibName:@"KJCollectionViewCell" configurecellData:^(id listView, id listCell, id model, NSIndexPath *indexPath) {
        KJCollectionViewCell *cell = (KJCollectionViewCell *)listCell;
        KJModel *kjModel = (KJModel *)model;
        [cell setCellModel:kjModel];
    } clickCell:^(id listView, id listCell, id model, NSIndexPath *clickIndexPath) {
        
    }];
    
    self.kjTestCollectionView.listDatasourceEngine.firstSectionHeaderHeight = KJCollectionSectionHeaderViewHeight;
    [self.kjTestCollectionView.listDatasourceEngine configureFirstSectioHeaderNibName:@"KJCollectionSectionHeaderView" configureTablefirstSectionHeaderBlock:^(id listView, id model, id firstSectionHeaderView) {
        KJCollectionSectionHeaderView *firstHeaderView = (KJCollectionSectionHeaderView *)firstSectionHeaderView;
        firstHeaderView.kjLabel.text = @"只有第一个组头";
    }];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width/2, 100);
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.headerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, KJCollectionSectionHeaderViewHeight);
    self.kjTestCollectionView.collectionViewLayout = layout;

    
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
        [self.kjTestCollectionView.listEngine loadDataAfterRequestPagingData:[self _testData]];
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
