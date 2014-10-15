//
//  SYInterfaceEditor.h
//  APDebugPlugin
//
//  Created by satyso on 14-10-12.
//  Copyright (c) 2014年 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class SYDebugFrameView;

@interface SYInterfaceEditor : NSObject

+ (instancetype)shareInstance;

- (void)startEdit;

- (void)stop;

- (void)showEditPanelWithView:(UIView*)view;

@property (nonatomic, assign, readonly) BOOL              isDebugState;

@end
