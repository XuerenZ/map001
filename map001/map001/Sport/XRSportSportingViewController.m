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
@property (nonatomic, strong) XRSportMapViewController *mapViewController;
@end

@implementation XRSportSportingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    [self setupMapViewController];
}
/**
 设置地图视图控制器
 */
- (void)setupMapViewController {
    
    // 1. 通过 storyboard 实例化地图控制器
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"XRSportSporting" bundle:nil];
    _mapViewController = [sb instantiateViewControllerWithIdentifier:@"sportMapViewController"];

    // 设置运动轨迹模型
    _mapViewController.sportTracking = [[XRSportTracking alloc] initWithType:_sportType state:XRSportStateContinue];

}
#pragma mark - 监听方法
- (IBAction)showMapViewController {
    // 模态展现
    [self presentViewController:_mapViewController animated:YES completion:nil];
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
