//
//  LivePushViewController.m
//  QLive
//
//  Created by Mingliang Chen on 2017/11/23.
//  Copyright © 2017年 Mingliang Chen. All rights reserved.
//

#import "LivePushViewController.h"
#import <NodeMediaClient/NodeMediaClient.h>

@interface LivePushViewController ()<NodePublisherDelegate>
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (weak, nonatomic) IBOutlet UIButton *switchBtn;
@property (weak, nonatomic) IBOutlet UIButton *flashBtn;
@property (nonatomic,strong) NodePublisher *np;
@property (nonatomic, strong) NSUserDefaults *defaults;
@property (nonatomic) BOOL isStart;
@property (nonatomic) BOOL isFlashEnable;
@end

@implementation LivePushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
    _defaults = [NSUserDefaults standardUserDefaults];
    
    _np = [[NodePublisher alloc] initWithLicense:@"ZjJhNTIzODAtNGU0ZDUzMjEtY24ubm9kZW1lZGlh-Tz/mF2xTaPRuHwcs5iWTsF19k38qZ4Dx+OFb0V+KtFUnXexWLD5d4bs2YczQaZsrrIhKakTyrIVp8zV4bHtf37wenADt+OekVR3BP7+eKzCovGk47mPYqxXH0ZPBOxNub6AZC/J9HupKgXzEzwDppIw+vM5Pb1mSH9qJdX6Ui2jF634xYbKWP5b7eWpX2qw1h5OZZwLIh9OO0rKPxS3VPHKoZ6HaXyWgYgzBj9nlN7gOHEbJM5QNqGQMq5l5sWbpiv7BhZRoUc+N2QiOCQj5TjboKiV4IkVuwIwBU0D4Z4GWrbvngl64Y09nZn3ZMxLB2GK+0nxSjsgkz4w4GQSzpQ=="];
    [_np setNodePublisherDelegate:self];
    [_np setOutputUrl:[_defaults objectForKey:@"output_url"]];
    [_np setCameraPreview:self.view cameraId:(int)[_defaults integerForKey:@"camera_postion"] frontMirror:[_defaults boolForKey:@"camera_front_mirror"] ];
    int ab = (int)[_defaults integerForKey:@"audio_bitrate"];
    int ap = (int)[_defaults integerForKey:@"audio_profile"];
    int as = (int)[_defaults integerForKey:@"audio_samplerate"];
    [_np setAudioParamBitrate:ab profile:ap sampleRate:as];
    
    int r = [[_defaults objectForKey:@"video_resolution"] intValue];
    int f = [[_defaults objectForKey:@"video_fps"] intValue];
    int b = [[_defaults objectForKey:@"video_bitrate"] intValue];
    int k = [[_defaults objectForKey:@"vodeo_keyframe_interval"] intValue];
    int p = [[_defaults objectForKey:@"video_profile"] intValue];
    int s = [[_defaults objectForKey:@"smooth_skin_level"] intValue];
    BOOL m = [_defaults boolForKey:@"video_front_mirror"];
    BOOL d = [_defaults boolForKey:@"push_denoise"];
    BOOL h = [_defaults boolForKey:@"push_hw"];
    NSString *cryptoKey = [_defaults objectForKey:@"push_cryptokey"];
    [_np setVideoParamPreset:r fps:(int)f bitrate:(int)b profile:p frontMirror:m];
    [_np setKeyFrameInterval:k];
    [_np setBeautyLevel:s];
    [_np setDenoiseEnable:d];
    [_np setHwEnable:h];
    [_np setCryptoKey:cryptoKey];
    [_np startPreview];
    _isStart = NO;
    _isFlashEnable = NO;
}
    
- (void)viewWillAppear:(BOOL)animated {
    
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [UIView setAnimationsEnabled:NO]; // disable animations temporarily
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [UIView setAnimationsEnabled:NO]; // rotation finished, re-enable them
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
     dispatch_async(dispatch_get_main_queue(), ^{
         [_np stopPreview];
         [_np stop];
     });
}

//Interface的方向是否会跟随设备方向自动旋转，如果返回NO,后两个方法不会再调用
- (BOOL)shouldAutorotate {
    return YES;
}

//返回直接支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    UIInterfaceOrientationMask mask;
    switch ([[_defaults objectForKey:@"video_orientation"]  intValue]) {
        case 0:
        default:
            mask = UIInterfaceOrientationMaskPortrait;
            break;
        case 1:
            mask = UIInterfaceOrientationMaskLandscapeRight;
            break;
        case 2:
            mask = UIInterfaceOrientationMaskLandscapeLeft;
            break;

    }
    return mask;
}
//返回最优先显示的屏幕方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    UIInterfaceOrientation ori;
    switch ([[_defaults objectForKey:@"video_orientation"]  intValue]) {
        case 0:
        default:
            ori = UIInterfaceOrientationPortrait;
            break;
        case 1:
            ori = UIInterfaceOrientationLandscapeRight;
            break;
        case 2:
            ori = UIInterfaceOrientationLandscapeLeft;
            break;
            
    }
    return ori;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (IBAction)startAction:(id)sender {
    
    if(_isStart) {
         _isStart = NO;
        [_np stop];
        [_startBtn setTitle:NSLocalizedString(@"Start Push","Start Push Button Title") forState:UIControlStateNormal];
    } else {
        [_startBtn setTitle:NSLocalizedString(@"Connection","Connection Button Title") forState:UIControlStateNormal];
        [_np start];
        _isStart = YES;
    }
}

- (IBAction)closeAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)switchAction:(id)sender {
    [_np switchCamera];
    [_np setFlashEnable:NO];
    [_flashBtn setImage:[UIImage imageNamed:@"ic_flash_off"] forState:UIControlStateNormal];
}
    
- (IBAction)flashAction:(id)sender {
    _np.flashEnable = !_isFlashEnable;
    
    if(_np.flashEnable) {
        //闪光灯开启
        [sender setImage:[UIImage imageNamed:@"ic_flash_on"] forState:UIControlStateNormal];
        _isFlashEnable = YES;
    }else {
        //闪光灯关闭
        [sender setImage:[UIImage imageNamed:@"ic_flash_off"] forState:UIControlStateNormal];
        _isFlashEnable = NO;
    }
}
- (void) onEventCallback:(id)sender event:(int)event msg:(NSString *)msg {
    NSLog(@"onEventCallback:%d %@",event,msg);
    dispatch_async(dispatch_get_main_queue(), ^{
        switch (event) {
            case 2000:
                //发布流开始连接
                break;
            case 2001:
                //发布流连接成功 开始发布
                _startBtn.backgroundColor = [UIColor colorWithRed:0.98 green:0.29 blue:0.23 alpha:0.5];
                [_startBtn setTitle:NSLocalizedString(@"Stop Push","Stop Push Button Title") forState:UIControlStateNormal];
                _isStart = YES;
                break;
            case 2002:
                //发布流连接失败
                break;
            case 2003:
                //发布开始重连
                break;
            case 2004:
                //停止发布
                _startBtn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
                _startBtn.selected = NO;
                _isStart = NO;
                break;
            case 2005:
                //发布中遇到网络异常
                break;
            case 2100:
                //发布端网络阻塞，已缓冲了2秒的数据在队列中
                break;
            case 2101:
                //发布端网络恢复畅通
                break;
            case 2104:
                //网络阻塞严重,无法继续推流,断开连接
                break;
            default:
                break;
        }
    });
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
