//
//  CDPTargetProxy.h
//  demo
//
//  Created by CDP on 2020/6/10.
//  Copyright © 2020 CDP. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <WebKit/WebKit.h> //引入WebKit库

@interface CDPTargetProxy : NSObject <WKScriptMessageHandler>
//主要解决 web，timer 等循环引用导致的target无法进入dealloc进行内存释放问题

#pragma mark - web循环引用
//WKWebView举例:
//[userContentController addScriptMessageHandler:[[CDPTargetProxy alloc] initWithScriptDelegate:self]  //此处解决循环引用
//                                          name:@"CDPHandler"];

/**
 *  web引用所需delegate
 */
@property (nonatomic,weak) id <WKScriptMessageHandler> scriptDelegate;

/**
 *  初始化 (解决web循环引用)
 */
-(instancetype)initWithScriptDelegate:(id <WKScriptMessageHandler> )delegate;

#pragma mark - 计时器等循环引用
//计时器举例:
//_timer=[NSTimer scheduledTimerWithTimeInterval:1
//                                        target:[[CDPTargetProxy alloc] initWithTarget:self selector:@selector(timeGo)] //此处解决循环引用，timeGo为真正需要执行的方法
//                                      selector:@selector(doSelector) //固定传doSelector
//                                      userInfo:nil
//                                       repeats:YES];

/**
 *  初始化 (解决循环引用，例如计时器)
 *  target 原target
 *  selector 为 原target 所要实现的方法
 */
-(instancetype)initWithTarget:(id)target selector:(SEL)selector;

/**
 *  当CDPTargetProxy作为target传入时所需传入的 selector
 */
-(void)doSelector;


@end


