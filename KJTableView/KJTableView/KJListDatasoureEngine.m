//
//  KJListDatasoureEngine.m
//  KJTableView
//
//  Created by mm on 17/3/24.
//  Copyright © 2017年 mm. All rights reserved.
//

#import "KJListDatasoureEngine.h"
#import "KJListEngine.h"

@interface KJListDatasoureEngine ()

@property (nonatomic, weak)KJListEngine *listEngine;

@end

@implementation KJListDatasoureEngine

- (instancetype)initWithListEngine:(KJListEngine *)listEngine {

    if (self = [super init]) {
        self.listEngine = listEngine;
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    
    self.listGroupingType = KJListGroupingSingleGroup;
    self.editingStyle = UITableViewCellEditingStyleNone;
    self.firstSectionHeaderHeight = 0;
    self.cellHeight = 44;

}

#pragma mark ======================== for single section ========================
- (void)_registerCellForNibName:(NSString *)cellNibName {
    self.cellIdentifer = [cellNibName stringByAppendingString:@"ID"];
    if ([self.listEngine.listView isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self.listEngine.listView;
        [tableView registerNib:[UINib nibWithNibName:cellNibName bundle:nil]  forCellReuseIdentifier:self.cellIdentifer];
    }else if ([self.listEngine.listView isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = (UICollectionView *)self.listEngine.listView;
        [collectionView registerNib:[UINib nibWithNibName:cellNibName bundle:nil] forCellWithReuseIdentifier:self.cellIdentifer];
    }
}

-(void)setCellNibName:(NSString *)cellNibName {
    
    _cellNibName = cellNibName;
    [self _registerCellForNibName:cellNibName];
}

-(void)setFirstSectionHeaderNibName:(NSString *)firstSectionHeaderNibName {
    
    _firstSectionHeaderNibName = firstSectionHeaderNibName;
    [self _registerFirstSectionHeaderForNibName:firstSectionHeaderNibName];
    
}

- (void)_registerFirstSectionHeaderForNibName:(NSString *)firstSectionHeaderNibName {
    
    self.firstSectionHeaderIdentifer = [firstSectionHeaderNibName stringByAppendingString:@"ID"];
    //如果是单个组头的话，tableView不采用复用，collectionView必须得采用复用机制，所以单组，仅对collectionView注册
    if ([self.listEngine.listView isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = (UICollectionView *)self.listEngine.listView;
        [collectionView registerNib:[UINib nibWithNibName:firstSectionHeaderNibName bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:self.firstSectionHeaderIdentifer];
    }
}


#pragma mark - 配置cell
-(void)configurecellNibName:(NSString *)cellNibName
          configurecellData:(KJConfigureListCellBlock)configurecellBlock {

    [self configurecellNibName:cellNibName cellDataSource:nil configurecellData:configurecellBlock clickCell:nil];
}

-(void)configurecellNibName:(NSString *)cellNibName
          configurecellData:(KJConfigureListCellBlock)configurecellBlock
                  clickCell:(KJListClickCellBlock)clickCellBlock {
    [self configurecellNibName:cellNibName cellDataSource:nil configurecellData:configurecellBlock clickCell:clickCellBlock];
}

-(void)configurecellNibName:(NSString *)cellNibName
             cellDataSource:(NSArray *)cellDataSource
          configurecellData:(KJConfigureListCellBlock)configurecellBlock
                  clickCell:(KJListClickCellBlock)clickCellBlock {

    [self _registerCellForNibName:cellNibName];
    self.listEngine.listDatas = cellDataSource;
    self.configureListCellBlock = configurecellBlock;
    self.listClickCellBlock = clickCellBlock;
}

#pragma mark - 配置firstSectionHeaderFooter
- (void)configureFirstSectioHeaderNibName:(NSString *)firstSectionHeaderNibName
    configureTablefirstSectionHeaderBlock:(KJConfigureListfirstSectionHeaderFooterBlock)configurefirstSectionHeaderBlock {

    self.configureListfirstSectionHeaderBlock = configurefirstSectionHeaderBlock;
    self.firstSectionHeaderNibName = firstSectionHeaderNibName;
}

- (void)configureFirstSectioFooterNibName:(NSString *)firstSectionFooterNibName
    configureTablefirstSectionFooterBlock:(KJConfigureListfirstSectionHeaderFooterBlock)configurefirstSectionFooterBlock {
    self.configureListfirstSectionFooterBlock = configurefirstSectionFooterBlock;
    self.firstSectionFooterNibName = firstSectionFooterNibName;

}

#pragma mark - configure multi group
//配置分组的，每组组头相同，
-(void)configureMultiSetionHeaderNibName:(NSString *)setionHeaderNibName
                   cellNibName:(NSString *)cellNibName
          getSectionCellsCountBlock:(KJGetListSectionCellsCountBlock)getSectionCellsCountBlock
     configureSectionCellBlock:(KJConfigureListCellBlock)configureSectionCellBlock
   configureSectionHeaderBlock:(KJConfigureListfirstSectionHeaderFooterBlock)
configureSectionHeaderBlock
                          clickCellBlock:(KJListClickCellBlock)clickCellBlock
{
    
    [self _registeSectionHeaderFootersWithSectionNibNames:@[setionHeaderNibName] isForHeader:YES];
    [self _registerCellForNibName:cellNibName];
    self.getListSectionCellsCountBlock = getSectionCellsCountBlock;
    self.configureListCellBlock = configureSectionCellBlock;
    self.configureListfirstSectionHeaderBlock = configureSectionHeaderBlock;
    self.listGroupingType = KJListGroupingMultiGroupSameHeaderFooter;
    self.listClickCellBlock = clickCellBlock;
}

-(void)configureMultiSetionFooterNibName:(NSString *)setionFooterNibName
                             cellNibName:(NSString *)cellNibName
                    getSectionCellsCountBlock:(KJGetListSectionCellsCountBlock)getSectionCellsCountBlock
               configureSectionCellBlock:(KJConfigureListCellBlock)configureSectionCellBlock
             configureSectionHeaderBlock:(KJConfigureListfirstSectionHeaderFooterBlock)
configureSectionFooterBlock
                          clickCellBlock:(KJListClickCellBlock)clickCellBlock
{
    
    [self _registeSectionHeaderFootersWithSectionNibNames:@[setionFooterNibName] isForHeader:NO];
    [self _registerCellForNibName:cellNibName];
    self.getListSectionCellsCountBlock = getSectionCellsCountBlock;
    self.configureListCellBlock = configureSectionCellBlock;
    self.configureListfirstSectionHeaderBlock = configureSectionFooterBlock;
    self.listGroupingType = KJListGroupingMultiGroupSameHeaderFooter;
    self.listClickCellBlock = clickCellBlock;
}


- (void)_registeSectionHeaderFootersWithSectionNibNames:(NSArray *)sectionHeaderFooterNibNames isForHeader:(BOOL)isForHeader{
    if (!sectionHeaderFooterNibNames) {
        sectionHeaderFooterNibNames = @[];
    }

    NSString *const collectionSectionHeaderFooterResuseableStr = isForHeader ? UICollectionElementKindSectionHeader : UICollectionElementKindSectionFooter;
    NSMutableArray *sectionHeaderFooterIdentifiers = [NSMutableArray arrayWithCapacity:sectionHeaderFooterNibNames.count];
    for (NSString *sectionHeaderFooterNibName in sectionHeaderFooterNibNames) {
        NSString *sectionHeaderFooterIdentifier = [sectionHeaderFooterNibName stringByAppendingString:@"ID"];
        [sectionHeaderFooterIdentifiers addObject:sectionHeaderFooterIdentifier];
        if ([self.listEngine.listView isKindOfClass:[UICollectionView class]]) {
            UICollectionView *collectionView = (UICollectionView *)self.listEngine.listView;
            [collectionView registerNib:[UINib nibWithNibName:sectionHeaderFooterNibName bundle:nil] forSupplementaryViewOfKind:collectionSectionHeaderFooterResuseableStr withReuseIdentifier:sectionHeaderFooterIdentifier];
        }else if ([self.listEngine.listView isKindOfClass:[UITableView class]]) {
            UITableView *tableView = (UITableView *)self.listEngine.listView;
            [tableView registerNib:[UINib nibWithNibName:sectionHeaderFooterNibName bundle:nil]  forHeaderFooterViewReuseIdentifier:sectionHeaderFooterIdentifier];
        }
    }
    if (isForHeader) {
        self.sectionHeaderIdentifiers = sectionHeaderFooterIdentifiers;
    }else {
        self.sectionFooterIdentifiers = sectionHeaderFooterIdentifiers;
    }
}



@end
