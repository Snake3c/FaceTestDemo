//
//  CCAutoTabBarController.h
//  AutoTabBar
//
//  Created by cc on 15/9/28.
//  Copyright © 2015年 Snake. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCAutoTabBarController : UITabBarController
/**
 *  to add ViewControllers you must put all Vc into an array
 *  @param controllers array of your ViewControllers or NavigationControllers
 */
- (void)addChildViewControllers:(NSArray *)controllers;

/**
 *  load all images for every tabBarItem
 *  @param imageN this is an NSArray about NSString of the normal images's name
 *  @param imageH also like the imageN
 */
- (void)addNormalImages:(NSArray *)imageN andHightedImages:(NSArray *)imageH;
/**
 *  tintColor :For this Version ,tintColor is  only for the label of the tabBarItems .Before use it ,you have to decide which color you want to use.
 *  As we know ,we always use the same color as the images of the tabBarItem!!
 *  default is darkGreay
 */
@property (nonatomic,strong) UIColor *tintColor;

@end
