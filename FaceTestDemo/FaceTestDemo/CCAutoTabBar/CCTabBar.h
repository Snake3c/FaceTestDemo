//
//  CCTabBar.h
//  AutoTabBar
//
//  Created by CC on 15/9/28.
//  Copyright © 2015年 Snake. All rights reserved.
//


#import <UIKit/UIKit.h>
@class CCTabbar;
@protocol CCTabbarDelegate <NSObject>
- (void)CCTabbar:(CCTabbar *)CCTabbar DidSelectedButton:(UIButton *)btn;

@end

@interface CCTabbar : UIView
@property (nonatomic,strong) UIColor *buttonColor;

@property (nonatomic,weak) id<CCTabbarDelegate> delegate;

-(instancetype)initWIthImgaes:(NSArray *)images AndHLImages:(NSArray *)imagesHL;

@end
