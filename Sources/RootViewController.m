#import "RootViewController.h"
#import "LocalSchemeHandler.h"
#import <WebKit/WebKit.h>

@implementation RootViewController {
	WKWebView *_web;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];

	WKWebViewConfiguration *cfg = [[WKWebViewConfiguration alloc] init];
	// 自定义 app:// 协议读取打包在 App 里的网页文件。
	// 不用 file:// 的原因：file 页面没有正经 origin，localStorage（练习进度/错题本都存这）不可靠；
	// 走 scheme handler 的页面有真实 origin，localStorage 正常读写、随 App 沙盒持久化。
	[cfg setURLSchemeHandler:[[LocalSchemeHandler alloc] init] forURLScheme:@"app"];

	_web = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:cfg];
	_web.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	_web.scrollView.bounces = NO;                    // 整页橡皮筋会和页面自己的滚动/横滑打架
	_web.allowsBackForwardNavigationGestures = NO;   // 屏幕边缘右滑返回会抢练习页的横滑切题手势
	_web.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
	[self.view addSubview:_web];

	// 网页自己用 env(safe-area-inset-*) 适配刘海和底部小白条，这里给全屏 frame 即可
	[_web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"app://local/index.html"]]];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
	// 顶栏是深绿色，状态栏用白字
	return UIStatusBarStyleLightContent;
}

@end
