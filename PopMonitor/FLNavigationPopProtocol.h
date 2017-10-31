//
//  FLNavigationPopProtocol.h
//  MiniVcDemo
//
//  Created by 孔凡列 on 2017/10/30.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#ifndef FLNavigationPopProtocol_h
#define FLNavigationPopProtocol_h

typedef NS_ENUM(NSUInteger, FLNavigationPopType) {
    FLNavigationPopTypeNone,
    FLNavigationPopTypeTap,
    FLNavigationPopTypePan,
    FLNavigationPopTypeBoth
};

@protocol FLNavigationPopProtocol<NSObject>

@optional

- (FLNavigationPopType)shouldPop:(BOOL)fromPan;

@end

#endif /* FLNavigationPopProtocol_h */
