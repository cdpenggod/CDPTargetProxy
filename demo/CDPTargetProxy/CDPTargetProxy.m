//
//  CDPTargetProxy.m
//  demo
//
//  Created by CDP on 2020/6/10.
//  Copyright © 2020 CDP. All rights reserved.
//

#import "CDPTargetProxy.h"

#ifdef DEBUG
#    define CDPLog(fmt,...) NSLog(fmt,##__VA_ARGS__)
#else
#    define CDPLog(fmt,...) /* */
#endif

@interface CDPTargetProxy ()

@property (nonatomic,weak) NSObject *target;

@property (nonatomic) SEL selector;

@end

@implementation CDPTargetProxy

//初始化 (解决web循环引用)
-(instancetype)initWithScriptDelegate:(id<WKScriptMessageHandler>)delegate{
    if (self=[super init]) {
        _scriptDelegate=delegate;
    }
    return self;
}
//初始化 (解决循环引用，例如计时器)
-(instancetype)initWithTarget:(id)target selector:(SEL)selector{
    if (self=[super init]) {
        _target=target;
        _selector=selector;
    }
    return self;
}
-(void)dealloc{
    CDPLog(@"*** CDPTargetProxy已经dealloc释放 ***");
}
#pragma mark - 相关方法
//web方法
-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    if ([_scriptDelegate respondsToSelector:@selector(userContentController:didReceiveScriptMessage:)]) {
        [_scriptDelegate userContentController:userContentController didReceiveScriptMessage:message];
    }
}
//当YJTargetProxy作为target传入时所需传入的 selector
-(void)doSelector{
    if (_target&&_selector) {
        if ([_target respondsToSelector:_selector]) {
            [_target performSelectorOnMainThread:_selector withObject:nil waitUntilDone:[NSThread isMainThread]];
        }
    }
}



@end
