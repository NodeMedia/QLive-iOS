//
//  AppDelegate.m
//  QLive
//
//  Created by Mingliang Chen on 2017/11/23.
//  Copyright © 2017年 Mingliang Chen. All rights reserved.
//

#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // Load the default values for the user defaults
    NSString *settingsBundle = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"bundle"];

    NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:[settingsBundle stringByAppendingPathComponent:@"Push.plist"]];
    NSArray *preferences = [settings objectForKey:@"PreferenceSpecifiers"];

    NSMutableDictionary *defaultsToRegister = [[NSMutableDictionary alloc] initWithCapacity:[preferences count]];
    for(NSDictionary *prefSpecification in preferences)
    {
        NSString *key = [prefSpecification objectForKey:@"Key"];
        NSObject *obj = [prefSpecification objectForKey:@"DefaultValue"];
        if(key && obj)
        {
            [defaultsToRegister setObject:[prefSpecification objectForKey:@"DefaultValue"] forKey:key];
        }
    }
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultsToRegister];
    
    settings = [NSDictionary dictionaryWithContentsOfFile:[settingsBundle stringByAppendingPathComponent:@"Play.plist"]];
    preferences = [settings objectForKey:@"PreferenceSpecifiers"];
    
    defaultsToRegister = [[NSMutableDictionary alloc] initWithCapacity:[preferences count]];
    for(NSDictionary *prefSpecification in preferences)
    {
        NSString *key = [prefSpecification objectForKey:@"Key"];
        NSObject *obj = [prefSpecification objectForKey:@"DefaultValue"];
        if(key && obj)
        {
            [defaultsToRegister setObject:[prefSpecification objectForKey:@"DefaultValue"] forKey:key];
        }
    }
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultsToRegister];
    
#if !TARGET_OS_SIMULATOR
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    //1.只进行音视频播放
    //        [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    //2.只进行音视频发布
    //    [session setCategory:AVAudioSessionCategoryRecord error:nil];
    
    //3.只进行音视频发布 并允许蓝牙耳机麦克风输入
    //    [session setCategory:AVAudioSessionCategoryRecord withOptions:AVAudioSessionCategoryOptionAllowBluetooth error:nil];
    
    //4.同时进行音视频直播播放和发布
    [session setCategory:AVAudioSessionCategoryPlayAndRecord withOptions:AVAudioSessionCategoryOptionDefaultToSpeaker error:nil];
    
    //5.同时进行音视频播放和发布 并允许蓝牙耳机输入输出
    //        [session setCategory:AVAudioSessionCategoryPlayAndRecord withOptions:AVAudioSessionCategoryOptionDefaultToSpeaker | AVAudioSessionCategoryOptionAllowBluetooth error:nil];
    
    //6.进行音视频发布时,需要混音后台app播放的音乐
    //    [session setCategory:AVAudioSessionCategoryPlayAndRecord withOptions:AVAudioSessionCategoryOptionDefaultToSpeaker| AVAudioSessionCategoryOptionMixWithOthers error:nil];
#endif
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
#if !TARGET_OS_SIMULATOR
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:NO error:nil];
#endif
}


@end
