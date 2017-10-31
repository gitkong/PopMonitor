//
//  ViewController.m
//  Demo
//
//  Created by 孔凡列 on 2017/10/31.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "ViewController.h"
#import "DemoViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"点空白页跳转";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    DemoViewController *vc = [[DemoViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
