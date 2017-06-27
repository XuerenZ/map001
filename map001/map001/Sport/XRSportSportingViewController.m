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
#import "XRSportSpeaker.h"
#import "XRSportCameraViewController.h"
@interface XRSportSportingViewController ()<XRSportMapViewControllerDelegate>
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
{
    /// 语音播报器
    XRSportSpeaker *_sportSpeaker;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 1. 实例化语音播报器
    _sportSpeaker = [XRSportSpeaker new];
    
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
    // 3. 设置代理
    _mapViewController.delegate = self;
    
    // 4. 开始运动的语音播报
    [_sportSpeaker startSportWithType:_sportType];
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

#pragma mark - HMSportMapViewControllerDelegate
- (void)sportMapViewControllerDidChangedData:(XRSportMapViewController *)vc {
    
    // 获取地图控制器中的轨迹追踪模型
    XRSportTracking *model = vc.sportTracking;
    
    // 0. 更新 UI
    _distanceLabel.text = [NSString stringWithFormat:@"%0.2f", model.totalDistance];
    _timeLabel.text = model.totalTimeStr;
    _speedLabel.text = [NSString stringWithFormat:@"%0.2f", model.avgSpeed];
    
    // 根据运动状态的变化模拟状态按钮点击操作
    // 1. 当用户暂停运动，同时暂停按钮可见，模拟点击暂停按钮，隐藏暂停按钮
    if (model.sportState == XRSportStatePause && _pauseButton.alpha == 1) {
        // 点击暂停按钮
        [self changeSportState:_pauseButton];
    }
    
    // 2. 当用户继续运行，同时暂停按钮不可见，模拟点击继续按钮，显示暂停按钮
    if (model.sportState == XRSportStateContinue && _pauseButton.alpha == 0) {
        [self changeSportState:_continueButton];
    }
    
    // 3. 播放距离提示语音
    [_sportSpeaker reportWithDistance:model.totalDistance time:model.totalTime speed:model.avgSpeed];
}

#pragma mark - 监听方法
- (IBAction)showCameraViewController {
    
    XRSportCameraViewController *vc = [XRSportCameraViewController new];
    
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)showMapViewController {
    // 模态展现
    [self presentViewController:_mapViewController animated:YES completion:nil];
}

- (IBAction)changeSportState:(UIButton *)sender {
    
    // 从按钮的 tag 获取运动状态
    XRSportState state = sender.tag;
    
    // 修改地图控制器的运动状态
    _mapViewController.sportTracking.sportState = state;
    
    // 1. 根据按钮的 tag 来决定按钮的偏移量
    CGFloat offset = (state == XRSportStatePause) ? -80 : 80;
    
    // 2. 设置按钮的约束值
    _pauseButtonCenterXCons.constant += offset;
    _continueButtonCenterXCons.constant += offset;
    _finishButtonCenterXCons.constant -= offset;
    
    _controlPanelView.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.25 animations:^{
        // 3. 隐藏暂停按钮
        _pauseButton.alpha = (sender != _pauseButton);
        
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        _controlPanelView.userInteractionEnabled = YES;
    }];
    
    // 4. 播放语音 -> 切换运动状态
    [_sportSpeaker sportStateChanged:state];

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
