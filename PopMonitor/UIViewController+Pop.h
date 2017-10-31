//
//  UIViewController+Pop.h
//  MiniVcDemo
//
//  Created by 孔凡列 on 2017/10/30.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLNavigationPopProtocol.h"

OBJC_EXPORT void swizzeMethod(Class class, SEL originSel, SEL targetSel);

@interface UIViewController (Pop)

@property (nonatomic, weak) id<FLNavigationPopProtocol> popDelegate;

- (void)handleCustomPopItem;

@end
