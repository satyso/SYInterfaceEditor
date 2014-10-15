//
//  UIView+SYInterfaceEditor.h
//  APDebugPlugin
//
//  Created by satyso on 14-10-12.
//  Copyright (c) 2014年 Alipay. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SYDebugFrameView;

@interface UIView (SYInterfaceEditor)

- (void)showDebugView;

- (void)removeDebugView;

@property (nonatomic, assign) SYDebugFrameView* debugFrameView;

@end
