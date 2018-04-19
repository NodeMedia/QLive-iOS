//
//  PushSettingsViewController.m
//  QLive
//
//  Created by Mingliang Chen on 2017/11/23.
//  Copyright © 2017年 Mingliang Chen. All rights reserved.
//

#import "PushSettingsViewController.h"
#import "LivePushViewController.h"

@interface PushSettingsViewController ()<IASKSettingsDelegate>

@end

@implementation PushSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:NSLocalizedString(@"Push","Push Title")];
    
    [self setFile:@"Push"];
    [self setDelegate:self];
    [self setShowCreditsFooter:NO];
    
//    [self setNeverShowPrivacySettings:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)settingsViewController:(IASKAppSettingsViewController*)sender buttonTappedForSpecifier:(IASKSpecifier*)specifier {
    LivePushViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"livePushVC"];
    [self presentViewController:controller animated:YES completion:nil];
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


