//
//  JingXuan_taobao.m
//  MeiLiYiChuApp
//
//  Created by mac on 16/9/8.
//  Copyright © 2016年 刘文海. All rights reserved.
//

#import "JingXuan_taobao.h"

@interface JingXuan_taobao ()

@end

@implementation JingXuan_taobao

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationController.navigationBar.hidden = YES;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"导航条返回按钮_Normal"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    UIWebView * webView = [[UIWebView alloc]init];
    webView.frame = CGRectMake(0, 64, WIDTH, HEIGHT-64);
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlString]]];
    NSLog(@"这是个测试的输出-url --- %@",_urlString);
    
    [self.view addSubview:webView];
    


}

- (void)back
{
    UIView * view = self.view.window.rootViewController.view.subviews.lastObject;
    //重新显示tabBar
    [UIView animateWithDuration:0.1 animations:^{
        view.frame = CGRectMake(0, view.frame.origin.y, view.bounds.size.width, view.bounds.size.height);
    }];
    [self.navigationController popViewControllerAnimated:YES];

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
