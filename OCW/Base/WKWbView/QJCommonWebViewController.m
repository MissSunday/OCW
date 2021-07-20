//
//  QJCommonWebViewController.m
//  QJLookingForHouseAPP
//
//  Created by admin on 2020/4/12.
//  Copyright © 2020 唐山千家房地产经纪有限公司. All rights reserved.
//

// !!!: 注意 这块最初的目的是搭建一个通用的网页控制器 就是为了加载用的  但是随着需求的增加  加入了不少js交互的判断  这些网页还没有规律  好多人写的  各有各的方法   其实我是不建议在这个里边写逻辑的

#import "QJCommonWebViewController.h"
#import "QJCommonWebViewCustomNav.h"
#import "QJWeakWebViewScriptMessageDelegate.h"


@interface QJCommonWebViewController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>

@property (nonatomic, strong)UIProgressView *progressView;

@property(nonatomic,strong)QJCommonWebViewCustomNav *nav;

@end

@implementation QJCommonWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isHidenNav = YES;
    [self UI];
    [self requestData];
   
}
-(void)UI{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
    [self.view addSubview:self.nav];
    [self.view addSubview:self.progressView];
    [self laout];
}
-(void)laout{
    [self.nav mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(kNavHeight);
    }];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nav.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(2);
        make.top.equalTo(self.nav.mas_bottom);
    }];
    [self binding];
}
-(void)binding{
    @weakify(self);
       [[RACObserve(self.webView, canGoBack)skip:1]subscribeNext:^(id  _Nullable x) {
           @strongify(self);
           NSLog(@"canGoBack 变化了");
           if ([self.webView canGoBack]) {
               self.nav.closeBtn.hidden = NO;
           }else{
               self.nav.closeBtn.hidden = YES;
           }
       }];
    [[self.nav.backBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if ([self.webView canGoBack]) {
            [self.webView goBack];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    [[self.nav.closeBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
}
- (void)setCustomNavTitle:(NSString *)customNavTitle{
    _customNavTitle = customNavTitle;
    self.nav.titleL.text = customNavTitle;
}
-(void)requestData{}
- (void)setUrl:(NSString *)url{
    _url = url;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}
// 记得取消监听
- (void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}
// 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        self.progressView.alpha = 1.0f;
        [self.progressView setProgress:newprogress animated:YES];
        if (newprogress >= 1.0f) {
            [UIView animateWithDuration:0.3f
                                  delay:0.3f
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 self.progressView.alpha = 0.0f;
                             }
                             completion:^(BOOL finished) {
                                 [self.progressView setProgress:0 animated:NO];
                             }];
        }
        
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


// 页面开始加载时调用
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"页面开始加载时调用");
    
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"当内容开始返回时调用");
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{//这里修改导航栏的标题，动态改变
    NSLog(@"页面加载完成之后调用");
 
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"页面加载失败时调用");
}
// 接收到服务器跳转请求之后再执行
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"接收到服务器跳转请求之后再执行");
}
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    NSLog(@"在收到响应后，决定是否跳转");
    NSLog(@"%@",navigationResponse);
    WKNavigationResponsePolicy actionPolicy = WKNavigationResponsePolicyAllow;
    //这句是必须加上的，不然会异常
    decisionHandler(actionPolicy);
}
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSLog(@"在发送请求之前，决定是否跳转");
    //这句是必须加上的，不然会异常
    NSURL *requestURL = navigationAction.request.URL;
    NSLog(@"-----%@",requestURL.absoluteString);
    if ([requestURL.absoluteString rangeOfString:@"tel:"].location != NSNotFound) {
        
        decisionHandler(WKNavigationActionPolicyCancel);
    }else if ([requestURL.absoluteString rangeOfString:@"SecondHouseDetail?"].location != NSNotFound && ![self.webView.URL.absoluteString isEqualToString:requestURL.absoluteString]) {
        
        decisionHandler(WKNavigationActionPolicyCancel);
    }else{
        decisionHandler(WKNavigationActionPolicyAllow);
    }
    
}
//被自定义的WKScriptMessageHandler在回调方法里通过代理回调回来，绕了一圈就是为了解决内存不释放的问题
//通过接收JS传出消息的name进行捕捉的回调方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSLog(@"name:%@\\\\n body:%@\\\\n frameInfo:%@\\\\n",message.name,message.body,message.frameInfo);
    //用message.body获得JS传出的参数体
    NSDictionary * parameter = message.body;
    //JS调用OC
    if([message.name isEqualToString:@"goBack"]){
        [self.navigationController popViewControllerAnimated:YES];
        
    }else if ([message.name isEqualToString:@"getQrCode"]){
        NSString *msg = parameter[@"msg"];
        NSLog(@"aaaaaaaa-%@",msg);
    }else if ([message.name isEqualToString:@"getLevelPivileges"]){
        
        NSLog(@"aaaaaaaa-");
    }
    
    
    
}
- (WKWebView *)webView{
    if (!_webView) {
        
        //创建网页配置对象
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        
        // 创建设置对象
        WKPreferences *preference = [[WKPreferences alloc]init];
        //最小字体大小 当将javaScriptEnabled属性设置为NO时，可以看到明显的效果
        preference.minimumFontSize = 0;
        //设置是否支持javaScript 默认是支持的
        preference.javaScriptEnabled = YES;
        // 在iOS上默认为NO，表示是否允许不经过用户交互由javaScript自动打开窗口
        preference.javaScriptCanOpenWindowsAutomatically = YES;
        config.preferences = preference;
        
        // 是使用h5的视频播放器在线播放, 还是使用原生播放器全屏播放
        config.allowsInlineMediaPlayback = YES;
        //设置视频是否需要用户手动播放  设置为NO则会允许自动播放
        config.requiresUserActionForMediaPlayback = YES;
        //设置是否允许画中画技术 在特定设备上有效
        config.allowsPictureInPictureMediaPlayback = YES;
        //设置请求的User-Agent信息中应用程序名称 iOS9后可用
        //config.applicationNameForUserAgent = @"ChinaDailyForiPad";
        
        //自定义的WKScriptMessageHandler 是为了解决内存不释放的问题
        QJWeakWebViewScriptMessageDelegate *weakScriptMessageDelegate = [[QJWeakWebViewScriptMessageDelegate alloc] initWithDelegate:self];
        //这个类主要用来做native与JavaScript的交互管理
        WKUserContentController * wkUController = [[WKUserContentController alloc] init];
        
        //有特殊功能的网页 最好是单写一个vc继承这个commonVC 代理方法可以在子类里重写 js交互的注册我不清楚在子类里怎么写  就全写在这吧  再在单独的子vc里实现代理方法 判断各自的交互
        //注册一个name为jsToOcNoPrams的js方法 设置处理接收JS方法的对象
        [wkUController addScriptMessageHandler:weakScriptMessageDelegate  name:@"goBack"];
        [wkUController addScriptMessageHandler:weakScriptMessageDelegate  name:@"Share"];
        [wkUController addScriptMessageHandler:weakScriptMessageDelegate  name:@"zhaoPinCall"];
        [wkUController addScriptMessageHandler:weakScriptMessageDelegate  name:@"getLevelPivileges"];
        [wkUController addScriptMessageHandler:weakScriptMessageDelegate  name:@"getQrCode"];
        [wkUController addScriptMessageHandler:weakScriptMessageDelegate  name:@"goTop"];
        config.userContentController = wkUController;
        

        
        _webView = [[WKWebView alloc]initWithFrame:CGRectZero configuration:config];
        _webView.UIDelegate = self;        // UI代理
        _webView.navigationDelegate = self;        // 导航代理
        _webView.allowsBackForwardNavigationGestures = YES;       // 左滑返回
        _webView.opaque = NO;
        _webView.backgroundColor = [UIColor whiteColor];
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        if(@available(iOS 11.0, *)) {
            _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _webView;
}
- (UIProgressView *)progressView
{
    if (_progressView == nil) {
        _progressView = [[UIProgressView alloc] init];
        _progressView.tintColor = [UIColor greenColor];
        _progressView.trackTintColor = [UIColor whiteColor];
    }
    
    return _progressView;
}
- (QJCommonWebViewCustomNav *)nav{
    if (!_nav) {
        _nav = [[QJCommonWebViewCustomNav alloc]init];
        _nav.backgroundColor = [UIColor whiteColor];
    }
    return _nav;
}
@end
