//
//  UIView+SYInterfaceEditor.m
//  APDebugPlugin
//
//  Created by satyso on 14-10-12.
//  Copyright (c) 2014年 Alipay. All rights reserved.
//

#import "UIView+SYInterfaceEditor.h"
#import "SYDebugFrameView.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "SYInterfaceEditor.h"
#import "SYEditorPanel.h"

@implementation UIView (SYInterfaceEditor)

- (void)setDebugFrameView:(SYDebugFrameView *)debugFrameView
{
    objc_setAssociatedObject(self, @selector(debugFrameView), debugFrameView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (SYDebugFrameView*)debugFrameView
{
    return objc_getAssociatedObject(self, @selector(debugFrameView));
}

- (void)showDebugView
{
    if ([self isKindOfClass:[SYDebugFrameView class]]
        || [self isKindOfClass:[SYEditorPanel class]])
    {
        return;
    }
    
    if (self.debugFrameView == nil)
    {
        [self setDebugFrameView:[[SYDebugFrameView alloc] initWithFrame:self.bounds]];
        [self addSubview:self.debugFrameView];
    }
}

- (void)removeDebugView
{
    if (self.debugFrameView)
    {
        self.debugFrameView.hidden = YES;
        [self.debugFrameView removeFromSuperview];
        self.debugFrameView = nil;
        [self setNeedsDisplay];
    }
}

@end
