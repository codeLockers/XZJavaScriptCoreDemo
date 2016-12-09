//
//  XZModel.m
//  XZJavaScriptCoreDemo
//
//  Created by 徐章 on 2016/12/9.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "XZModel.h"
#import <JavaScriptCore/JavaScriptCore.h>

//遵守协议JSExport
@protocol XZModelProtocol <JSExport>

//JSExportAs(jsMethodName, -(void)good:(NSString *)good bad:(NSString *)bad);

//暴露方法给JS
- (NSString *)fullName;
//暴露属性给JS
@property (nonatomic, strong) NSString *name;
@end

@interface XZModel()<XZModelProtocol>
@end

@implementation XZModel
@synthesize name;

- (id)init{
    self = [super init];
    if (self) {
        self.name = @"FClassroom";
    }
    return self;
}
//实现方法
- (NSString *)fullName{
    NSLog(@"fullName");
    return @"FullName";
}


@end
