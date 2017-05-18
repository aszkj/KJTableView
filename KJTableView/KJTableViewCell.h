//
//  KJTableViewCell.h
//  KJTableView
//
//  Created by mm on 17/3/28.
//  Copyright © 2017年 mm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KJModel.h"

@interface KJTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *kj_label;

@end
@interface KJTableViewCell (setCellModel)

- (void)setCellModel:(KJModel *)model;

@end
