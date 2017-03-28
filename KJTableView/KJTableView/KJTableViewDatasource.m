//
//  KJTableViewDatasource.m
//  KJTableView
//
//  Created by mm on 17/3/27.
//  Copyright © 2017年 mm. All rights reserved.
//

#import "KJTableViewDatasource.h"
#import "KJTableView.h"

@interface KJTableViewDatasource ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, weak)KJTableView *tableView;

@property (nonatomic,assign)KJListGroupingType tableGroupingType;

@end

@implementation KJTableViewDatasource

- (instancetype)initWithKJTableView:(KJTableView *)tableView {
    if (self = [super init]) {
        self.tableView = tableView;
        self.tableGroupingType = self.tableView.listDatasourceEngine.listGroupingType;
        tableView.delegate = self;
        tableView.dataSource = self;
    }
    return self;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.tableGroupingType == KJListGroupingSingleGroup) {
        return 1;
    }else {
        return self.tableView.listEngine.listDatas.count;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSAssert(self.tableView.listDatasourceEngine.cellIdentifer != nil, @"cell标识符不能为空");
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:self.tableView.listDatasourceEngine.cellIdentifer forIndexPath:indexPath];
    id model = nil;
    NSInteger getModelIndex = self.tableGroupingType == KJListGroupingSingleGroup ? indexPath.row : indexPath.section;
    model = self.tableView.listEngine.listDatas[getModelIndex];
    NSAssert(self.tableView.listDatasourceEngine.configureListCellBlock != nil, @"配置cell的block不能为空");
    self.tableView.listDatasourceEngine.configureListCellBlock(tableView,cell,model,indexPath);
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (self.tableView.listDatasourceEngine.secontionHeaderHeightBlock) {
        if (self.tableGroupingType == KJListGroupingSingleGroup) {
            return self.tableView.listDatasourceEngine.secontionHeaderHeightBlock(tableView,section,nil);
        }else {
            id groupModel  = self.tableView.listEngine.listDatas[section];
            return self.tableView.listDatasourceEngine.secontionHeaderHeightBlock(tableView,section,groupModel);
        }

    }else {
        return  self.tableView.listDatasourceEngine.firstSectionHeaderHeight > 0 ?  self.tableView.   listDatasourceEngine.firstSectionHeaderHeight : 0.00000001;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.tableView.listDatasourceEngine.secontionFooterHeightBlock) {
        if (self.tableGroupingType == KJListGroupingSingleGroup) {
            return self.tableView.listDatasourceEngine.secontionFooterHeightBlock(tableView,section,nil);
        }else {
            id groupModel  = self.tableView.listEngine.listDatas[section];
            return self.tableView.listDatasourceEngine.secontionFooterHeightBlock(tableView,section,groupModel);
        }
        
    }else {
        return  self.tableView.listDatasourceEngine.firstSectionFooterHeight > 0 ?  self.tableView.   listDatasourceEngine.firstSectionFooterHeight : 0.00000001;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.tableView.listDatasourceEngine.cellHeightBlock) {
        id model = nil;
        if (self.tableGroupingType == KJListGroupingSingleGroup) {
            model  = self.tableView.listEngine.listDatas[indexPath.row];
        }else {
            model  = self.tableView.listEngine.listDatas[indexPath.section];
        }
        return self.tableView.listDatasourceEngine.cellHeightBlock(tableView,model,indexPath);
    }else {
        return self.tableView.listDatasourceEngine.cellHeight;
    }
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.tableGroupingType == KJListGroupingSingleGroup) {
        if (self.tableView.listDatasourceEngine.firstSectionHeaderNibName) {
            UIView *firstSectionHeaderView = [[[NSBundle mainBundle] loadNibNamed:self.tableView.listDatasourceEngine.firstSectionHeaderNibName owner:nil options:nil] lastObject];
            if (self.tableView.listDatasourceEngine.configureListfirstSectionHeaderBlock) {
                self.tableView.listDatasourceEngine.configureListfirstSectionHeaderBlock(tableView,nil,firstSectionHeaderView);
            }
            return firstSectionHeaderView;
        }else {
            return nil;
        }
    }else {
        if (self.tableView.listDatasourceEngine.sectionHeaderIdentifiers.count) {
            //只支持相同组头的，
            NSString *sectionHeaderIdentifier = self.tableView.listDatasourceEngine.sectionHeaderIdentifiers.firstObject;
            UITableViewHeaderFooterView *setionHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionHeaderIdentifier];
            id groupModel =  self.tableView.listEngine.listDatas[section];
            if (self.tableView.listDatasourceEngine.configureListfirstSectionHeaderBlock) {
                self.tableView.listDatasourceEngine.configureListfirstSectionHeaderBlock(tableView,groupModel,setionHeaderView);
            }
            return setionHeaderView;
        }else {
            return nil;
        }

    }

}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.tableGroupingType == KJListGroupingSingleGroup) {
        if (self.tableView.listDatasourceEngine.firstSectionFooterNibName) {
            UIView *firstSectionFooterView = [[[NSBundle mainBundle] loadNibNamed:self.tableView.listDatasourceEngine.firstSectionFooterNibName owner:nil options:nil] lastObject];
            if (self.tableView.listDatasourceEngine.configureListfirstSectionFooterBlock) {
                self.tableView.listDatasourceEngine.configureListfirstSectionFooterBlock(tableView,nil,firstSectionFooterView);
            }
            return firstSectionFooterView;
        }else {
            return nil;
        }
    }else {
        if (self.tableView.listDatasourceEngine.sectionFooterIdentifiers.count) {
            //只支持相同组头的，
            NSString *sectionFooterIdentifier = self.tableView.listDatasourceEngine.sectionFooterIdentifiers.firstObject;
            UITableViewHeaderFooterView *setionFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionFooterIdentifier];
            id groupModel =  self.tableView.listEngine.listDatas[section];
            if (self.tableView.listDatasourceEngine.configureListfirstSectionFooterBlock) {
                self.tableView.listDatasourceEngine.configureListfirstSectionFooterBlock(tableView,groupModel,setionFooterView);
            }
            return setionFooterView;
        }else {
            return nil;
        }
        
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.tableView.listDatasourceEngine.editingStyle == UITableViewCellEditingStyleNone ? NO : YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.tableView.listDatasourceEngine.editingStyle;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{//请求数据源提交的插入或删除指定行接收者。

    if (self.tableView.listDatasourceEngine.editingCellBlock) {
        NSAssert(self.tableView.listDatasourceEngine.editingStyle != UITableViewCellEditingStyleNone, @"设置了编辑block,没有设置cell编辑类型");
        id model = nil;
        NSInteger getModelIndex = self.tableGroupingType == KJListGroupingSingleGroup ? indexPath.row : indexPath.section;
        model = self.tableView.listEngine.listDatas[getModelIndex];

        self.tableView.listDatasourceEngine.editingCellBlock(tableView,editingStyle,indexPath,model);
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (self.tableView.listDatasourceEngine.listClickCellBlock) {
        id model = nil;
        NSInteger getModelIndex = self.tableGroupingType == KJListGroupingSingleGroup ? indexPath.row : indexPath.section;
        model = self.tableView.listEngine.listDatas[getModelIndex];
        self.tableView.listDatasourceEngine.listClickCellBlock(tableView,cell,model,indexPath);
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (self.tableView.listDatasourceEngine.listenListScrollBlock) {
        self.tableView.listDatasourceEngine.listenListScrollBlock(scrollView.contentOffset.y);
    }
}


@end
