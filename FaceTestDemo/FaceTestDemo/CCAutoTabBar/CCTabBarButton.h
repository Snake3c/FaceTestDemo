//
//  CCTabBarButton.h
//  AutoTabBar
//
//  Created by CC on 15/9/28.
//  Copyright © 2015年 Snake. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCTabbarButton : UIButton
@property (nonatomic,strong) UIColor *labelColor;
-(instancetype)initWithTitle:(NSString *)str;
- (void)setTitleStateHightlighted:(BOOL)highlighted;

@end
