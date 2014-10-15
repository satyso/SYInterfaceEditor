//
//  SYDebugFrameView.m
//  SYDebugView
//
//  Created by satyso on 14-10-12.
//  Copyright (c) 2014年 Alipay. All rights reserved.
//

#import "SYDebugFrameView.h"
#import "SYInterfaceEditor.h"

@interface SYDebugFrameView ()

@end

@implementation SYDebugFrameView

-(void)didMoveToSuperview
{
    [self setNeedsDisplay];
    [self commonSetup];
}

-(void)commonSetup
{
    self.frame = self.superview.bounds;
    self.userInteractionEnabled = YES;
    self.layer.borderColor = [self randomColor].CGColor;
    self.layer.borderWidth = 1;
}

-(UIColor*)randomColor
{
    float r = (arc4random()%200/255.0);
    float g = (arc4random()%200/255.0);
    float b = (arc4random()%200/255.0);
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIView* window = [UIApplication sharedApplication].keyWindow;
    
    UITouch* touch = [touches anyObject];
    CGPoint p = [touch locationInView:window];
    
    UIView* result = nil;
    
    findTargetViewRecursive(window, p, &result);
    
//    CGRect rect = [result convertRect:result.bounds toView:[UIApplication sharedApplication].keyWindow];
//    NSLog(@"touchesBegan = %@", NSStringFromCGRect(rect));
    [[SYInterfaceEditor shareInstance] showEditPanelWithView:result.superview];
}

void findTargetViewRecursive(UIView* superView, CGPoint p, UIView** targetView)
{
    for (UIView* view in superView.subviews)
    {//查找SYDebugFrameView 因为可以加快速度
        if ([view isKindOfClass:[SYDebugFrameView class]] && view.superview.hidden == NO)
        {
            CGRect rect = [view convertRect:view.bounds toView:[UIApplication sharedApplication].keyWindow];
            if (CGRectContainsPoint(rect, p))
            {
                if (*targetView)
                {
                    CGRect lastRect = [(*targetView) convertRect:(*targetView).bounds toView:[UIApplication sharedApplication].keyWindow];
                    if (CGRectContainsRect(lastRect, rect))
                    {
                        *targetView = view;
                    }
                }
                else
                {
                    *targetView = view;
                }
            }
        }
        findTargetViewRecursive(view, p, targetView);
    }
}

@end
