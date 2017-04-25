//
//  KJCollectionViewDatasource.m
//  KJTableView
//
//  Created by mm on 17/3/27.
//  Copyright © 2017年 mm. All rights reserved.
//

#import "KJCollectionViewDatasource.h"
#import "KJCollectionView.h"

@interface KJCollectionViewDatasource ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, weak)KJCollectionView *collectionView;

@end

@implementation KJCollectionViewDatasource

- (instancetype)initWithKJCollectionView:(KJCollectionView *)collectionView {

    if (self = [super init]) {
        self.collectionView = collectionView;
        collectionView.delegate = self;
        collectionView.dataSource = self;
    }
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    if (self.collectionView.listDatasourceEngine.listGroupingType == KJListGroupingSingleGroup) {
        return 1;
    }else {
        return self.collectionView.listEngine.listDatas.count;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.collectionView.listDatasourceEngine.listGroupingType == KJListGroupingSingleGroup) {
        return self.collectionView.listEngine.listDatas.count;
    }else {
        id groupModel = self.collectionView.listEngine.listDatas[section];
        return self.collectionView.listDatasourceEngine.getListSectionCellsCountBlock(self,groupModel,section);
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSAssert(self.collectionView.listDatasourceEngine.cellIdentifer != nil, @"cell标识符不能为空");
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.collectionView.listDatasourceEngine.cellIdentifer forIndexPath:indexPath];
    id model = nil;
    NSInteger getModelIndex = self.collectionView.listDatasourceEngine.listGroupingType == KJListGroupingSingleGroup ? indexPath.row : indexPath.section;
    model = self.collectionView.listEngine.listDatas[getModelIndex];
    NSAssert(self.collectionView.listDatasourceEngine.configureListCellBlock != nil, @"配置cell的block不能为空");
    self.collectionView.listDatasourceEngine.configureListCellBlock(collectionView,cell,model,indexPath);
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (self.collectionView.listDatasourceEngine.listGroupingType == KJListGroupingSingleGroup) {
        if (self.collectionView.listDatasourceEngine.firstSectionHeaderIdentifer) {
            if (kind == UICollectionElementKindSectionHeader) {
                UICollectionReusableView *firstSectionView =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:self.collectionView.listDatasourceEngine.firstSectionHeaderIdentifer forIndexPath:indexPath];
                if (self.collectionView.listDatasourceEngine.configureListfirstSectionHeaderBlock) {
                    self.collectionView.listDatasourceEngine.configureListfirstSectionHeaderBlock(collectionView,nil,firstSectionView);
                }
                return firstSectionView;
            }
        }else{
            return nil;
        }
    }else {
        if (self.collectionView.listDatasourceEngine.listGroupingType == KJListGroupingMultiGroupSameHeaderFooter) {
            //目前只支持多组同组头的
            if (kind == UICollectionElementKindSectionHeader) {
                UICollectionReusableView *sectionHeadView =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:self.collectionView.listDatasourceEngine.sectionHeaderIdentifiers.firstObject forIndexPath:indexPath];
                id groupModel = self.collectionView.listEngine.listDatas[indexPath.section];
                if (self.collectionView.listDatasourceEngine.configureListfirstSectionHeaderBlock) {
                    self.collectionView.listDatasourceEngine.configureListfirstSectionHeaderBlock(collectionView,groupModel,sectionHeadView);
                }
                return sectionHeadView;
            }
        }else {
            return nil;
        }
        
    }
    
    return nil;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    id model = nil;
    NSInteger getModelIndex = self.collectionView.listDatasourceEngine.listGroupingType == KJListGroupingSingleGroup ? indexPath.row : indexPath.section;
    model = self.collectionView.listEngine.listDatas[getModelIndex];
    if (self.collectionView.listDatasourceEngine.listClickCellBlock) {
        self.collectionView.listDatasourceEngine.listClickCellBlock(collectionView,cell,model,indexPath);
    }
}


#pragma mark -------------------ScrollView Delegate Method----------------------
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (self.collectionView.listDatasourceEngine.listenListScrollBlock) {
        self.collectionView.listDatasourceEngine.listenListScrollBlock(scrollView.contentOffset.y);
    }
    
}


@end
