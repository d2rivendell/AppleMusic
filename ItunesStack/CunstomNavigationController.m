//
//  CunstomNavigationController.m
//  ItunesStack
//
//  Created by Leon.Hwa on 2017/6/7.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "CunstomNavigationController.h"
#import "CardTransition.h"


@interface CunstomNavigationController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UIVisualEffectView *playerBarView;

@end

@implementation CunstomNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];


}
- (void)setupPalyerBar{

}
//- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
//                                            animationControllerForOperation:(UINavigationControllerOperation)operation
//                                                         fromViewController:(UIViewController *)fromVC{
//   return [[CardTransition alloc] initWidthOperation:operation];
//}
//- (void)musicDetail{
//    CardViewController *cardVC = [[CardViewController alloc] init];
//    [self pushViewController:cardVC animated:YES];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
