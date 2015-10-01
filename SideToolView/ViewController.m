//
//  ViewController.m
//  SideToolView
//
//  Created by 徐宽阔 on 15/9/26.
//  Copyright © 2015年 XDKOO. All rights reserved.
//

#import "ViewController.h"
#import "RightSideToolView.h"

@interface ViewController ()
- (IBAction)menuClick:(UIBarButtonItem *)sender;

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

- (IBAction)menuClick:(UIBarButtonItem *)sender {
    
    [RightSideToolView show];
    
}
@end
