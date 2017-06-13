//
//  CardTransition.h
//  ItunesStack
//
//  Created by Leon.Hwa on 2017/6/7.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MusicPlayerViewController.h"
typedef void (^CardTransitionDismiss)();
typedef void (^CardTransitionPresenting)();


@interface CardTransition : NSObject<UIViewControllerAnimatedTransitioning,UIViewControllerTransitioningDelegate>
@property (nonatomic, weak) UITabBar *tabBar;
@property (nonatomic, copy) CardTransitionDismiss dismissBlock;
@property (nonatomic, copy) CardTransitionPresenting presentingBlock;
@property (weak, nonatomic) UIViewController *presentedVc;
- (instancetype)initWidthOperation:(UINavigationControllerOperation )operation;
@end
