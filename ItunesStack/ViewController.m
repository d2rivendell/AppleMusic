//
//  ViewController.m
//  ItunesStack
//
//  Created by Leon.Hwa on 2017/6/7.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "ViewController.h"
#import "CardTransition.h"

@interface ViewController ()<UINavigationControllerDelegate>
//@property (nonatomic, strong) CardTransition *cardTransition;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
  
    
}
- (IBAction)push:(id)sender {
//    CardViewController *CardVC = [[CardViewController alloc] init];
//    CardVC.modalPresentationStyle = UIModalPresentationCustom;
//    CardVC.transitioningDelegate = self.cardTransition;
//    [self presentViewController:CardVC animated:YES completion:nil];
}
//- (CardTransition *)cardTransition{
//    if(_cardTransition == nil){
//        _cardTransition= [[CardTransition  alloc] init];
//    }
//    return _cardTransition;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
