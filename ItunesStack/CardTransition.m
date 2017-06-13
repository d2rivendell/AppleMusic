//
//  CardTransition.m
//  ItunesStack
//
//  Created by Leon.Hwa on 2017/6/7.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "CardTransition.h"
#import "CustomTabBarController.h"
#import "MusicPlayerViewController.h"
#import "MainCell.h"
@interface CardTransition()
{
    BOOL _presented;
}
@property (nonatomic, assign) UINavigationControllerOperation operation;

@property (nonatomic, assign) CGRect playBarAvatarFrame;
@property (nonatomic, assign) CGRect playBarFrame;
@property (nonatomic, strong) UIImageView *tabBarView;

@end
@implementation CardTransition

- (instancetype)initWidthOperation:(UINavigationControllerOperation )operation
{
    self = [super init];
    if (self) {
        _operation = operation;
    }
    return self;
}

- ( id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    _presented = YES;
    return self;
}

- ( id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    _presented = NO;
    return self;
}


- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.6f;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIView *containerView =  [transitionContext containerView];
    CGFloat HEIGHT = [[UIScreen mainScreen] bounds].size.height;
    CGFloat  WIDTH = [[UIScreen mainScreen] bounds].size.width;
    CGFloat scale  = 1 - (40/HEIGHT);
    if( _presented){
        CustomTabBarController *fromVC = (CustomTabBarController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        MusicPlayerViewController *toVc = (MusicPlayerViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        [containerView addSubview:toVc.view];
        fromVC.musicToolBar.avatar.hidden = YES;
        
        UIImage *effectImage = [self copyView:fromVC.musicToolBar];
        UIImageView *effectView = [[UIImageView alloc] initWithImage:effectImage];
        UIImageView *avatar = [[UIImageView alloc] initWithImage:fromVC.musicToolBar.avatar.image];
        effectView.frame = [fromVC.musicToolBar convertRect:fromVC.musicToolBar.bounds  toView: [UIApplication sharedApplication].keyWindow];
        self.playBarFrame = effectView.frame;
        avatar.frame = [fromVC.musicToolBar.avatar convertRect:fromVC.musicToolBar.avatar.bounds  toView: [UIApplication sharedApplication].keyWindow];
        self.playBarAvatarFrame = avatar.frame;
        avatar.contentMode = UIViewContentModeScaleAspectFit;
        avatar.clipsToBounds = YES;
        CGRect finalFrameForVc = [transitionContext finalFrameForViewController:toVc];
        toVc.view.frame = effectView.frame;
        
       MainCell *cell =  [toVc.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        
        //x的坐标是根据storyBoard的来确定 在小屏幕上不准确 需要手动计算
        CGRect avatarEndFrame = CGRectMake((WIDTH - cell.avatar.frame.size.width)/2, cell.avatar.frame.origin.y + 40, cell.avatar.frame.size.width, cell.avatar.frame.size.height);
         CGRect effectViewEndFrame = CGRectMake(0 , 40, effectView.frame.size.width, effectView.frame.size.height);
        
        cell.avatar.image = avatar.image;
        cell.avatar.hidden = YES;

        
        self.tabBarView = [[UIImageView alloc] initWithImage:[self copyView:self.tabBar]];
        CGFloat tabBarW = self.tabBarView.image.size.width;
        CGFloat tabBarH = self.tabBarView.image.size.height;
        self.tabBarView.frame = CGRectMake(0, HEIGHT - tabBarH, tabBarW, tabBarH);
        [containerView addSubview:effectView];
        [containerView addSubview:avatar];
        [containerView addSubview:self.tabBarView];
        if(_presentingBlock){
            _presentingBlock();
        }
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.93 initialSpringVelocity:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
            effectView.alpha = 0;
            fromVC.musicToolBar.alpha = 0;
            effectView.frame = effectViewEndFrame;
            avatar.frame = avatarEndFrame;
            fromVC.view.transform = CGAffineTransformMakeScale(scale, scale);
            toVc.view.frame = CGRectMake(0, 40, finalFrameForVc.size.width, finalFrameForVc.size.height - 40);
            self.tabBarView.transform = CGAffineTransformMakeTranslation(0, tabBarH);
            [self clickCornerWidth:fromVC.view];
             [self clickCornerWidth:toVc.view];
        } completion:^(BOOL finished) {
            cell.avatar.hidden = NO;
            [effectView removeFromSuperview];
            [avatar removeFromSuperview];
            [transitionContext completeTransition:YES];
    
        }];
    }else{
    
        MusicPlayerViewController * fromVc = (MusicPlayerViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
         MainCell *cell =  [fromVc.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        cell.avatar.hidden = YES;
         CustomTabBarController * toVc = (CustomTabBarController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        toVc.musicToolBar.avatar.hidden = YES;
        toVc.musicToolBar.hidden = NO;
        //头像
        UIImageView *avatar = [[UIImageView alloc] init];
        avatar.image = cell.avatar.image;
        avatar.frame = [fromVc.view convertRect:cell.avatar.frame toView:[UIApplication sharedApplication].keyWindow];
        avatar.contentMode = UIViewContentModeScaleAspectFit;
        avatar.clipsToBounds = YES;
      
        //快捷播放条
        toVc.musicToolBar.hidden = YES;
        CGRect fromVcOriginFrame = [fromVc.view convertRect:fromVc.view.bounds toView:[UIApplication sharedApplication].keyWindow];
        
        // animate fakeBar
        MusicToolBar *musicToolBar = [[MusicToolBar alloc] initWithFrame:CGRectMake(fromVcOriginFrame.origin.x, fromVcOriginFrame.origin.y, toVc.musicToolBar.bounds.size.width , toVc.musicToolBar.bounds.size.height)];
        musicToolBar.avatar.hidden =YES;
        musicToolBar.alpha = 0;
        [containerView addSubview:musicToolBar];
        [containerView addSubview:avatar];
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.93 initialSpringVelocity:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
            fromVc.view.frame = CGRectMake(0, self.playBarFrame.origin.y, WIDTH, HEIGHT - self.playBarFrame.origin.y);
            toVc.view.transform = CGAffineTransformIdentity;
            toVc.view.layer.mask = nil;
            fromVc.view.layer.mask = nil;
            avatar.frame = self.playBarAvatarFrame;
            musicToolBar.frame = self.playBarFrame;
            musicToolBar.alpha = 1;
            toVc.musicToolBar.alpha = 1;
            self.tabBarView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            toVc.musicToolBar.hidden = NO;
            toVc.musicToolBar.avatar.hidden = NO;
            toVc.view.layer.mask = nil;
            fromVc.view.layer.mask = nil;
            [musicToolBar removeFromSuperview];
            [avatar removeFromSuperview];
            [self.tabBarView removeFromSuperview];
            if(_dismissBlock){
                _dismissBlock();
            };
            [transitionContext completeTransition:YES];
        }];
      
    }
  
 }

- (UIImage *)copyView:(UIView *)view{
    //会失真
    // UIGraphicsBeginImageContext(view.size);
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return newImage;
    
}
- (void)clickCornerWidth:(UIView *)view{
   CGSize screenSize =   [UIScreen mainScreen].bounds.size;

   UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, screenSize.width, screenSize.height * 3) byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(8, 8)];
    CAShapeLayer *sharpLayer = [CAShapeLayer layer];
    sharpLayer.path = path.CGPath;
    view.layer.mask = sharpLayer;
}
- (CGRect)recover:(CGRect)frame scale:(CGFloat )scale{
    return CGRectMake(frame.origin.x * scale, frame.origin.y * scale, frame.size.width * scale, frame.size.height * scale);
}

@end
