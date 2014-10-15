//
//  SYEditorPanel.m
//  APDebugPlugin
//
//  Created by satyso on 14-10-12.
//  Copyright (c) 2014年 Alipay. All rights reserved.
//

#import "SYEditorPanel.h"
#import "SYButton.h"

#define kPanelWidth                 300
#define kPanelHeight                30

#define kSaveButtonwidth            40
#define kSaveButtonHeight           30

#define kPanelTextFieldWidth        40

@interface SYEditorPanel ()<UITextFieldDelegate>

//@property (nonatomic, strong) UILabel*          x;
//@property (nonatomic, strong) UILabel*          y;
//@property (nonatomic, strong) UILabel*          width;
//@property (nonatomic, strong) UILabel*          height;
//@property (nonatomic, strong) UILabel*          alpha;

@property (nonatomic, strong) UITextField*      xTF;
@property (nonatomic, strong) UITextField*      yTF;
@property (nonatomic, strong) UITextField*      widthTF;
@property (nonatomic, strong) UITextField*      heightTF;
@property (nonatomic, strong) UITextField*      alphaTF;

@property (nonatomic, strong) UILabel*          title;

@property (nonatomic, weak) UIView*             targetView;
@property (nonatomic, assign) CGRect            targetViewRect;

@property (nonatomic, strong) UIButton*         save;

- (void)setDefaultEditValue:(CGRect)targetBounds
                      alpha:(float)alpha
                      title:(NSString*)title;

@end

@implementation SYEditorPanel

- (instancetype)init
{
    if (self = [super init])
    {
        {//x
            UILabel* x = [[UILabel alloc] initWithFrame:CGRectMake(5, kSaveButtonHeight, 10, kPanelHeight)];
            x.text = @"x:";
            x.textAlignment = NSTextAlignmentLeft;
            x.font = [UIFont systemFontOfSize:10];
            x.textColor = kTextColor;
            [self addSubview:x];
            
            _xTF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(x.frame), CGRectGetMinY(x.frame), kPanelTextFieldWidth, kPanelHeight)];
            _xTF.delegate = self;
            _xTF.font = [UIFont systemFontOfSize:10];
            _xTF.textColor = kTextColor;
            _xTF.layer.borderColor = kTextColor.CGColor;
            _xTF.layer.borderWidth = 1;
            [self addSubview:_xTF];
        }
        
        {//y
            UILabel* y = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_xTF.frame) + 5, CGRectGetMinY(_xTF.frame), 10, kPanelHeight)];
            y.text = @"y:";
            y.textAlignment = NSTextAlignmentLeft;
            y.font = [UIFont systemFontOfSize:10];
            y.textColor = kTextColor;
            [self addSubview:y];
            
            _yTF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(y.frame), CGRectGetMinY(y.frame), kPanelTextFieldWidth, kPanelHeight)];
            _yTF.font = [UIFont systemFontOfSize:10];
            _yTF.delegate = self;
            _yTF.textColor = kTextColor;
            _yTF.layer.borderColor = kTextColor.CGColor;
            _yTF.layer.borderWidth = 1;
            [self addSubview:_yTF];
        }
        
        {//width
            UILabel* w = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_yTF.frame) + 5, CGRectGetMinY(_xTF.frame), 10, kPanelHeight)];
            w.text = @"w:";
            w.textAlignment = NSTextAlignmentLeft;
            w.font = [UIFont systemFontOfSize:10];
            w.textColor = kTextColor;
            [self addSubview:w];
            
            _widthTF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(w.frame), CGRectGetMinY(w.frame), kPanelTextFieldWidth, kPanelHeight)];
            _widthTF.font = [UIFont systemFontOfSize:10];
            _widthTF.delegate = self;
            _widthTF.textColor = kTextColor;
            _widthTF.layer.borderColor = kTextColor.CGColor;
            _widthTF.layer.borderWidth = 1;
            [self addSubview:_widthTF];
        }
        
        {//height
            UILabel* h = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_widthTF.frame) + 5, CGRectGetMinY(_xTF.frame), 10, kPanelHeight)];
            h.text = @"h:";
            h.textAlignment = NSTextAlignmentLeft;
            h.font = [UIFont systemFontOfSize:10];
            h.textColor = kTextColor;
            [self addSubview:h];
            
            _heightTF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(h.frame), CGRectGetMinY(h.frame), kPanelTextFieldWidth, kPanelHeight)];
            _heightTF.font = [UIFont systemFontOfSize:10];
            _heightTF.delegate = self;
            _heightTF.textColor = kTextColor;
            _heightTF.layer.borderColor = kTextColor.CGColor;
            _heightTF.layer.borderWidth = 1;
            [self addSubview:_heightTF];
        }
        
        {//alpha
            UILabel* alpha = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_heightTF.frame) + 5, CGRectGetMinY(_xTF.frame), 30, kPanelHeight)];
            alpha.text = @"alpha:";
            alpha.textAlignment = NSTextAlignmentLeft;
            alpha.font = [UIFont systemFontOfSize:10];
            alpha.textColor = kTextColor;
            [self addSubview:alpha];
            
            _alphaTF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(alpha.frame), CGRectGetMinY(alpha.frame), kPanelTextFieldWidth, kPanelHeight)];
            _alphaTF.font = [UIFont systemFontOfSize:10];
            _alphaTF.delegate = self;
            _alphaTF.textColor = kTextColor;
            _alphaTF.layer.borderColor = kTextColor.CGColor;
            _alphaTF.layer.borderWidth = 1;
            [self addSubview:_alphaTF];
        }
        
        {//save close class name
            SYButton* save = [SYButton contructInstanceWithFrame:CGRectMake(kPanelWidth - kSaveButtonwidth - 10,
                                                                            0,
                                                                            kSaveButtonwidth,
                                                                            kSaveButtonHeight)];
            
            [save setTitle:@"save" forState:UIControlStateNormal];
            [save addTarget:self action:@selector(saveChanged) forControlEvents:UIControlEventTouchDown];
            
            [self addSubview:save];

            SYButton* close = [SYButton contructInstanceWithFrame:CGRectMake(CGRectGetMinX(save.frame) - kSaveButtonwidth - 10,
                                                                            0,
                                                                            kSaveButtonwidth,
                                                                            kSaveButtonHeight)];
            
            [close setTitle:@"close" forState:UIControlStateNormal];
            [close addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchDown];
            [self addSubview:close];
            
            UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(close.frame) - 100,
                                                                       0,
                                                                       100,
                                                                       kSaveButtonHeight)];
            label.text = @"点不到可能是浮层干扰";
            label.textAlignment = NSTextAlignmentLeft;
            label.font = [UIFont systemFontOfSize:8];
            label.textColor = kTextColor;
            [self addSubview:label];
            
            _title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetMinX(label.frame), kSaveButtonHeight)];
            _title.textAlignment = NSTextAlignmentLeft;
            _title.font = [UIFont systemFontOfSize:10];
            _title.textColor = kTextColor;
            [self addSubview:_title];
        }
        
        
        self.backgroundColor = kTextBackgroundColor;
    }
    return self;
}

