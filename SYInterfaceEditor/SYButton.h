//
//  SYButton.h
//  APDebugPlugin
//
//  Created by ZQP on 6/25/14.
//  Copyright (c) 2014 Alipay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYButton : UIButton

+ (SYButton *)contructInstance;

+ (SYButton *)contructInstanceWithFrame:(CGRect)frame;

- (void)setCallBack:(dispatch_block_t)block forControlEvents:(UIControlEvents)controlEvents;

@end
