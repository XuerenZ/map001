//
//  XRSportSportingViewController.m
//  map001
//
//  Created by acer on 17/5/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "XRSportSportingViewController.h"
#import "XRSportMapViewController.h"
#import "XRSportTracking.h"
@interface XRSportSportingViewController ()

@end

@implementation XRSportSportingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    
    [self setupMapViewController];
}
/**
 设置地图视图控制器
 */
- (void)setupMapViewController {
    
    // 1. 实例化地图控制器
    XRSportMapViewController *vc = [XRSportMapViewController new];
    
    // 2. 添加到当前控制器的子控制器
    [self addChildViewController:vc];
    
    // 3. 将地图控制器的视图，添加到当前视图
    [self.view addSubview:vc.view];
    vc.view.frame = self.view.bounds;
    
    // 设置运动轨迹模型
    vc.sportTracking = [[XRSportTracking alloc] initWithType:_sportType];
    
    // 4. 完成控制器的添加
    [vc didMoveToParentViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
