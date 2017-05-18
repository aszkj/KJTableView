//
//  KJListEmptyShowView.m
//  view继承
//
//  Created by mm on 17/3/23.
//  Copyright © 2017年 mm. All rights reserved.
//

#import "KJListEmptyShowView.h"

@interface KJListEmptyShowView ()
@property (weak, nonatomic) IBOutlet UIImageView *empty_show_imageView;
@property (weak, nonatomic) IBOutlet UIButton *empty_show_titleButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *empty_show_imageViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *empty_show_imageViewWidthConstraint;

@end

@implementation KJListEmptyShowView

- (void)showEmptyWithTitle:(NSString *)title imageName:(NSString *)imageName {
    [super showEmptyWithTitle:title imageName:imageName];
    [self configureEmptyShowView];
}

- (void)configureEmptyShowView {
    [self.empty_show_titleButton setTitle:self.empty_show_title forState:UIControlStateNormal];
    UIImage *showImage = [UIImage imageNamed:self.empty_show_imageName];
    if (!showImage) {
        return;
    }
    CGFloat widthHeightPercent = showImage.size.height / showImage.size.width;
    self.empty_show_imageViewHeightConstraint.constant = self.empty_show_imageViewWidthConstraint.constant * widthHeightPercent;
    self.empty_show_imageView.image = showImage;

}


@end
