//
//  PlayerView.h
//  ItunesStack
//
//  Created by Leon.Hwa on 2017/6/7.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^MusicPlayBlock)(void);
@interface MusicToolBar : UIVisualEffectView
@property (nonatomic, strong) UIImageView *avatar;
@property (nonatomic, copy) MusicPlayBlock musicPlayBlock;
@property (nonatomic, strong) UIButton *playBtn;
@end
