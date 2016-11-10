//
//  GouWuCheVC.m
//  MeiLiYiChuApp
//
//  Created by mac on 16/9/7.
//  Copyright © 2016年 刘文海. All rights reserved.
//

#import "GouWuCheVC.h"

@interface GouWuCheVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView * tableView;
@end

@implementation GouWuCheVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"购物车";
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor colorWithWhite:0.5 alpha:1]};
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];


}

#pragma mark ************* 懒加载
- (UITableView * )tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc]init];
        _tableView.frame = CGRectMake(0, 64, WIDTH, HEIGHT-64-49);
        _tableView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 50;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
        
    }
    return _tableView;
}

#pragma mark ************* tableview协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    else
    {
        return 1;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        
    }
    
    if (indexPath.section == 0)
    {
        cell.imageView.image = [UIImage imageNamed:@"淘宝Icon"];
        cell.textLabel.text = @"淘宝购物车商品";
        cell.textLabel.textColor = [UIColor colorWithRed:247/255.0 green:45/255.0 blue:0/255.0 alpha:1];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.detailTextLabel.text = @"找不到的商品在这里";
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        cell.detailTextLabel.textColor = [UIColor lightGrayColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.section == 1)
    {
        if (indexPath.row == 0)
        {
            CGFloat height = HEIGHT-64-49-30-50;
            
            //表的背景
            UIView * view = [[UIView alloc]initWithFrame:cell.bounds];
            
            UIImageView * bgImg = [[UIImageView alloc]init];
            bgImg.image = [UIImage imageNamed:@"购物车bg"];
            bgImg.bounds = CGRectMake(0, 0, 120, 120);
            bgImg.center = CGPointMake(WIDTH/2, height/2-80);
            [view addSubview:bgImg];
            
            UILabel * bgLab = [[UILabel alloc]init];
            bgLab.bounds = CGRectMake(0, 0, 200, 30);
            bgLab.center = CGPointMake(WIDTH/2, height/2);
            bgLab.text = @"登录才可以查看购物车哦~";
            bgLab.textColor = [UIColor lightGrayColor];
            bgLab.textAlignment = NSTextAlignmentCenter;
            bgLab.font = [UIFont systemFontOfSize:14];
            [view addSubview:bgLab];
            
            cell.backgroundView = view;
            cell.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        }
    }
    
    return cell;
}

//自定义区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView * header = (UITableViewHeaderFooterView *)[tableView dequeueReusableCellWithIdentifier:@"header"];
    if (!header)
    {
        header = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"header"];
        
    }
    
    if (section == 1)
    {
        UILabel * lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 30)];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.textColor = [UIColor grayColor];
        lable.text = @"美丽衣橱商品";
        lable.font = [UIFont systemFontOfSize:13];
        lable.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        [header addSubview:lable];
        
        UILabel * line1 = [[UILabel alloc]init];
        line1.backgroundColor = [UIColor colorWithWhite:0.85 alpha:1];
        line1.frame = CGRectMake(WIDTH/5-5, 14, WIDTH/5, 1);
        [header addSubview:line1];
        
        UILabel * line2 = [[UILabel alloc]init];
        line2.backgroundColor = [UIColor colorWithWhite:0.85 alpha:1];
        line2.frame = CGRectMake(WIDTH/5*3+5, 14, WIDTH/5, 1);
        [header addSubview:line2];

    }
    
    return header;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1 )
    {
        if (indexPath.row == 0)
        {
            tableView.rowHeight = HEIGHT-64-49-30-50;
        }
        
    }
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1)
    {
        return 30;
        
    }
    return 0;
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
