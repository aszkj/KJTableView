//
//  KJCustomEmptyListShowView.m
//  KJTableView
//
//  Created by mm on 17/3/30.
//  Copyright © 2017年 mm. All rights reserved.
//

#import "KJCustomEmptyListShowView.h"

@interface KJCustomEmptyListShowView()
@property (weak, nonatomic) IBOutlet UIImageView *kj_ImgView;
@property (weak, nonatomic) IBOutlet UILabel *kj_label;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *kj_imgViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *kj_imgViewHeightConstraint;
@end

@implementation KJCustomEmptyListShowView

- (void)showEmptyWithTitle:(NSString *)title imageName:(NSString *)imageName {
    [super showEmptyWithTitle:title imageName:imageName];
    
    [self configureEmptyShowView];
}

- (void)configureEmptyShowView {
    
    self.kj_label.text = self.empty_show_title;
    UIImage *showImage = [UIImage imageNamed:self.empty_show_imageName];
    if (!showImage) {
        return;
    }
    CGFloat widthHeightPercent = showImage.size.height / showImage.size.width;
    self.kj_imgViewHeightConstraint.constant = self.kj_imgViewWidthConstraint.constant * widthHeightPercent;
    self.kj_ImgView.image = showImage;
    
}


@end
