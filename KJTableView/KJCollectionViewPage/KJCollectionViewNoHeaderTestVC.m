//
//  KJCollectionViewNoHeaderTestVC.m
//  KJTableView
//
//  Created by mm on 17/4/25.
//  Copyright © 2017年 mm. All rights reserved.
//

#import "KJCollectionViewNoHeaderTestVC.h"
#import "KJCollectionView.h"
#import "KJCollectionViewCell.h"
#import "KJCollectionViewTestNoHeaderVC.h"
#import "KJCollectionViewTestNoHeaderNoMoreDataRefreshVC.h"
#import "KJCollectionViewTestNoRefreshVC.h"

@interface KJCollectionViewNoHeaderTestVC ()
@property (weak, nonatomic) IBOutlet KJCollectionView *kjTestCollectionView;

@end

@implementation KJCollectionViewNoHeaderTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _configureKJTableView];
    
    [self testReloadData];
    
}
- (void)testReloadData {
    [self.kjTestCollectionView.listEngine loadDataAfterRequestTotalData:[self _testData]];
}

- (void)_configureKJTableView {

    __weak typeof(self) weak_self = self;
    [self.kjTestCollectionView.listDatasourceEngine configurecellNibName:@"KJCollectionViewCell" configurecellData:^(id listView, id listCell, id model, NSIndexPath *indexPath) {
        KJCollectionViewCell *cell = (KJCollectionViewCell *)listCell;
        KJModel *kjModel = (KJModel *)model;
        [cell setCellModel:kjModel];
    } clickCell:^(id listView, id listCell, id model, NSIndexPath *clickIndexPath) {
        UIViewController *vc = nil;
        if (clickIndexPath.row == 0) {
            vc = [[KJCollectionViewTestNoHeaderVC alloc] init];
        }else if (clickIndexPath.row == 1) {
            vc = [[KJCollectionViewTestNoHeaderNoMoreDataRefreshVC alloc] init];
        }else if (clickIndexPath.row == 2) {
            vc = [[KJCollectionViewTestNoRefreshVC alloc] init];
        }
        [weak_self.navigationController pushViewController:vc animated:YES];
    }];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width/2, 100);
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.kjTestCollectionView.collectionViewLayout = layout;

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
