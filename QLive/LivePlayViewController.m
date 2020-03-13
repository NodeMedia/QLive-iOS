//
//  LivePlayViewController.m
//  QLive
//
//  Created by Mingliang Chen on 2017/11/24.
//  Copyright © 2017年 Mingliang Chen. All rights reserved.
//

#import "LivePlayViewController.h"
#import <NodeMediaClient/NodeMediaClient.h>

@interface LivePlayViewController ()
@property (nonatomic, strong) NodePlayer *np;
@property (nonatomic, strong) NSUserDefaults *defaults ;
@end

@implementation LivePlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
    _defaults = [NSUserDefaults standardUserDefaults];
    
    _np = [[NodePlayer alloc] initWithLicense:@"ZjJhNTIzODAtNGU0ZDUzMjEtY24ubm9kZW1lZGlh-Tz/mF2xTaPRuHwcs5iWTsF19k38qZ4Dx+OFb0V+KtFUnXexWLD5d4bs2YczQaZsrrIhKakTyrIVp8zV4bHtf37wenADt+OekVR3BP7+eKzCovGk47mPYqxXH0ZPBOxNub6AZC/J9HupKgXzEzwDppIw+vM5Pb1mSH9qJdX6Ui2jF634xYbKWP5b7eWpX2qw1h5OZZwLIh9OO0rKPxS3VPHKoZ6HaXyWgYgzBj9nlN7gOHEbJM5QNqGQMq5l5sWbpiv7BhZRoUc+N2QiOCQj5TjboKiV4IkVuwIwBU0D4Z4GWrbvngl64Y09nZn3ZMxLB2GK+0nxSjsgkz4w4GQSzpQ=="];
    [_np setPlayerView:self.view];
    
    NSString *inputUrl = [_defaults objectForKey:@"input_url"];
    int b = (int) [_defaults integerForKey:@"play_buffertime"];
    int m = (int) [_defaults integerForKey:@"play_maxbuffertime"];
    int s = (int) [_defaults integerForKey:@"video_scale_mode"];
    BOOL h = [_defaults boolForKey:@"play_hw"];
    NSString *cryptoKey = [_defaults objectForKey:@"play_cryptokey"];
    [_np setInputUrl:inputUrl];
    [_np setBufferTime:b];
    [_np setMaxBufferTime:m];
    [_np setContentMode:s];
    [_np setHwEnable:h];
    [_np setCryptoKey:cryptoKey];
    [_np start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_np stop];
}

- (IBAction)closeAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
