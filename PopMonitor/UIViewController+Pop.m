//
//  UIViewController+Pop.m
//  MiniVcDemo
//
//  Created by 孔凡列 on 2017/10/30.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "UIViewController+Pop.h"
#import <objc/runtime.h>

static char *FLShouldPopDelegateStaticKey = "FLShouldPopDelegateStaticKey";

@implementation UIViewController (Pop)

void swizzeMethod(Class class, SEL originSel, SEL targetSel) {
    Method originM = class_getInstanceMethod(class, originSel);
    Method targetM = class_getInstanceMethod(class, targetSel);
    BOOL didAdd = class_addMethod(class, originSel, method_getImplementation(originM), method_getTypeEncoding(targetM));
    if (didAdd) {
        class_replaceMethod(class, targetSel, method_getImplementation(originM), method_getTypeEncoding(originM));
    }
    else {
        method_exchangeImplementations(originM, targetM);
    }
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        swizzeMethod([self class], @selector(viewDidLoad), @selector(fl_viewDidLoad));
    });
}

- (void)fl_viewDidLoad {
    [self fl_viewDidLoad];
    if ([self conformsToProtocol:@protocol(FLNavigationPopProtocol) ]) {
        self.popDelegate = (id<FLNavigationPopProtocol>)self;
        static dispatch_once_t onceToken;
        if (self.navigationController == nil) {
            onceToken = 0;
        }
        dispatch_once(&onceToken, ^{
            if (self.navigationController && [self.navigationController conformsToProtocol:@protocol(UIGestureRecognizerDelegate) ]) {
                self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self.navigationController;
            }
        });
    }
}

- (void)handleCustomPopItem {
    if (self.navigationController.navigationBar.delegate && [self.navigationController.navigationBar.delegate respondsToSelector:@selector(navigationBar:shouldPopItem:)]) {
        [self.navigationController.navigationBar.delegate navigationBar:self.navigationController.navigationBar shouldPopItem:self.navigationItem];
    }
}

- (void)setPopDelegate:(id<FLNavigationPopProtocol>)popDelegate {
    objc_setAssociatedObject(self, &FLShouldPopDelegateStaticKey, popDelegate, OBJC_ASSOCIATION_ASSIGN);
}

- (id<FLNavigationPopProtocol>)popDelegate {
    return objc_getAssociatedObject(self, &FLShouldPopDelegateStaticKey);
}

@end
