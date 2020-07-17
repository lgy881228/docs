//
//  ViewController.m
//  XEngine
//
//  Created by edz on 2020/7/7.
//  Copyright © 2020 edz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
- (void)push
{
  
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.customizedEnabled = YES;
    self.view.backgroundColor = UIColor.redColor;
    // Do any additional setup after loading the view.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"345678" forState:UIControlStateNormal];
    button.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:button];
    [button addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}


@end
