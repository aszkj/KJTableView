//
//  KJTableViewTestMutiplHeaderVC.m
//  KJTableView
//
//  Created by mm on 17/3/29.
//  Copyright © 2017年 mm. All rights reserved.
//

#import "KJTableViewTestMutiplHeaderVC.h"
#import "KJTableView.h"
#import "KJTableViewCell.h"
#import "TableTestHeaderView.h"
#import "KJGroupModel.h"

@interface KJTableViewTestMutiplHeaderVC ()

@property (weak, nonatomic) IBOutlet KJTableView *kjTableView;

@end

@implementation KJTableViewTestMutiplHeaderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _configureKJTableView];
}

- (void)_configureKJTableView {
    self.kjTableView.listDatasourceEngine.cellHeight = 40.0f;
    self.kjTableView.listEngine.emptyShowTitle = @"暂无数据";
    self.kjTableView.listEngine.emptyShowTitle = @"无数据";
#warning 这句一定要加
    [self.kjTableView.listDatasourceEngine configureMultiSetionHeaderNibName:@"TableTestHeaderView" cellNibName:@"KJTableViewCell" getSectionCellsCountBlock:^NSInteger(id listView, id groupModel, NSInteger section) {
        
        KJGroupModel *grounpModel = (KJGroupModel *)groupModel;
        return grounpModel.groupItems.count;
        
    } configureSectionCellBlock:^(id listView, id listCell, id model, NSIndexPath *indexPath) {
        KJGroupModel *grounpModel = (KJGroupModel *)model;
        KJModel *kjModel = (KJModel *)grounpModel.groupItems[indexPath.row];
        KJTableViewCell *cell = (KJTableViewCell *)listCell;
        [cell setCellModel:kjModel];

    } configureSectionHeaderBlock:^(id listView, id model, id sectionHeaderView) {
        TableTestHeaderView *tempSectionHeaderView = (TableTestHeaderView *)sectionHeaderView;
        KJGroupModel *grounpModel = (KJGroupModel *)model;
        tempSectionHeaderView.kj_label.text = grounpModel.groupName;
        
    } clickCellBlock:^(id listView, id listCell, id model, NSIndexPath *clickIndexPath) {
        
    }];
    
    self.kjTableView.listDatasourceEngine.secontionHeaderHeightBlock = ^CGFloat(id listView,NSInteger section, id groupModel){
        if (section == 0) {
            return 40;
        }else if (section == 1) {
            return 50;
        }
        return 44;
    };
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
        [self.kjTableView.listEngine loadDataAfterRequestPagingData:[self _testData]];
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
