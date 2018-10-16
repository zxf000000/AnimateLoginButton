//
//  ViewController.m
//  LoadingButtonDemo
//
//  Created by mr.zhou on 2018/10/8.
//  Copyright © 2018 mr.zhou. All rights reserved.
//

#import "ViewController.h"
#import "LoadingButton.h"

@interface ViewController ()
@property (strong, nonatomic) LoadingButton  *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
}

- (void)setupUI {
    // 初始化button
    self.button = [[LoadingButton alloc] initWithFrame:(CGRectMake(50, 200, 200, 50))];
    [self.view addSubview:self.button];
    self.button.backgroundColor = [UIColor blueColor];
    [self.button setTitle:@"登录" forState:(UIControlStateNormal)];
    [self.button addTarget:self action:@selector(click) forControlEvents:(UIControlEventTouchUpInside)];
}
#pragma mark - 价格标签
- (void)click {
    
    if (self.button.animating) {
        [self.button stopAnimate];
    } else {
        [self.button beginAnimate];

    }
    
}

@end
