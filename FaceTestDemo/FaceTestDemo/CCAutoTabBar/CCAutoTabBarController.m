//
//  CCAutoTabBarController.m
//  AutoTabBar
//
//  Created by CC on 15/9/28.
//  Copyright © 2015年 Snake. All rights reserved.
//
#import "CCAutoTaBbarController.h"
#import "CCTabbarButton.h"
#import "CCTabbar.h"
@interface CCAutoTabBarController () <CCTabbarDelegate>
@property (nonatomic,strong) NSArray *arrN;
@property (nonatomic,strong) NSArray *arrH;
@end

@implementation CCAutoTabBarController

-(UIColor *)tintColor {
    if (_tintColor == nil) {
        _tintColor = [UIColor darkGrayColor];
    }
    return _tintColor;
}
- (void)addChildViewControllers:(NSArray *)controllers {
    self.viewControllers = controllers;
    for (id obj in self.tabBar.subviews) {
        if (![obj isKindOfClass:[CCTabbar class]]) {
            [obj removeFromSuperview];
        }
    }
    
}
- (void)addNormalImages:(NSArray *)imageN andHightedImages:(NSArray *)imageH {
    self.arrN = imageN;
    self.arrH = imageH;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadCCTabbar];
    
}

-(void)loadCCTabbar {
    CCTabbar *tab = [[CCTabbar alloc]initWIthImgaes:self.arrN AndHLImages:self.arrH];
    tab.frame = self.tabBar.bounds;
    tab.delegate = self;
    [self.tabBar addSubview:tab];
    for (id obj in self.tabBar.subviews) {
        if (![obj isKindOfClass:[CCTabbar class]]) {
            [obj removeFromSuperview];
        }
    }
    if (self.tintColor) {
        tab.buttonColor = self.tintColor;
    }
}

-(void)CCTabbar:(CCTabbar *)CCTabbar DidSelectedButton:(UIButton *)btn {
    self.selectedIndex = btn.tag;
}

@end
