//
//  QJWeakWebViewScriptMessageDelegate.h
//  QJLookingForHouseAPP
//
//  Created by admin on 2020/6/9.
//  Copyright © 2020 唐山千家房地产经纪有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface QJWeakWebViewScriptMessageDelegate : NSObject<WKScriptMessageHandler>
//WKScriptMessageHandler 这个协议类专门用来处理JavaScript调用原生OC的方法
@property (nonatomic, weak) id<WKScriptMessageHandler> scriptDelegate;

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate;

@end

NS_ASSUME_NONNULL_END