- (void)targetView:(UIView*)view
{
    self.targetView = view;
    
    CGRect rect = [self.targetView convertRect:self.targetView.bounds toView:[UIApplication sharedApplication].keyWindow];
    
    if (rect.origin.y - kPanelHeight - kSaveButtonHeight > CGRectGetHeight([UIScreen mainScreen].bounds) * 0.3)
    {//显示上面
        self.frame = CGRectMake((CGRectGetWidth([UIScreen mainScreen].bounds) - kPanelWidth) / 2,
                                CGRectGetMinY(rect) - kPanelHeight - kSaveButtonHeight,
                                kPanelWidth,
                                kPanelHeight + kSaveButtonHeight);
    }
    else
    {//显示下面
        self.frame = CGRectMake((CGRectGetWidth([UIScreen mainScreen].bounds) - kPanelWidth) / 2,
                                CGRectGetMaxY(rect),
                                kPanelWidth,
                                kPanelHeight + kSaveButtonHeight);
    }
    
    rect = [self.targetView convertRect:self.targetView.bounds toView:[UIApplication sharedApplication].keyWindow];
    [self setDefaultEditValue:rect alpha:self.targetView.alpha title:NSStringFromClass([view class])];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)setDefaultEditValue:(CGRect)targetBounds
                      alpha:(float)alpha
                      title:(NSString*)title
{
    self.xTF.text = [NSString stringWithFormat:@"%0.2lf", targetBounds.origin.x];
    self.yTF.text = [NSString stringWithFormat:@"%0.2lf", targetBounds.origin.y];
    self.widthTF.text = [NSString stringWithFormat:@"%0.2lf", targetBounds.size.width];
    self.heightTF.text = [NSString stringWithFormat:@"%0.2lf", targetBounds.size.height];
    self.alphaTF.text = [NSString stringWithFormat:@"%0.2lf", self.targetView.alpha];
    if (title == nil)
    {
        self.title.text = @"unknow";
    }
    else
    {
        self.title.text = title;
    }
}

#pragma mark- textField delegate
//http://blog.csdn.net/chengyakun11/article/details/8494292
//textField.text 输入之前的值         string 输入的字符
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL isHaveDian = NO;
    if ([textField.text rangeOfString:@"."].location==NSNotFound) {
        isHaveDian=NO;
    }
    if ([string length]>0)
    {
        unichar single=[string characterAtIndex:0];//当前输入的字符
        if ((single >='0' && single<='9') || single=='.')//数据格式正确
        {
            //首字母不能为0和小数点
            if([textField.text length]==0){
                if(single == '.'){
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                    
                }
            }
            if (single=='.')
            {
                if(!isHaveDian)//text中还没有小数点
                {
                    isHaveDian=YES;
                    return YES;
                }else
                {
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            else
            {
                if (isHaveDian)//存在小数点
                {
                    //判断小数点的位数
                    NSRange ran=[textField.text rangeOfString:@"."];
                    int tt=(int)(range.location-ran.location);
                    if (tt <= 2){
                        return YES;
                    }else{
                        return NO;
                    }
                }
                else
                {
                    return YES;
                }
            }
        }else{//输入的数据格式不正确
            [textField.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
        }
    }
    else
    {
        return YES;
    }
    
}

#pragma mark- button delegate

- (void)saveChanged
{
    if (self.targetView)
    {
        CGRect rect = CGRectMake([self.xTF.text floatValue],
                                 [self.yTF.text floatValue],
                                 [self.widthTF.text floatValue],
                                 [self.heightTF.text floatValue]);
        
        rect = [[UIApplication sharedApplication].keyWindow convertRect:rect toView:self.targetView.superview];
        
        self.targetView.frame = rect;
        
        self.targetView.alpha = [self.alphaTF.text floatValue];
    }
}

- (void)close
{
    [self removeFromSuperview];
}

@end
