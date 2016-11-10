//
//  ViewController.m
//  MeiLiYiChuApp
//
//  Created by mac on 16/9/7.
//  Copyright © 2016年 刘文海. All rights reserved.
//

#import "ViewController.h"
#import "CustomTabBarController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UINavigationController * nav1 = [[UINavigationController alloc]init];
    SouYeVC * souye = [[SouYeVC alloc]init];
    [nav1 pushViewController:souye animated:NO];
    
    UINavigationController * nav2 = [[UINavigationController alloc]init];
    NineYuanVC * nine = [[NineYuanVC alloc]init];
    [nav2 pushViewController:nine animated:NO];
    
    UINavigationController * nav3 = [[UINavigationController alloc]init];
    JingXuanVC * jingxuan = [[JingXuanVC alloc]init];
    [nav3 pushViewController:jingxuan animated:NO];
    
    UINavigationController * nav4 = [[UINavigationController alloc]init];
    GouWuCheVC * gouwuche = [[GouWuCheVC alloc]init];
    [nav4 pushViewController:gouwuche animated:NO];
    
    UINavigationController * nav5 = [[UINavigationController alloc]init];
    WoVC * wo = [[WoVC alloc]init];
    [nav5 pushViewController:wo animated:NO];
    

    CustomTabBarController * tabVC = [[CustomTabBarController alloc]init];
    tabVC.viewControllers = @[nav1,nav2,nav3,nav4,nav5];
    tabVC.tabBar.hidden = YES;
    
    UIWindow * window = [[UIApplication sharedApplication].delegate window];
    window.rootViewController = tabVC;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
