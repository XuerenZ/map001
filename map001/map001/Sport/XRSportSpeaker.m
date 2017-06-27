//
//  XRSportSpeaker.m
//  map001
//
//  Created by acer on 17/6/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "XRSportSpeaker.h"
#import <AVFoundation/AVFoundation.h>
#import "NSString+HMNumberConvert.h"
@implementation XRSportSpeaker
{
    // 运动类型字符串
    NSString *_typeString;
    /// 上次播报距离
    double _lastReportDistance;
    /// 声音字典
    NSDictionary *_voiceDictionary;
    /// 语音播放器
    AVPlayer *_voicePlayer;
    /// 语音键值数组
    NSMutableArray *_voiceArray;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        // 单位距离的初始值，不适合太短
        _unitDistance = 0.1;
        
        _lastReportDistance = 0;
        
        // 1. 加载 JSON 生成字典
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"voice.json" withExtension:nil subdirectory:@"voice.bundle"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        // 反序列化
        _voiceDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        
        // 2. 实例化语音播放器
        _voicePlayer = [AVPlayer new];
        
        // 3. 注册通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playItemDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
        
        // 4. 允许多个应用程序的音乐同时播放！- 一旦应用程序退出到后台，应该同样能够播放音乐！
        // 音乐会话分类 - 专门解决多个音乐播放设置的，而且代码相对固定！
        // 因为在 iOS 中，默认的音乐播放是`独占`的！
        // AVAudioSessionCategoryOptionMixWithOthers - 允许和其他的音乐一起播放，但是音量相同
        // AVAudioSessionCategoryOptionDuckOthers - 允许和其他音乐一起播放，会降低其他音乐的音量，但是，无法恢复音量
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionDuckOthers error:NULL];
        
        // - 在开始播放语音之前，激活音乐会话，表示之前设置的分类有效
        // - 在所有的语音播放结束之后，禁用音乐会话，表示之前设置的分类暂时无效
        [[AVAudioSession sharedInstance] setActive:YES error:NULL];
    }
    return self;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/**
 开始指定类型的运动
 
 @param type 运动类型
 */
- (void)startSportWithType:(XRSportType)type {
    
    switch (type) {
        case XRSportTypeBike:
            _typeString = @"骑行";
            break;
        case XRSportTypeRun:
            _typeString = @"跑步";
            break;
        case XRSportTypeWalk:
            _typeString = @"走路";
            break;
    }
    
    NSString *text = [@"开始" stringByAppendingString:_typeString];
    
    [self playVoiceWithText:text];
}
/**
 播放条目结束监听方法
 
 @param n 通知
 */
- (void)playItemDidEnd:(NSNotification *)n {
    //    NSLog(@"播放已经完成");
    
    // 继续播放数组中的第 0 项
    [self playFirstVoice];
}
#pragma mark - 语音播报方法
/**
 播放文本内容的语音
 
 @param text 文本内容
 */
- (void)playVoiceWithText:(NSString *)text {
    NSLog(@"播放语音内容 - %@", text);
    
    // 1. 拆分字符串
    NSArray *array = [text componentsSeparatedByString:@" "];
    
    // 2. 使用语音播报数组记录字符串
    _voiceArray = [NSMutableArray arrayWithArray:array];
    
    // 3. 激活音乐会话 - 之前设置的分类有效
    [[AVAudioSession sharedInstance] setActive:YES error:NULL];
    
    // 4. 播放第一个音频
    [self playFirstVoice];
}
/**
 播放数组中第一项语音
 */
- (void)playFirstVoice {
    
    // 0. 判断数组中是否有内容
    if (_voiceArray.count == 0) {
        NSLog(@"没有需要播放的语音");
        
        // 禁用音乐会话 - 恢复其他音乐的音量
        [[AVAudioSession sharedInstance] setActive:NO error:NULL];
        
        return;
    }
    
    // 1. 获取数组中的第一项
    NSString *key = _voiceArray.firstObject;
    
    // 2. 移除数组中的第一项
    [_voiceArray removeObjectAtIndex:0];
    
    // 3. 使用 key 从字典中查找对应的 mp3 文件名
    NSString *mp3 = _voiceDictionary[key];
    
    // 4. 准备 URL
    NSURL *url = [[NSBundle mainBundle] URLForResource:mp3 withExtension:nil subdirectory:@"voice.bundle"];
    
    // 5. 判断 URL 是否存在
    if (url == nil) {
        [self playFirstVoice];
        
        NSLog(@"%@ 对应的 mp3 没有找到", key);
        return;
    }
    
    // 6. 语音播放条目
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
    
    // 播放语音条目 - 替换当前播放条目
    [_voicePlayer replaceCurrentItemWithPlayerItem:item];
    
    // 开始播放
    [_voicePlayer play];
}
/**
 整单位距离的播报
 
 @param distance 距离
 @param time     时间
 @param speed    速度
 */
- (void)reportWithDistance:(double)distance time:(NSTimeInterval)time speed:(double)speed {
    
    // 判断总距离和单位距离+末次报告距离之间的关系
    if (distance < _unitDistance + _lastReportDistance) {
        return;
    }
    // 记录上次播报距离
    _lastReportDistance = (NSInteger)(distance / _unitDistance) * _unitDistance;
    
    NSString *fmt = @"你已经 %@ %@ 公里 用时 %@ 平均速度 %@ 公里每小时 太棒了";
    
    NSString *distanceStr = [NSString hm_numberStringWithNumber:distance hasDotNumber:YES];
    NSString *timeStr = [NSString hm_timeStringWithTimeValue:time];
    NSString *speedStr = [NSString hm_numberStringWithNumber:speed hasDotNumber:YES];
    
    NSString *text = [NSString stringWithFormat:fmt, _typeString, distanceStr, timeStr, speedStr];
    
    [self playVoiceWithText:text];
}
/**
 修改运动状态
 
 @param state 运动状态
 */
- (void)sportStateChanged:(XRSportState)state {
    
    NSString *text;
    
    switch (state) {
        case XRSportStatePause:
            text = @"运动已暂停";
            break;
        case XRSportStateContinue:
            text = @"运动已恢复";
            break;
        case XRSportStateFinish:
            text = @"放松一下吧";
            break;
    }
    
    [self playVoiceWithText:text];
}
@end
