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
    
    _np = [[NodePlayer alloc] initWithPremium:@"W4hUJuvX60T3yOfFkFpE3OGMVfiDgfBfaZCQ0SJ5V0pi95FnbR+MK5VdjeldTpMC5VdNH2cQnQUzkrR35+PNMA=="];
    [_np setPlayerView:self.view];
    
    NSString *inputUrl = [_defaults objectForKey:@"input_url"];
    int b = (int) [_defaults integerForKey:@"play_buffertime"];
    int m = (int) [_defaults integerForKey:@"play_maxbuffertime"];
    int s = (int) [_defaults integerForKey:@"video_scale_mode"];
    BOOL h = [_defaults boolForKey:@"play_hw"];
    [_np setInputUrl:inputUrl];
    [_np setBufferTime:b];
    [_np setMaxBufferTime:m];
    [_np setContentMode:s];
    [_np setHwEnable:h];
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
