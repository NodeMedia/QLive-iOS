//
//  AboutSettingsViewController.m
//  QLive
//
//  Created by Mingliang Chen on 2017/12/5.
//  Copyright © 2017年 Mingliang Chen. All rights reserved.
//

#import "AboutSettingsViewController.h"

@implementation AboutSettingsViewController
    
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setFile:@"About"];
    [self setTitle:NSLocalizedString(@"About","Push Title")];
    [self setDelegate:self];
    [self setShowCreditsFooter:NO];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
    
- (CGFloat)settingsViewController:(id<IASKViewController>)settingsViewController
                        tableView:(UITableView *)tableView
        heightForHeaderForSection:(NSInteger)section {
    NSString* key = [settingsViewController.settingsReader keyForSection:section];
    if ([key isEqualToString:@"QLiveLogo"]) {
        CGFloat a= [UIImage imageNamed:@"logo.png"].size.height + 25;
        return a;
    }
    return 0;
}
    
- (UIView *)settingsViewController:(id<IASKViewController>)settingsViewController
                         tableView:(UITableView *)tableView
           viewForHeaderForSection:(NSInteger)section {
    NSString* key = [settingsViewController.settingsReader keyForSection:section];
    if ([key isEqualToString:@"QLiveLogo"]) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]];
        imageView.contentMode = UIViewContentModeCenter;
        return imageView;
    }
    return nil;
}
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
