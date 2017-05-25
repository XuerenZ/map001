//
//  XRSportMainViewController.m
//  map001
//
//  Created by acer on 17/5/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "XRSportMainViewController.h"
#import "XRSportTracking.h"
#import "XRSportSportingViewController.h"
@interface XRSportMainViewController ()

@end

@implementation XRSportMainViewController


- (IBAction)StartSportBtn:(UIButton *)sender {
    // 1. 根据按钮的 tag 区分运动类型
     XRSportType type = sender.tag;
    
    // 2. 从 storyboard 加载监控控制器
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"XRSportSporting" bundle:nil];
    XRSportSportingViewController *vc = sb.instantiateInitialViewController;
    
    // 3. 设置运动类型
    vc.sportType = type;
    
    // 4. 展现控制器
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
