//
//  WoVC.m
//  MeiLiYiChuApp
//
//  Created by mac on 16/9/7.
//  Copyright © 2016年 刘文海. All rights reserved.
//

#import "WoVC.h"
#import "MyCell.h"

@interface WoVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView * tableView;

@end

@implementation WoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.hidden = YES;
   
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];

    [self shuaXin];
    
}

#pragma mark ************* 刷新
- (void)shuaXin
{
    //刷新
    {
        //下拉刷新
        MJRefreshGifHeader * header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(downLoadNewData)];
        
        [header setTitle:@"刷新成功" forState:MJRefreshStateIdle];//普通闲置状态
        [header setTitle:@"松开刷新" forState:MJRefreshStatePulling];//松开刷新
        [header setTitle:@"正在刷新" forState:MJRefreshStateRefreshing];//正在刷新
        
        //设置字体
        header.stateLabel.font = [UIFont systemFontOfSize:13];
        header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:13];
        
        //设置字体颜色
        header.stateLabel.textColor = [UIColor grayColor];
        header.lastUpdatedTimeLabel.textColor = [UIColor grayColor];
        
        //        header.arrowView.image = [UIImage imageNamed:@"刷新图片"];
        [header setImages:@[[UIImage imageNamed:@"刷新图片"]] forState:MJRefreshStateIdle];
        [header setImages:@[[UIImage imageNamed:@"刷新图片"]] forState:MJRefreshStatePulling];
        [header setImages:@[[UIImage imageNamed:@"刷新图片"]] forState:MJRefreshStateWillRefresh];
        //开始刷新
        [header beginRefreshing];
        
        //设置刷新控件
        self.tableView.mj_header = header;
        
        //上拉加载
        MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upLoadData )];
        
        [footer setTitle:@"上拉进行刷新" forState:MJRefreshStateIdle];//普通闲置状态
        [footer setTitle:@"松开刷新" forState:MJRefreshStatePulling];//松开刷新
        [footer setTitle:@"正在刷新" forState:MJRefreshStateRefreshing];//正在刷新
        
        footer.stateLabel.font = [UIFont systemFontOfSize:13];
        footer.stateLabel.textColor = [UIColor grayColor];
        //禁止自动加载
        footer.automaticallyRefresh = NO;
        
        footer.refreshingTitleHidden = YES;
        //开始刷新
        //        [footer beginRefreshing];
        
        //设置刷新控件
        self.tableView.mj_footer = footer;
    }
  
}

//下拉刷新
- (void)downLoadNewData
{
    NSLog(@"下拉刷新");
    [self.tableView.mj_header endRefreshing];
}

//上拉加载
- (void)upLoadData
{
    NSLog(@"上拉加载");
    [self.tableView.mj_footer endRefreshing];

}

#pragma mark ************* 懒加载
- (UITableView * )tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-49) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 50;
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self.view addSubview:_tableView];
        
        [_tableView registerClass:[MyCell class] forCellReuseIdentifier:@"cell"];
        
        //表头
        UIView * view = [[UIView alloc]init];
        view.frame = CGRectMake(0, 0, WIDTH, 120);
        view.backgroundColor = [UIColor clearColor];
        
        UIImageView * imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(0, -WIDTH+120, WIDTH, WIDTH);
        imageView.image = [UIImage imageNamed:@"我页面表头背景"];
        [view addSubview:imageView];
        
        UIButton * button = [[UIButton alloc]init];
        button.bounds = CGRectMake(0, 0, WIDTH/3, 30);
        button.center = CGPointMake(WIDTH/2, 85);
        button.backgroundColor = [UIColor colorWithRed:186/255.0 green:0/255.0 blue:0/255.0 alpha:1];
        [button setTitle:@"登录" forState:UIControlStateNormal];
        button.titleLabel.textColor = [UIColor whiteColor];
        [view addSubview:button];
        
        UILabel * label = [[UILabel alloc]init];
        label.textColor = [UIColor colorWithRed:186/255.0 green:0/255.0 blue:0/255.0 alpha:1];
        label.font = [UIFont systemFontOfSize:15];
        label.text = @"登录美丽衣橱，有神秘惊喜哦!";
        label.frame = CGRectMake(0, 30, WIDTH, 30);
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        
        _tableView.tableHeaderView = view;
        _tableView.tableHeaderView.backgroundColor = [UIColor clearColor];
        
        
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0)
    {
        return 2;
    }
    else if(section  == 1)
    {
        return 7;
        
    }
    else if (section == 2)
    {
        return 3;
        
    }
    else
    {
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
    
}

- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSArray * arr1 = @[@"我的收货地址",@"我的优惠券",@"我的钱包",@"我的美丽币",@"签到中心",@"我的宝贝",@"我的品牌"];
    NSArray * arr2 = @[@"我要加盟",@"关注官方公众号",@"给美丽衣橱打5分"];
    switch (indexPath.section)
    {
        case 0:
            
            if (indexPath.row == 0) {
                cell.FontImageView.image = [UIImage imageNamed:@"全部订单"];
                cell.FontLab.text = @"全部订单";
                CGRect rect = [self jisuanLabLength:cell.FontLab.text andInt:15];
                cell.FontLab.frame = CGRectMake(45, 10, rect.size.width, rect.size.height);
            }
            else
            {
                cell.isFiveView.backgroundColor = [UIColor whiteColor];
            }
            break;
        case 1:
            cell.FontImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",arr1[indexPath.row]]];
            cell.FontLab.text = arr1[indexPath.row];
            CGRect rect = [self jisuanLabLength:cell.FontLab.text andInt:15];
            cell.FontLab.frame = CGRectMake(45, 10, rect.size.width, rect.size.height);

            if (indexPath.row == 2) {
                cell.BackLab.text = @"可用余额￥0";
                CGRect rect = [self jisuanLabLength:cell.BackLab.text andInt:13];
                cell.BackLab.frame = CGRectMake(WIDTH-35-rect.size.width, 11, rect.size.width, 20);
                
            }
            if (indexPath.row == 3) {
                cell.BackLab.text = @"0枚";
                CGRect rect = [self jisuanLabLength:cell.BackLab.text andInt:13];
                cell.BackLab.frame = CGRectMake(WIDTH-35-rect.size.width, 11, rect.size.width, 20);
            }
            if (indexPath.row != 6) {
                cell.LineLab.text = nil;
            }
            break;
        case 2:
            cell.FontImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",arr2[indexPath.row]]];
            cell.FontLab.text = arr2[indexPath.row];
            CGRect rect1 = [self jisuanLabLength:cell.FontLab.text andInt:15];
            cell.FontLab.frame = CGRectMake(45, 10, rect1.size.width, rect1.size.height);

            if (indexPath.row == 0) {
                cell.BackLab.text = @"开始赚钱";
                CGRect rect = [self jisuanLabLength:cell.BackLab.text andInt:13];
                cell.BackLab.frame = CGRectMake(WIDTH-35-rect.size.width, 11, rect.size.width, 20);
            }
            if (indexPath.row != 2) {
                cell.LineLab.text = nil;
            }
            break;
        case 3:
            cell.FontImageView.image = [UIImage imageNamed:@"设置"];
            cell.FontLab.text = @"设置";
            CGRect rect2 = [self jisuanLabLength:cell.FontLab.text andInt:15];
            cell.FontLab.frame = CGRectMake(45, 10, rect2.size.width, rect2.size.height);

            break;
        default:
            break;
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 3) {
        return 20;
    }
    return 10;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    if (section == 0)
//    {
//        return 120;
//    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0 && indexPath.row == 1)
    {
        return 45;
    }
    return 40;
}

//计算label 的长度
- (CGRect)jisuanLabLength:(NSString * )text andInt:(int)font
{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(200, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
    return rect;
    
}

//更改header的颜色 当要显示headerView的时候
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
    view.tintColor = [UIColor clearColor];
//    view.tintColor = [UIColor colorWithWhite:0.9 alpha:1];
    
    //设置footer上的字的颜色
//    UITableViewHeaderFooterView * footer = (UITableViewHeaderFooterView * )view;
//    footer.textLabel.textColor = [UIColor redColor];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
//    view.tintColor = [UIColor clearColor];
    
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
