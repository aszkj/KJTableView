//
//  KJListDatasoureEngine.h
//  KJTableView
//
//  Created by mm on 17/3/24.
//  Copyright © 2017年 mm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,KJListGroupingType) {
    KJListGroupingSingleGroup,          //单组
    KJListGroupingMultiGroupSameHeaderFooter, //多组，相同组头组尾
    KJListGroupingMultiGroupDifferentHeaderFooter //多组，不同组头组尾
};

typedef void(^KJEditingCellBlock)(id listView, UITableViewCellEditingStyle editingStyle,NSIndexPath *editingIndexPath, id cellModel);

#pragma mark - single group block
typedef void(^KJConfigureListCellBlock)(id listView,id listCell,id model,NSIndexPath *indexPath);
typedef void(^KJConfigureListfirstSectionHeaderFooterBlock)(id listView,id model,id firstSectionHeaderView);
typedef void(^KJListClickCellBlock)(id listView,id listCell,id model,NSIndexPath *clickIndexPath);
typedef CGFloat(^KJCellHeightBlock)(id listView,id model,NSIndexPath *cellIndexPath);

#pragma mark - multi group block
typedef NSInteger(^KJGetListSectionCellsCountBlock)(id listView,id groupModel,NSInteger section);
typedef void(^KJListenListScrollBlock)(CGFloat contentOffset);
typedef CGFloat(^KJListSectionHeaderHeightBlock)(id listView,NSInteger section, id groupModel);
typedef CGFloat(^KJListSectionFooterHeightBlock)(id listView,NSInteger section,id groupModel);

@class KJListEngine;
@interface KJListDatasoureEngine : NSObject

- (instancetype)initWithListEngine:(KJListEngine *)listEngine;
#pragma mark ======================== for single section ========================
@property (nonatomic,copy)KJConfigureListCellBlock configureListCellBlock;

//优先返回block高度，其次cellHeight属性
@property (nonatomic,copy)KJCellHeightBlock cellHeightBlock;

@property (nonatomic,copy)KJConfigureListfirstSectionHeaderFooterBlock configureListfirstSectionHeaderBlock;

@property (nonatomic,copy)KJConfigureListfirstSectionHeaderFooterBlock configureListfirstSectionFooterBlock;

@property (nonatomic,copy)KJListClickCellBlock listClickCellBlock;

@property (nonatomic,copy)KJListenListScrollBlock listenListScrollBlock;

@property (nonatomic,copy)KJEditingCellBlock editingCellBlock;

@property (nonatomic,copy)NSString *firstSectionHeaderNibName;
@property (nonatomic,copy)NSString *firstSectionHeaderIdentifer;
@property (nonatomic,assign)CGFloat firstSectionHeaderHeight;

@property (nonatomic,copy)NSString *firstSectionFooterNibName;
@property (nonatomic,copy)NSString *firstSectionFooterIdentifer;
@property (nonatomic,assign)CGFloat firstSectionFooterHeight;

@property (nonatomic,copy)NSString *cellNibName;
@property (nonatomic,copy)NSString *cellIdentifer;
@property (nonatomic,assign)CGFloat cellHeight;

/**
 *  默认UITableViewCellEditingStyleNone
 */
@property (nonatomic,assign)UITableViewCellEditingStyle editingStyle;

#pragma mark - 配置cell
-(void)configurecellNibName:(NSString *)cellNibName
          configurecellData:(KJConfigureListCellBlock)configurecellBlock;

-(void)configurecellNibName:(NSString *)cellNibName
          configurecellData:(KJConfigureListCellBlock)configurecellBlock
                  clickCell:(KJListClickCellBlock)clickCellBlock;

-(void)configurecellNibName:(NSString *)cellNibName
             cellDataSource:(NSArray *)cellDataSource
          configurecellData:(KJConfigureListCellBlock)configurecellBlock
                  clickCell:(KJListClickCellBlock)clickCellBlock;

#pragma mark - 配置firstSectionHeaderFooter
- (void)configureFirstSectioHeaderNibName:(NSString *)firstSectionHeaderNibName
    configureTablefirstSectionHeaderBlock:(KJConfigureListfirstSectionHeaderFooterBlock)configurefirstSectionHeaderBlock;

- (void)configureFirstSectioFooterNibName:(NSString *)firstSectionFooterNibName
    configureTablefirstSectionFooterBlock:(KJConfigureListfirstSectionHeaderFooterBlock)configurefirstSectionFooterBlock;


#pragma mark ======================== for multi section ========================
@property (nonatomic,copy)KJGetListSectionCellsCountBlock getListSectionCellsCountBlock;
@property (nonatomic,copy)NSArray *sectionHeaderIdentifiers;
@property (nonatomic,copy)NSArray *sectionFooterIdentifiers;
@property (nonatomic,assign)KJListGroupingType listGroupingType;
//优先返回block高度，其次firstSectionHeaderHeight属性
@property (nonatomic,copy)KJListSectionHeaderHeightBlock secontionHeaderHeightBlock;
@property (nonatomic,copy)KJListSectionFooterHeightBlock secontionFooterHeightBlock;

#pragma mark - configure multi group
//配置多组的，每组组头相同，
-(void)configureMultiSetionHeaderNibName:(NSString *)setionHeaderNibName
                             cellNibName:(NSString *)cellNibName
                    getSectionCountBlock:(KJGetListSectionCellsCountBlock)getSectionCellsCountBlock
               configureSectionCellBlock:(KJConfigureListCellBlock)configureSectionCellBlock
             configureSectionHeaderBlock:(KJConfigureListfirstSectionHeaderFooterBlock)
configureSectionHeaderBlock
                          clickCellBlock:(KJListClickCellBlock)clickCellBlock;
//配置多组的，每组组尾相同，
-(void)configureMultiSetionFooterNibName:(NSString *)setionFooterNibName
                             cellNibName:(NSString *)cellNibName
                    getSectionCountBlock:(KJGetListSectionCellsCountBlock)getSectionCellsCountBlock
               configureSectionCellBlock:(KJConfigureListCellBlock)configureSectionCellBlock
             configureSectionHeaderBlock:(KJConfigureListfirstSectionHeaderFooterBlock)
configureSectionFooterBlock
                          clickCellBlock:(KJListClickCellBlock)clickCellBlock;

@end
