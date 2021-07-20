//
//  QJCommonWebViewController.h
//  QJLookingForHouseAPP
//
//  Created by admin on 2020/4/12.
//  Copyright © 2020 唐山千家房地产经纪有限公司. All rights reserved.
//

#import "QJCommonWebViewController.h"
#import "BaseViewController.h"
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN
/**
 通用的wkwebview  带有进度条
 @author 王晓冉
 @date 2020/04/12
 */
@interface QJCommonWebViewController : BaseViewController


@property (nonatomic,copy)NSString *url;

@property (nonatomic,copy)NSString *customNavTitle;

@property(nonatomic,strong)WKWebView *webView;


@end

NS_ASSUME_NONNULL_END
