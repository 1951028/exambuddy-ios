#import "LocalSchemeHandler.h"

// 把 app://local/<文件名> 映射到 App 包内的资源文件（Resources/ 目录）。
// 页面只有一份 index.html（题库、样式、逻辑全部内嵌），这里顺带支持以后放图标等零星文件。
@implementation LocalSchemeHandler

- (void)webView:(WKWebView *)webView startURLSchemeTask:(id<WKURLSchemeTask>)task {
	NSURL *url = task.request.URL;
	NSString *path = url.path;                       // 形如 "/index.html"
	if (path.length > 1) {
		path = [path substringFromIndex:1];
	} else {
		path = @"index.html";
	}
	NSString *ext = path.pathExtension.lowercaseString;
	NSString *name = path.stringByDeletingPathExtension;
	NSString *file = [[NSBundle mainBundle] pathForResource:name ofType:ext];

	if (!file || ext.length == 0) {
		NSError *err = [NSError errorWithDomain:NSCocoaErrorDomain
		                                   code:NSFileReadNoSuchFileError
		                               userInfo:@{NSLocalizedDescriptionKey : @"not found"}];
		[task didFailWithError:err];
		return;
	}

	NSDictionary *mimes = @{
		@"html"        : @"text/html; charset=utf-8",
		@"css"         : @"text/css; charset=utf-8",
		@"js"          : @"application/javascript",
		@"json"        : @"application/json",
		@"webmanifest" : @"application/manifest+json",
		@"png"         : @"image/png",
		@"jpg"         : @"image/jpeg",
		@"jpeg"        : @"image/jpeg",
		@"gif"         : @"image/gif",
		@"svg"         : @"image/svg+xml",
		@"ico"         : @"image/x-icon",
		@"woff"        : @"font/woff",
		@"woff2"       : @"font/woff2",
		@"ttf"         : @"font/ttf",
		@"mp3"         : @"audio/mpeg",
	};
	NSString *mime = mimes[ext] ?: @"application/octet-stream";

	NSData *data = [NSData dataWithContentsOfFile:file];
	NSHTTPURLResponse *resp = [[NSHTTPURLResponse alloc] initWithURL:url
	                                                      statusCode:200
	                                                        HTTPVersion:@"HTTP/1.1"
	                                                       headerFields:@{@"Content-Type" : mime}];
	[task didReceiveResponse:resp];
	[task didReceiveData:data];
	[task didFinish];
}

- (void)webView:(WKWebView *)webView stopURLSchemeTask:(id<WKURLSchemeTask>)task {
	// 我们的响应是一次性发完的，没有可取消的进行中任务
}

@end
