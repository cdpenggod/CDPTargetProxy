//
//  ViewController.m
//  demo
//
//  Created by CDP on 2020/6/10.
//  Copyright © 2020 CDP. All rights reserved.
//

#import "ViewController.h"

#import "TimerViewController.h"
#import "WebViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    for (NSInteger i=0;i<2;i++) {
        UIButton *bt=[[UIButton alloc] initWithFrame:CGRectMake(50,(i==0)?200:270,[UIScreen mainScreen].bounds.size.width-100,50)];
        bt.adjustsImageWhenHighlighted=NO;
        bt.backgroundColor=[UIColor grayColor];
        [bt setTitle:(i==0)?@"计时器VC":@"WebVC" forState:UIControlStateNormal];
        [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        bt.titleLabel.font=[UIFont boldSystemFontOfSize:20];
        bt.tag=(i+1000);
        [bt addTarget:self action:@selector(btClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:bt];
    }
    
}
#pragma mark - 点击事件
-(void)btClick:(UIButton *)sender{
    UIViewController *vc;
    
    if (sender.tag==1000) {
        //计时器VC
        vc=[TimerViewController new];
    }
    else{
        //webVC
        vc=[WebViewController new];
    }
    
    [self presentViewController:vc animated:YES completion:nil];
}


@end
