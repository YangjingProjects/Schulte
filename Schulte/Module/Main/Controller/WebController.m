//
//  WebController.m
//  Schulte
//
//  Created by Yang on 2018/11/23.
//  Copyright © 2018 YangJing. All rights reserved.
//

#import "WebController.h"

@interface WebController () <UIWebViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UIWebView *webview;

@property (nonatomic, strong) UIView *progressView;

@property (nonatomic, weak) UIButton *reloadBtn;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation WebController {
    NSString *_url;
    NSString *_title;
    BOOL _flag;
}

- (instancetype)initWithUrl:(NSString *)url title:(NSString *)title {
    self = [super init];
    if (self) {
        _url = url;
        _title = title;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    
    [self addSubview];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barTintColor = kRGBA(28, 28, 28, 1);
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:17]};
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navbar_back"] style:UIBarButtonItemStyleDone target:self action:@selector(popAction:)];

    if (_flag) return;
    _flag = YES;
    if ([_url hasPrefix:@"http://"]||
        [_url hasPrefix:@"https://"]) {
        NSURLRequest * request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString: _url]  cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
        [self.webview loadRequest:request];
    } else {
        [self.webview loadHTMLString:[NSString stringWithFormat:@"<h5>%@<h5>", _url] baseURL:nil];
    }
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.timer invalidate];
    self.timer = nil;
}

//MARK: - UIWebView delegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(loadAnimation) userInfo:nil repeats:YES];
    self.progressView.alpha = 1;
    self.progressView.frame = CGRectMake(0, 0, 0, 3);
    self.reloadBtn.hidden = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self completeAnimation];

    if (!self.title || self.title.length == 0) self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self completeAnimation];
    
    NSDictionary *errorInfo = error.userInfo;
    NSString *failUrl = [NSString stringWithFormat:@"%@",[errorInfo valueForKey:@"NSErrorFailingURLKey"]];
    if ([failUrl containsString:@"rrcc://"]) return;
    self.reloadBtn.hidden = NO;
}

//MARK: - webview delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

- (void)popAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadAnimation {
    if (self.progressView.frame.size.width <= kScreenWidth*(2/3.0)) {
        [UIView animateWithDuration:0.5 animations:^{
            CGRect rect = self.progressView.frame;
            rect.size.width += arc4random()%50;
            self.progressView.frame = rect;
        } completion:^(BOOL finished) {
        }];
    }
}

- (void)completeAnimation {
    if(self.timer) {
        [self.timer invalidate];
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            if (self.progressView) {
                CGRect rect = self.progressView.frame;
                rect.size.width = kScreenWidth;
                self.progressView.frame = rect;
            }
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.1 animations:^{
                if (self.progressView) {
                    self.progressView.alpha = 0;
                }
            }];
        }];
    }
}

- (void)reloadWebview {
    if ([_url hasPrefix:@"http://"]||
        [_url hasPrefix:@"https://"]) {
        NSURLRequest * request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
        [self.webview loadRequest:request];
    } else {
        [self.webview loadHTMLString:[NSString stringWithFormat:@"<h5>%@<h5>", _url] baseURL:nil];
    }
}

//MARK: - subview
- (void)addSubview {
    self.title = _title;
    
    [self.view addSubview:self.webview];
    self.webview.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    
    [self.webview addSubview:self.reloadBtn];
    [self.reloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.webview.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(120);
    }];
    
    [self.webview addSubview:self.progressView];
    self.progressView.frame = CGRectMake(0, 0, 0, 3);
    
    self.reloadBtn.hidden = YES;
}


//MARK: - getter
- (UIWebView *)webview {
    if (!_webview) {
        _webview = [[UIWebView alloc] init];
        _webview.backgroundColor = [UIColor whiteColor];
        _webview.scalesPageToFit = YES;
        _webview.delegate = self;
    }
    return _webview;
}

- (UIView *)progressView {
    if (!_progressView) {
        _progressView = [[UIView alloc] init];
        _progressView.backgroundColor = UIColorFromRGB(0x00BCD3);
    }
    return _progressView;
}

- (UIButton *)reloadBtn {
    if (!_reloadBtn) {
        _reloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _reloadBtn.layer.cornerRadius = 4;
        _reloadBtn.layer.borderWidth = 1;
        _reloadBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [_reloadBtn setTitle:@"重新加载" forState:UIControlStateNormal];
        [_reloadBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_reloadBtn addTarget:self action:@selector(reloadWebview) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reloadBtn;
}


- (void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
    NSLog(@"yangjing_webview: dealloc");
}

@end
