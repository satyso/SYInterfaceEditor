//
//  ViewController.m
//  SYInterfaceEditor
//
//  Created by satyso on 14-10-13.
//  Copyright (c) 2014年 satyso. All rights reserved.
//

#import "ViewController.h"

#import "SYInterfaceEditor.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)startEdit:(id)sender {
    
    [[SYInterfaceEditor shareInstance] startEdit];
}
- (IBAction)stopEdit:(id)sender {
    
    [[SYInterfaceEditor shareInstance] stop];
}

@end
