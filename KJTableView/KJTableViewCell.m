//
//  KJTableViewCell.m
//  KJTableView
//
//  Created by mm on 17/3/28.
//  Copyright © 2017年 mm. All rights reserved.
//

#import "KJTableViewCell.h"


@implementation KJTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

@implementation KJTableViewCell (setCellModel)

- (void)setCellModel:(KJModel *)model {

    self.kj_label.text = model.name;
}

@end
