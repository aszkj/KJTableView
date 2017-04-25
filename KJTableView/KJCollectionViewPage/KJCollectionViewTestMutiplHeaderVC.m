//
//  KJCollectionViewTestMutiplHeaderVC.m
//  KJTableView
//
//  Created by mm on 17/4/25.
//  Copyright © 2017年 mm. All rights reserved.
//

#import "KJCollectionViewTestMutiplHeaderVC.h"
#import "KJCollectionView.h"
#import "KJGroupModel.h"
#import "KJCollectionViewCell.h"
#import "KJCollectionSectionHeaderView.h"

@interface KJCollectionViewTestMutiplHeaderVC ()
@property (weak, nonatomic) IBOutlet KJCollectionView *kjTestCollectionView;

@end

@implementation KJCollectionViewTestMutiplHeaderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _configureKJTableView];
    
    [self _requestData];
}

- (void)_configureKJTableView {

    self.kjTestCollectionView.listEngine.emptyShowTitle = @"暂无数据";
    [self.kjTestCollectionView.listDatasourceEngine configureMultiSetionHeaderNibName:@"KJCollectionSectionHeaderView" cellNibName:@"KJCollectionViewCell" getSectionCellsCountBlock:^NSInteger(id listView, id groupModel, NSInteger section) {
        
        KJGroupModel *grounpModel = (KJGroupModel *)groupModel;
        return grounpModel.groupItems.count;
        
    } configureSectionCellBlock:^(id listView, id listCell, id model, NSIndexPath *indexPath) {
        KJGroupModel *grounpModel = (KJGroupModel *)model;
        KJModel *kjModel = (KJModel *)grounpModel.groupItems[indexPath.row];
        KJCollectionViewCell *cell = (KJCollectionViewCell *)listCell;
        [cell setCellModel:kjModel];
        
    } configureSectionHeaderBlock:^(id listView, id model, id sectionHeaderView) {
        KJCollectionSectionHeaderView *tempSectionHeaderView = (KJCollectionSectionHeaderView *)sectionHeaderView;
        KJGroupModel *grounpModel = (KJGroupModel *)model;
        tempSectionHeaderView.kjLabel.text = grounpModel.groupName;
        
    } clickCellBlock:^(id listView, id listCell, id model, NSIndexPath *clickIndexPath) {
        
    }];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width/2, 100);
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.headerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, KJCollectionSectionHeaderViewHeight);

    self.kjTestCollectionView.collectionViewLayout = layout;

    self.kjTestCollectionView.listDatasourceEngine.secontionHeaderHeightBlock = ^CGFloat(id listView,NSInteger section, id groupModel){
        if (section == 0) {
            return 40;
        }else if (section == 1) {
            return 50;
        }
        return 44;
    };
}


- (void)_requestData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //        [self.kjTableView.listEngine loadDataAfterRequestPagingData:[self _testData]];
        [self.kjTestCollectionView.listEngine loadDataAfterRequestTotalData:[self _testData]];
    });
}

- (NSArray *)_testData {
    KJModel *model1 = [[KJModel alloc] init];
    model1.name = @"1133333";
    
    KJModel *model2 = [[KJModel alloc] init];
    model2.name = @"2233333";
    
    KJModel *model3 = [[KJModel alloc] init];
    model3.name = @"KJTableViewTestExample";
    
    KJModel *model4 = [[KJModel alloc] init];
    model4.name = @"KJCollectionViewTestExample";
    
    KJModel *model5 = [[KJModel alloc] init];
    model5.name = @"KJCollectionViewTestExample";
    
    KJGroupModel *groupModel1 = [[KJGroupModel alloc] init];
    groupModel1.groupName = @"分组1";
    groupModel1.groupItems = @[model1,model2,model3,model4,model5];
    
    KJGroupModel *groupModel2 = [[KJGroupModel alloc] init];
    groupModel2.groupItems = @[model1,model2];
    groupModel2.groupName = @"分组2";
    
    
    return @[groupModel1,groupModel2];
}

- (NSArray *)_testNoneData {
    
    return @[];
}


@end
