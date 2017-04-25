//
//  KJCollectionViewTestNoRefreshVC.m
//  KJTableView
//
//  Created by mm on 17/4/25.
//  Copyright © 2017年 mm. All rights reserved.
//

#import "KJCollectionViewTestNoRefreshVC.h"
#import "KJCollectionView.h"
#import "KJCollectionViewCell.h"

@interface KJCollectionViewTestNoRefreshVC ()
@property (weak, nonatomic) IBOutlet KJCollectionView *kjTestCollectionView;

@end

@implementation KJCollectionViewTestNoRefreshVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _configureKJTableView];
    
    [self _requestData];
}

- (void)_configureKJTableView {
    self.kjTestCollectionView.listEngine.emptyShowTitle = @"暂无数据";
    [self.kjTestCollectionView.listDatasourceEngine configurecellNibName:@"KJCollectionViewCell" configurecellData:^(id listView, id listCell, id model, NSIndexPath *indexPath) {
        KJCollectionViewCell *cell = (KJCollectionViewCell *)listCell;
        KJModel *kjModel = (KJModel *)model;
        [cell setCellModel:kjModel];
    } clickCell:^(id listView, id listCell, id model, NSIndexPath *clickIndexPath) {
        
    }];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width/2, 100);
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.kjTestCollectionView.collectionViewLayout = layout;
    
}


- (void)_requestData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.kjTestCollectionView.listEngine loadDataAfterRequestTotalData:[self _testData]];
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
