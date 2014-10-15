//
//  SYInterfaceEditor.m
//  APDebugPlugin
//
//  Created by satyso on 14-10-12.
//  Copyright (c) 2014年 Alipay. All rights reserved.
//

#import "SYInterfaceEditor.h"
#import "UIView+SYInterfaceEditor.h"
#import "SYEditorPanel.h"

@interface SYInterfaceEditor ()

@property (nonatomic, assign) BOOL              isDebugState;

@property (nonatomic, strong) SYEditorPanel*    panel;

@end

@implementation SYInterfaceEditor

+ (instancetype)shareInstance
{
    static SYInterfaceEditor* editor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        editor = [[SYInterfaceEditor alloc] init];
    });
    return editor;
}

- (instancetype)init
{
    if (self = [super init])
    {
    }
    return self;
}

- (void)startEdit
{
    if (self.isDebugState == NO)
    {
//        [UIView swizzleInterfaceEditorIMP];
        UIView* window = [UIApplication sharedApplication].keyWindow;
        scanViewsAndShowDebugView(window);
        self.isDebugState = YES;
    }
}

- (void)stop
{
    if (self.isDebugState == YES)
    {
//        [UIView swizzleInterfaceEditorIMP];
        UIView* window = [UIApplication sharedApplication].keyWindow;
        scanViewsAndRemoveDebugView(window);
        self.isDebugState = NO;
    }
    if (self.panel)
    {
        [self.panel removeFromSuperview];
        self.panel = nil;
    }
}

- (void)showEditPanelWithView:(UIView*)view
{
    if (self.panel == nil)
    {
        self.panel = [[SYEditorPanel alloc] init];
    }
    [self.panel targetView:view];
}

#pragma mark- private

void scanViewsAndShowDebugView(UIView* superView)
{
    for (UIView* view in superView.subviews)
    {
        [view showDebugView];
        scanViewsAndShowDebugView(view);
    }
}

void scanViewsAndRemoveDebugView(UIView* superView)
{
    for (UIView* view in superView.subviews)
    {
        [view removeDebugView];
        scanViewsAndRemoveDebugView(view);
    }
}

@end
