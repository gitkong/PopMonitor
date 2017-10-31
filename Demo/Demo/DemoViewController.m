//
//  DemoViewController.m
//  Demo
//
//  Created by 孔凡列 on 2017/10/31.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "DemoViewController.h"
#import "UIViewController+Pop.h"

static BOOL canPop = YES;

@interface DemoViewController ()<FLNavigationPopProtocol>

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    canPop = YES;
    
//    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
//    [btn setTitle:@"back" forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"canPop" style:UIBarButtonItemStyleDone target:self action:@selector(click)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    canPop = NO;
}

- (void)back {
//    [self.navigationController popViewControllerAnimated:YES];
    [self handleCustomPopItem];
}

- (void)click {
    canPop = !canPop;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:!canPop ? @"canNotPop" : @"canPop" style:UIBarButtonItemStyleDone target:self action:@selector(click)];
}


- (FLNavigationPopType)shouldPop:(BOOL)fromPan {
    NSLog(fromPan ? @"love" : @"you");
    return canPop ? FLNavigationPopTypeBoth : FLNavigationPopTypeNone;
}

@end
