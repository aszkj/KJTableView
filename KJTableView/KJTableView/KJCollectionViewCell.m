//
//  KJCollectionViewCell.m
//  KJTableView
//
//  Created by mm on 17/3/28.
//  Copyright © 2017年 mm. All rights reserved.
//

#import "KJCollectionViewCell.h"


@implementation KJCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end

@implementation KJCollectionViewCell (setCellModel)

- (void)setCellModel:(KJModel *)model {

    self.kj_label.text = model.name;
    
}

@end
