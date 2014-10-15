//
//  SYButton.m
//  APDebugPlugin
//
//  Created by ZQP on 6/25/14.
//  Copyright (c) 2014 Alipay. All rights reserved.
//

#import "SYButton.h"

@interface SYButton ()

@property (nonatomic, copy) dispatch_block_t block;

@end

@implementation SYButton

+ (SYButton *)contructInstance
{
    return [SYButton contructInstanceWithFrame:CGRectZero];
}

+ (SYButton *)contructInstanceWithFrame:(CGRect)frame
{
    SYButton *button = [[SYButton alloc] init];
    button.frame = frame;
    button.titleLabel.font = [UIFont systemFontOfSize:12.0];
    button.layer.cornerRadius = 3.0;
    button.layer.masksToBounds = YES;
    button.backgroundColor = kTextBackgroundColor;
    [button setTitleColor:kTextColor forState:UIControlStateNormal];
    return button;
}

- (void)setCallBack:(dispatch_block_t)block forControlEvents:(UIControlEvents)controlEvents
{
    self.block = block;
    [self addTarget:self action:@selector(click) forControlEvents:controlEvents];
}

- (void)click
{
    if (self.block)
    {
        self.block();
    }
}

@end
