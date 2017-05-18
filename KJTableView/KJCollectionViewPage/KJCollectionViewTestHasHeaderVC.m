//
//  KJCollectionViewTestHasHeaderVC.m
//  KJTableView
//
//  Created by mm on 17/4/25.
//  Copyright © 2017年 mm. All rights reserved.
//

#import "KJCollectionViewTestHasHeaderVC.h"
#import "KJCollectionView.h"
#import "KJCollectionViewTestSingleHeaderVC.h"
#import "KJCollectionViewCell.h"
#import "KJCollectionViewTestMutiplHeaderVC.h"
@interface KJCollectionViewTestHasHeaderVC ()
@property (weak, nonatomic) IBOutlet KJCollectionView *kjTestCollectionView;

@end

@implementation KJCollectionViewTestHasHeaderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _configureKJCollectionView];
    
    [self testReloadData];
    
}
- (void)testReloadData {
    [self.kjTestCollectionView.listEngine loadDataAfterRequestTotalData:[self _testData]];
}

- (void)_configureKJCollectionView {

    __weak typeof(self) weak_self = self;
    [self.kjTestCollectionView.listDatasourceEngine configurecellNibName:@"KJCollectionViewCell" configurecellData:^(id listView, id listCell, id model, NSIndexPath *indexPath) {
        KJCollectionViewCell *cell = (KJCollectionViewCell *)listCell;
        KJModel *kjModel = (KJModel *)model;
        [cell setCellModel:kjModel];
    } clickCell:^(id listView, id listCell, id model, NSIndexPath *clickIndexPath) {
        UIViewController *vc = nil;
        if (clickIndexPath.row == 0) {
            vc = [[KJCollectionViewTestSingleHeaderVC alloc] init];
        }else if (clickIndexPath.row == 1) {
            vc = [[KJCollectionViewTestMutiplHeaderVC alloc] init];
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
    model1.name = @"单组头测试";
    
    KJModel *model2 = [[KJModel alloc] init];
    model2.name = @"多组相同组头测试";
    return @[model1,model2];
}


@end
