//
//  TimerViewController.m
//  demo
//
//  Created by CDP on 2020/6/10.
//  Copyright © 2020 CDP. All rights reserved.
//

#import "TimerViewController.h"

#import "CDPTargetProxy.h" //引入头文件

@interface TimerViewController () {
    NSTimer *_timer;
}

@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIButton *bt=[[UIButton alloc] initWithFrame:CGRectMake(50,80,[UIScreen mainScreen].bounds.size.width-100,50)];
    bt.adjustsImageWhenHighlighted=NO;
    bt.backgroundColor=[UIColor grayColor];
    [bt setTitle:@"Back" forState:UIControlStateNormal];
    [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    bt.titleLabel.font=[UIFont boldSystemFontOfSize:20];
    [bt addTarget:self action:@selector(btClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bt];
    
    //计时器（记得最后要停止并置为nil）
    _timer=[NSTimer scheduledTimerWithTimeInterval:1
                                            target:[[CDPTargetProxy alloc] initWithTarget:self selector:@selector(timeGo)] //此处解决循环引用，timeGo为真正需要执行的方法
                                          selector:@selector(doSelector) //固定传doSelector
                                          userInfo:nil
                                           repeats:YES];
}
-(void)dealloc{
    NSLog(@"TimerViewController已经dealloc释放");
    
    //停止并释放计时器（必须）
    [_timer invalidate];
    _timer=nil;
}
#pragma mark - 计时器方法
-(void)timeGo{
    NSLog(@"timeGO--------");
}
#pragma mark - 点击方法
-(void)btClick{
    [self dismissViewControllerAnimated:YES completion:nil];
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
