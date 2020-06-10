//
//  WebViewController.m
//  demo
//
//  Created by CDP on 2020/6/10.
//  Copyright © 2020 CDP. All rights reserved.
//

#import "WebViewController.h"

#import "CDPTargetProxy.h" //引入头文件

@interface WebViewController () <WKScriptMessageHandler> {
    WKWebView *_webView;
}

@end

@implementation WebViewController

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
    
    //webView
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    WKUserContentController *userContentController=[[WKUserContentController alloc]init];
    config.userContentController=userContentController;
    
    //注册方法,名为CDPHandler（记得最后要remove）
    [userContentController addScriptMessageHandler:[[CDPTargetProxy alloc] initWithScriptDelegate:self]  //此处解决循环引用
                                              name:@"CDPHandler"];

    
    _webView=[[WKWebView alloc] initWithFrame:CGRectMake(0,135,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height-135) configuration:config];
    [self.view addSubview:_webView];
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];

}
-(void)dealloc{
    NSLog(@"WebViewController已经dealloc释放");
    
    //remove掉添加的handler（必须）
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"CDPHandler"];
}
#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSLog(@"name:%@\\\\n body:%@\\\\n frameInfo:%@\\\\n",message.name,message.body,message.frameInfo);
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
