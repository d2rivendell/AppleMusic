//
//  UITableView+help.m
//  ItunesStack
//
//  Created by Leon on 2017/6/13.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "UITableView+help.h"

@implementation UITableView (help)
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}
@end
