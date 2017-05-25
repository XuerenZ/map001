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
/**
 运动地图控制器
 */
@property (nonatomic, weak) XRSportMapViewController *mapViewController;
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
    
    // 1. 获取地图控制器
    for (UIViewController *child in self.childViewControllers) {
        if ([child isKindOfClass:[XRSportMapViewController class]]) {
            _mapViewController = (XRSportMapViewController *)child;
            
            break;
        }
    }

    // 设置运动轨迹模型
    _mapViewController.sportTracking = [[XRSportTracking alloc] initWithType:_sportType state:XRSportStateContinue];

}
- (IBAction)changeSportState:(UIButton *)sender {
    
    // 修改地图控制器的运动状态
    _mapViewController.sportTracking.sportState = sender.tag;
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
