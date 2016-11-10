//
//  CustomTabBarController.m
//  MeiLiYiChuApp
//
//  Created by mac on 16/9/7.
//  Copyright © 2016年 刘文海. All rights reserved.
//

#import "CustomTabBarController.h"

@interface CustomTabBarController ()
{
    UIButton * _isSelectBtn;
    
}
@end

@implementation CustomTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray * array = @[@"首页",@"9块9",@"精选",@"购物车",@"我的"];
    NSArray * array_Normal = @[@"首页_Normal",@"9块9_Normal",@"精选_Normal",@"购物车_Normal",@"我的_Normal"];
    
    UIView * view = [[UIView alloc]init];
    view.frame = CGRectMake(0, HEIGHT-49, WIDTH, 49);
    view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [self.view addSubview:view];
    
    for (int i = 0; i<5; i++)
    {
        UIButton * button = [[UIButton alloc]init];
        button.frame = CGRectMake(20+i*(WIDTH-40)/9*2, 2, self.tabBar.bounds.size.height-22, self.tabBar.bounds.size.height-4);
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",array[i]]] forState:UIControlStateSelected];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",array_Normal[i]]] forState:UIControlStateNormal];
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:button];
        if (button.tag == 0)
        {
            button.selected = YES;
            _isSelectBtn = button;
        }
    }
    //细线
    UILabel * lable = [[UILabel alloc]init];
    lable.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    lable.frame = CGRectMake(0, 0, WIDTH, 1);
    [view addSubview:lable];
    
    
}

- (void)buttonClick:(UIButton *)button
{
    if (_isSelectBtn.tag != button.tag) {
        _isSelectBtn.selected = NO;

    }


    self.selectedIndex = button.tag;
    button.selected = YES;
    _isSelectBtn = button;

    

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
