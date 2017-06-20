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
#import "CZAdditions.h"
@interface XRSportSportingViewController ()
/**
 运动地图控制器
 */
@property (nonatomic, strong) XRSportMapViewController *mapViewController;


/**
 距离标签
 */
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
/**
 时间标签
 */
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
/**
 速度标签
 */
@property (weak, nonatomic) IBOutlet UILabel *speedLabel;

@property (weak, nonatomic) IBOutlet UIView *controlPanelView;

/**
 暂停按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;

/**
 继续按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *continueButton;

/**
 暂停按钮的中心的X约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pauseButtonCenterXCons;
/**
 继续按钮的中心的X约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *continueButtonCenterXCons;
/**
 结束按钮的中心的X约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *finishButtonCenterXCons;
@end

@implementation XRSportSportingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupMapViewController];
    [self setupBackgroundLayer];
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
/**
 设置背景图层
 */
- (void)setupBackgroundLayer {
    
    // `线性`渐变图层
    CAGradientLayer *layer = [CAGradientLayer layer];
    
    // layer 是通过 bounds 和 position 来指定位置的
    layer.bounds = self.view.bounds;
    layer.position = self.view.center;
    
    // 测试设置背景颜色
    // layer.backgroundColor = [UIColor redColor].CGColor;
    // 1> 设置渐变颜色数组
    CGColorRef color1 = [UIColor cz_colorWithHex:0x0e1428].CGColor;
    CGColorRef color2 = [UIColor cz_colorWithHex:0x406479].CGColor;
    CGColorRef color3 = [UIColor cz_colorWithHex:0x406578].CGColor;
    
    // NSArray 包含的对象是 OC 的类型，如果要放 CG 类型，应该做桥接
    layer.colors = @[(__bridge UIColor *)color1, (__bridge UIColor *)color2, (__bridge UIColor *)color3];
    
    // 2> 设置颜色的位置数组
    layer.locations = @[@0, @0.6, @1];
    
    // 将图层插入到最底部
    [self.view.layer insertSublayer:layer atIndex:0];
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
