//
//  PlayerView.m
//  ItunesStack
//
//  Created by Leon.Hwa on 2017/6/7.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "MusicToolBar.h"
@interface MusicToolBar()

@end
@implementation MusicToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        CGFloat width =   [UIScreen mainScreen].bounds.size.width;
        UIImageView *avatar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"eminem"]];
        avatar.contentMode = UIViewContentModeScaleAspectFit;
        avatar.clipsToBounds = YES;
        avatar.frame = CGRectMake(30, 10, 50, 60);
        [self addSubview:avatar];
        self.avatar = avatar;
        [self addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(musicDetail)]];
        
        UILabel *lb = [[UILabel alloc] init];
        lb.text = @"Love the Way You Lie";
        lb.frame = CGRectMake(CGRectGetMaxX(avatar.frame) + 20, (self.bounds.size.height - 20)/2, 160, 20);
        [self addSubview:lb];
       UIButton *playBtn = [[UIButton alloc] init];
        [playBtn setImage:[UIImage imageNamed:@"sharedart_pause"] forState:UIControlStateNormal];
        CGFloat imageW = playBtn.imageView.image.size.width;
        CGFloat imageH = playBtn.imageView.image.size.height;
        playBtn.frame = CGRectMake(width - imageW - 20, (frame.size.height - imageH)/2, imageW, imageH);
        [self addSubview:playBtn];
        self.playBtn = playBtn;
    }
    return self;
}

- (void)musicDetail{
    if(_musicPlayBlock){
        _musicPlayBlock();
    }
}
@end
