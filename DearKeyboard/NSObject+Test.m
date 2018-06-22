//
//  NSObject+Test.m
//  DearKeyboard
//
//  Created by 王昌阳 on 2018/6/13.
//  Copyright © 2018年 王昌阳. All rights reserved.
//

#import "NSObject+Test.h"

@implementation NSObject (Test)

+ (void)printA {
    NSLog(@"A");
}

- (void)printB {
    NSLog(@"B:%@", NSStringFromClass(self.class));
}

@end
