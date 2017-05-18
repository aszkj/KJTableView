//
//  KJCollectionView.m
//  KJTableView
//
//  Created by mm on 17/3/24.
//  Copyright © 2017年 mm. All rights reserved.
//

#import "KJCollectionView.h"
#import "KJCollectionViewDatasource.h"

@interface KJCollectionView ()

@property (nonatomic, strong)KJCollectionViewDatasource *kJCollectionViewDatasource;

@end


@implementation KJCollectionView

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.listEngine = [[KJListEngine alloc] initWithListView:self];
    self.listDatasourceEngine = [[KJListDatasoureEngine alloc] initWithListEngine:self.listEngine];
    self.kJCollectionViewDatasource = [[KJCollectionViewDatasource alloc] initWithKJCollectionView:self];

}



@end
