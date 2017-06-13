//
//  UIView+tool.h
//  HYFWeibos
//
//  Created by mac1 on 16/3/4.
//  Copyright © 2016年 mac1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (tool)
@property(nonatomic,assign)CGFloat  x;
@property(nonatomic,assign)CGFloat  y;
@property(nonatomic,assign)CGFloat  width;
@property(nonatomic,assign)CGFloat  height;
@property(nonatomic,assign)CGPoint  origin;
@property(nonatomic,assign)CGSize  size;


@property(nonatomic,assign)CGFloat  centerX;
@property(nonatomic,assign)CGFloat  centerY;
+ (UIImage *)copyView:(UIView *)view;
@end
