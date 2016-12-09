//
//  NSObject+JS.m
//  XZJavaScriptCoreDemo
//
//  Created by 徐章 on 2016/12/9.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "NSObject+JS.h"
#import <JavaScriptCore/JavaScriptCore.h>

@implementation NSObject (JS)
- (void)webView:(id)unuse didCreateJavaScriptContext:(JSContext *)ctx forFrame:(id)frame {
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"DidCreateContextNotification" object:ctx];
    NSLog(@"注入JS");
}
@end
