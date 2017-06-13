//
//  MusicPlayerViewController.m
//  ItunesStack
//
//  Created by Leon on 2017/6/11.
//  Copyright © 2017年 Leon. All rights reserved.
//



#import "MusicPlayerViewController.h"
#import "MainCell.h"
#import "UITableView+help.h"

//手势下滑最大允许位移
static CGFloat gestureOffset = 200;
//对应view可允许的最大偏移距离
static CGFloat dismissOffset = 80;
#define W M_PI/(gestureOffset * 2)
@interface MusicPlayerViewController ()<UITableViewDelegate,UITableViewDataSource>
//view的y偏移值
@property (assign, nonatomic) CGFloat dampOffset;
//判断手势是否可用的开关
@property (assign, nonatomic) BOOL stopPanGesture;
@end

@implementation MusicPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addGesture];
}

- (void)addGesture{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(move:)];
    [self.view addGestureRecognizer:pan];
}

- (void)move:(UIPanGestureRecognizer *)pan{
    CGPoint point = [pan translationInView:self.view];
    if(self.stopPanGesture == YES){
        return;
    }
    if(pan.state == UIGestureRecognizerStateBegan){
        self.dampOffset = 0;
    }else if(pan.state == UIGestureRecognizerStateChanged){
        
        if(point.y < gestureOffset && point.y > 0){
            self.dampOffset = sin(W * point.y ) * dismissOffset;//简陋的阻尼效果😊
            self.view.transform = CGAffineTransformMakeTranslation(0, self.dampOffset);
        }else{
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }else if(pan.state == UIGestureRecognizerStateEnded){
        //恢复
        [UIView animateWithDuration: 0.3 delay:0 usingSpringWithDamping:0.93 initialSpringVelocity:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.view.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
           
        }];
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    if(offsetY <= 0){//向下滑动 View也跟着滑动
        if(self.stopPanGesture == YES){//手已经放开 下拉tableView有缓冲力 tableView 会上下弹动
            // view跟随tableView弹性
            self.view.transform = CGAffineTransformMakeTranslation(0, -scrollView.contentOffset.y);
            //为了让tableView顶部和View的magin保持为0
            scrollView.transform = CGAffineTransformMakeTranslation(0, scrollView.contentOffset.y);
        }else{
            //the should not scroll
            scrollView.contentOffset = CGPointZero;
        }
    }else{//向上滑动
        self.stopPanGesture = YES;
    }
    if(scrollView.decelerating){
     // 正在减速
       self.stopPanGesture = YES;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.stopPanGesture = NO;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell"];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 703;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
