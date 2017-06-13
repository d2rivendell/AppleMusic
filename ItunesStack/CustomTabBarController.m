//
//  CustomTabBarController.m
//  ItunesStack
//
//  Created by Leon.Hwa on 2017/6/7.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "CustomTabBarController.h"

#import "CardTransition.h"
#import "MusicPlayerViewController.h"
@interface CustomTabBarController ()

@property (nonatomic, strong) CardTransition *cardTransition;
@end

@implementation CustomTabBarController
- (CardTransition *)cardTransition{
    if(_cardTransition == nil){
        _cardTransition= [[CardTransition  alloc] init];
        _cardTransition.tabBar = self.tabBar;
        __weak typeof(self) weakSelf = self;
        _cardTransition.dismissBlock =  ^(){
         __strong typeof(self) strongSelf = weakSelf;
            [strongSelf showTabbar];
        };
        _cardTransition.presentingBlock =  ^(){
            __strong typeof(self) strongSelf = weakSelf;
            [strongSelf hideTabBar];
        };
    }
    return _cardTransition;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupPalyerBar];
 
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (void)setupPalyerBar{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    self.musicToolBar = [[MusicToolBar alloc] initWithFrame:CGRectMake(0,self.view.bounds.size.height - 80 - self.tabBar.bounds.size.height, width, 80)];
    [self.view insertSubview:self.musicToolBar belowSubview:self.tabBar];
    __weak typeof(self) weakSelf = self;
    // modal
    self.musicToolBar.musicPlayBlock = ^(){
        __strong typeof(self) strongSelf = weakSelf;
        MusicPlayerViewController *CardVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MusicPlayerViewController" ];
        CardVC.modalPresentationStyle = UIModalPresentationCustom;
        CardVC.transitioningDelegate = strongSelf.cardTransition;
        [strongSelf presentViewController:CardVC animated:YES completion:nil];
    };
}
- (void)hideTabBar{
    self.tabBar.hidden = YES;
   
}
- (void)showTabbar{
    self.tabBar.hidden = NO;
     _cardTransition = nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
