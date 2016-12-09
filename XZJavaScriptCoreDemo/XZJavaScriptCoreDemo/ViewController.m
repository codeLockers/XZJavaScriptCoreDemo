//
//  ViewController.m
//  XZJavaScriptCoreDemo
//
//  Created by 徐章 on 2016/12/9.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

#import "XZModel.h"

@interface ViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) JSContext *jsContext;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *urlStr = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    self.webView.delegate = self;
    [self.webView loadRequest:request];
    
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{

    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{

}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    //获取JS的上下文
    self.jsContext = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    self.jsContext.exceptionHandler = ^(JSContext *con, JSValue *exception) {
        NSLog(@"%@", exception);
        con.exception = exception;
    };
    
    
    //获取JS中jsCallNative方法并设置Native代码Block，Block的参数数目与实际的方法的参数数目不一定要一致
    self.jsContext[@"jsCallNative"] = ^(NSString *params1){
        //获取该方法的所有参数，以数组的形式返回
        NSArray *currentParamers = [JSContext currentArguments];
        //所有参数都是JSValue类型
        JSValue *param3 = currentParamers[2];
        JSValue *param4 = currentParamers[3];
    
        //JSValue转NSArray
        NSLog(@"JS paramer is %@",[param3 toArray]);
        //JSValue转NSDictionary
        NSLog(@"JS paramer is %@",[param4 toDictionary]);
        NSLog(@"currentParamers is %@",currentParamers);
    };
    
    //注册对象
    self.jsContext[@"model"] = [[XZModel alloc] init];
    
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{

}

#pragma mark - Action_Methods
- (IBAction)nativeCallJsBtn_Pressed:(id)sender {
    //获取js的方法nativeCallJs
//    JSValue *value = self.jsContext[@"nativeCallJs"];
//    //执行nativeCallJs方法
//    [value callWithArguments:@[@"param1",@[@"a",@"b"],@{@"key1":@"value1",@"key2":@"value2"}]];
    
    [self.jsContext evaluateScript:@"alert('FClassRoom2')"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
