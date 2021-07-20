//
//  QJWeakWebViewScriptMessageDelegate.m
//  QJLookingForHouseAPP
//
//  Created by admin on 2020/6/9.
//  Copyright © 2020 唐山千家房地产经纪有限公司. All rights reserved.
//

#import "QJWeakWebViewScriptMessageDelegate.h"

@interface QJWeakWebViewScriptMessageDelegate ()

@end

@implementation QJWeakWebViewScriptMessageDelegate

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate {
    self = [super init];
    if (self) {
        _scriptDelegate = scriptDelegate;
    }
    return self;
}

#pragma mark - WKScriptMessageHandler
//遵循WKScriptMessageHandler协议，必须实现如下方法，然后把方法向外传递
//通过接收JS传出消息的name进行捕捉的回调方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
    if ([self.scriptDelegate respondsToSelector:@selector(userContentController:didReceiveScriptMessage:)]) {
        [self.scriptDelegate userContentController:userContentController didReceiveScriptMessage:message];
    }
}
@end
