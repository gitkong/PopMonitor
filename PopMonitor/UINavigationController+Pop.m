//
//  UINavigationController+Pop.m
//  MiniVcDemo
//
//  Created by 孔凡列 on 2017/10/30.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "UINavigationController+Pop.h"
#import "UIViewController+Pop.h"
#import <objc/runtime.h>

@implementation UINavigationController (Pop)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        swizzeMethod([self class], @selector(navigationBar:shouldPopItem:), @selector(fl_navigationBar:shouldPopItem:));
    });
}

- (BOOL)fl_navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    if (self.currentViewController && self.currentViewController.popDelegate && [self.currentViewController.popDelegate respondsToSelector:@selector(shouldPop:)]) {
        FLNavigationPopType type = [self.currentViewController.popDelegate shouldPop:NO];
        if (type == FLNavigationPopTypeTap || type == FLNavigationPopTypeBoth) {
            return [self fl_navigationBar:navigationBar shouldPopItem:item];
        }
        return NO;
    }
    return [self fl_navigationBar:navigationBar shouldPopItem:item];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        if (!self.currentViewController) return NO;
        if (self.currentViewController.popDelegate && [self.currentViewController.popDelegate respondsToSelector:@selector(shouldPop:)]) {
            FLNavigationPopType type = [self.currentViewController.popDelegate shouldPop:YES];
            if (type == FLNavigationPopTypeTap || type == FLNavigationPopTypeNone) {
                return NO;
            }
            return YES;
        }
    }
    return YES;
}

- (UIViewController *)currentViewController {
    if (self.viewControllers.count) {
        return self.visibleViewController;
    }
    return nil;
}


@end
