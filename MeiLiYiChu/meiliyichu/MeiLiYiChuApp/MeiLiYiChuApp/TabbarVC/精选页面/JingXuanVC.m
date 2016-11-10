//
//  JingXuanVC.m
//  MeiLiYiChuApp
//
//  Created by mac on 16/9/7.
//  Copyright © 2016年 刘文海. All rights reserved.
//

#import "JingXuanVC.h"
#import "My_CollectionViewCell.h"
#import "JingXuanSource.h"
#import "JXModel.h"
#import "JingXuan_taobao.h"
#import <MJRefresh.h>
#define ITEMHEIGHT cell.bounds.size.height
#define ITEMWIDTH cell.bounds.size.width
@interface JingXuanVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSMutableArray * _productArr;
    UIButton * _upButton;
}
@property (strong,nonatomic)UICollectionView * collectionView;

@end

@implementation JingXuanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"精选好货";
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor colorWithWhite:0.5 alpha:1]};
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //置顶按钮
    _upButton = [[UIButton alloc]init];
    
    //获取数据
    JingXuanSource * jxSource = [[JingXuanSource alloc]init];
    [jxSource getJingXuanSource:30];
    
    //    __block typeof(_productArr) blockArr = _productArr;
    jxSource.dicBlock = ^(JXModel *model)
    {
        //创建流布局
        self.collectionView.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
        
        _productArr = model.data.productsArray;
        
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
            self.collectionView.mj_header = header;
            
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
            self.collectionView.mj_footer = footer;
        }
        
    };
    
}

#pragma mark ************* 懒加载
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumLineSpacing = 5;
        flowLayout.minimumInteritemSpacing = 5;
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        flowLayout.itemSize = CGSizeMake((WIDTH-15)/2, (HEIGHT-64)/2);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64-49) collectionViewLayout:flowLayout];
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[My_CollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
        [self.view addSubview:_collectionView];
        
    }
    return _collectionView;
}

#pragma mark ************* 刷新
//下拉刷新
- (void)downLoadNewData
{
    //获取数据
    JingXuanSource * jxSource = [[JingXuanSource alloc]init];
    [jxSource getJingXuanSource:30];
    
    jxSource.dicBlock = ^(JXModel * model){
        
        if (model.data.productsArray!=nil)
        {
            [_productArr removeAllObjects];
            _productArr = model.data.productsArray;
            NSIndexPath * indexpath = [NSIndexPath indexPathForRow:0 inSection:0];
            //返回主线程刷新数据
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [_collectionView reloadData];
                [_collectionView scrollToItemAtIndexPath:indexpath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
                
                [_collectionView.mj_header endRefreshing];
            });
            
        }
        
    };
    
}

//上拉加载
- (void)upLoadData
{
    static int count;
    count += 10 ;
    //获取数据
    JingXuanSource * jxSource = [[JingXuanSource alloc]init];
    [jxSource getJingXuanSource:count];
    
    jxSource.dicBlock = ^(JXModel * model){
        
        if (model.data.productsArray!=nil)
        {
            [_productArr removeAllObjects];
            _productArr = model.data.productsArray;
//            NSIndexPath * indexpath = [NSIndexPath indexPathForRow:_productArr.count-1 inSection:0];
            //返回主线程刷新数据
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [_collectionView reloadData];
//                [_collectionView scrollToItemAtIndexPath:indexpath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
                
                [_collectionView.mj_footer endRefreshing];
            });
            
        }
        
    };
    
}

#pragma mark ************* 代理协议方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return _productArr.count;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    My_CollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    /************************************ 商品图片 ***********************************/
    [cell.Image sd_setImageWithURL:[NSURL URLWithString: [_productArr[indexPath.item] taobao_pic_url]]];
    
    /************************************ 商品描述 ***********************************/
    cell.discripton.text = [_productArr[indexPath.item] taobao_title];
    
    /************************************ 新的价格 ***********************************/
    cell.nPrice.text = [NSString stringWithFormat:@"%@%@",[_productArr[indexPath.item] money_symbol],[_productArr[indexPath.item] taobao_selling_price]] ;
    CGRect  npRect = [self jisuanLabLength:cell.nPrice.text andCell:cell];
    cell.nPrice.frame = CGRectMake(5, ITEMHEIGHT-20, npRect.size.width, 15);
    
    /************************************ 旧的价格 ***********************************/
    NSString * oldstr = [NSString stringWithFormat:@"%@%@",[_productArr[indexPath.item] money_symbol],[_productArr[indexPath.item] taobao_price]];
    CGRect oldpRect = [self jisuanLabLength:oldstr andCell:cell];
    cell.oldPrice.frame = CGRectMake(10+cell.nPrice.bounds.size.width, ITEMHEIGHT-20, oldpRect.size.width, 15);
    //设置删除线
    NSUInteger length = [oldstr length];
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc]initWithString:oldstr];
    //删除线
    [attrStr addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid|NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
    //删除线颜色
    [attrStr addAttribute:NSStrikethroughColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, length)];
    //设置字符串属性
    cell.oldPrice.attributedText = attrStr;
    
    /************************************ 折扣 ***********************************/
    cell.zheLab.text = [_productArr[indexPath.item] discount];
    //计算字符长度
    CGRect zheRect = [self jisuanLabLength:cell.zheLab.text andCell:cell];
    cell.zheLab.frame = CGRectMake(ITEMWIDTH-zheRect.size.width-15, ITEMHEIGHT-20, zheRect.size.width+10, 15);
    
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
    
}

//计算折扣label的长度
- (CGRect)jisuanLabLength:(NSString * )text andCell:(My_CollectionViewCell * )cell
{
    CGRect rect = [text boundingRectWithSize:CGSizeMake((ITEMWIDTH-10)/3, 15) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
    return rect;
}

//点击item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    JingXuan_taobao * jxTaobao = [[JingXuan_taobao alloc]init];
    jxTaobao.urlString = [_productArr[indexPath.item] taobao_url];
    
    //隐藏tabBar
    //    NSLog(@"%@",[self.view.window.rootViewController.view.subviews.lastObject class]);
    //找到tabBar
    UIView * view = self.view.window.rootViewController.view.subviews.lastObject;
    [UIView animateWithDuration:0.2 animations:^{
        view.frame = CGRectMake(-WIDTH, view.frame.origin.y, view.bounds.size.width, view.bounds.size.height);
    }];
    
    [self.navigationController pushViewController:jxTaobao animated:YES];
    
}

#pragma mark ************* 置顶
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y>50)
    {
        _upButton.frame = CGRectMake(WIDTH-40, HEIGHT-120, 30, 30);
        _upButton.backgroundColor = [UIColor redColor];
        _upButton.layer.cornerRadius = 15;
        _upButton.layer.masksToBounds = YES;
        _upButton.alpha = 0.7;
        [_upButton setTitle:@"顶" forState:UIControlStateNormal];
        
        [_upButton addTarget:self action:@selector(upBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_upButton];
        
    }
    else if(scrollView.contentOffset.y<20)
    {
        [_upButton removeFromSuperview];
    }
}

- (void)upBtnClick:(UIButton *)button
{
    [UIView animateWithDuration:0.1 animations:^{
        
        _collectionView.contentOffset =CGPointMake(0, 0);
        [button removeFromSuperview];
        
    }];
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
