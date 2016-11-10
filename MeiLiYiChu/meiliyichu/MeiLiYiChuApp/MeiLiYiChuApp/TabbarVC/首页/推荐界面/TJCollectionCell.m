//
//  TJCollectionCell.m
//  MeiLiYiChuApp
//
//  Created by mac on 16/9/13.
//  Copyright © 2016年 刘文海. All rights reserved.
//

#import "TJCollectionCell.h"
#import "SYsource.h"
#import "JPTJModel.h"

#import "TJ_GD_Cell.h"
#import "TJ_Zero_Cell.h"
#import "JPTJ_Cell.h"

#define ITEMWITH (WIDTH-30)/2
#define URLSTR @"http://api.yuike.com/gmall/api/1.0/allbuy/list.php?mid=457465&type=dress&category_ids=4796%%2C4797%%2C4798%%2C4805%%2C4838%%2C4839%%2C4840%%2C4841%%2C4843%%2C4892%%2C22150%%2C22153%%2C22155&channel_id=1464783721&sort=default&yk_pid=3&yk_appid=1&yk_cc=huawei&yk_cvc=311&cursor=0&count=%d"
@implementation TJCollectionCell


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _count = 40;
        
        NSString * urlstr = [NSString stringWithFormat:URLSTR,_count] ;
        
        //数据
        typeof(self) lsSelf = self;
        [SYsource getLunBoScImg:^(NSDictionary *dic) {
            
            JPTJModel * model = [[JPTJModel alloc]initWithDictionary:dic];
            lsSelf.DataArray = model.data.ProductsArr;
            
            [lsSelf addSubview:lsSelf.collectionView];
            
        } WithURL:urlstr];

        //创建button 不能在滚动时创建
        _upButton = [[UIButton alloc]init];

        //刷新
        [self Refresh];
    }
    return self;
}

//每次加载页面时置顶
- (void)setToTop:(NSString *)toTop
{
    [_collectionView scrollsToTop];
    [_collectionView reloadData];

}

#pragma mark ************* 刷新
//刷新
- (void)Refresh
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
//    [header beginRefreshing];
    
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

//下拉刷新
- (void)downLoadNewData
{
   
        NSString * urlstr = [NSString stringWithFormat:URLSTR,40];
    
        [SYsource getLunBoScImg:^(NSDictionary *dic) {
            
            JPTJModel * model = [[JPTJModel alloc]initWithDictionary:dic];
            [_DataArray removeAllObjects];
            _DataArray = model.data.ProductsArr;
            
            _count = (int)_DataArray.count;
            
            dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];

            });
            
        } WithURL:urlstr];

    [self.collectionView.mj_header endRefreshing];

    
}

//上拉加载
- (void)upLoadData
{
    static int count = 40 ;
    count += 20;
        NSString * urlstr = [NSString stringWithFormat:URLSTR,count];
        //重新获取数据 替换缓存数组
        [SYsource getLunBoScImg:^(NSDictionary *dic) {
            
            JPTJModel * model = [[JPTJModel alloc]initWithDictionary:dic];
            NSMutableArray * array = model.data.ProductsArr;
            for (int i = 0 ; i<_DataArray.count; i++)
            {
                [array removeObjectAtIndex:0];
            }
            [_DataArray addObjectsFromArray:array];
            
            _count = (int)_DataArray.count;
            //主线程刷新
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
            });
            
        } WithURL:urlstr];

    [self.collectionView.mj_footer endRefreshing];
}
#pragma mark ************* 懒加载
- (UICollectionView * )collectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumLineSpacing = 10;
        flowLayout.minimumInteritemSpacing = 10;
        flowLayout.itemSize = CGSizeMake((WIDTH-30)/2, (WIDTH-30)/2+75);
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 10, 10);
        flowLayout.headerReferenceSize = CGSizeMake(WIDTH, 630);//设置头部的size
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64-33-49) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
        
        [_collectionView registerClass:[JPTJ_Cell class] forCellWithReuseIdentifier:@"cell"];
        //注册头部view
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        
    }
    return _collectionView;
    
}

#pragma mark ************* 协议方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.DataArray.count;
    
}

- (UICollectionViewCell * )collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JPTJ_Cell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    
    cell.backgroundColor = [UIColor whiteColor];
    JPTJModel_products * products = _DataArray[indexPath.item];
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:products.pic_url]];
    cell.detailLab.text = products.title;
    cell.priceLab.text = [NSString stringWithFormat:@"￥%@",products.selling_price];
    CGRect rect = [self getRectWithString:cell.priceLab.text andFont:13];
    cell.priceLab.frame = CGRectMake(5, ITEMWITH+50, rect.size.width, 20);
    
    NSString * soldStr = [NSString stringWithFormat:@"%@件已售",products.sales_volume];
    CGRect rect1 = [self getRectWithString:soldStr andFont:11];
    cell.soldCountLab.frame = CGRectMake(ITEMWITH-rect1.size.width-5, ITEMWITH+50, rect1.size.width, 20);
    NSMutableAttributedString * attributeStr = [[NSMutableAttributedString alloc]initWithString:soldStr];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, products.sales_volume.length)];
    cell.soldCountLab.attributedText = attributeStr;
    
    return cell;
}

//返回头视图
- (UICollectionReusableView * )collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        UICollectionReusableView * header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
       TJ_GD_Cell * GDView = [[TJ_GD_Cell alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 120)];
        [header addSubview:GDView];
        TJ_Zero_Cell * zeroView = [[TJ_Zero_Cell alloc]initWithFrame:CGRectMake(0, 130, WIDTH, 510)];
        [header addSubview:zeroView];
        return header;
    }
    return nil;
    
}

//计算文本长度
- (CGRect)getRectWithString:(NSString * )str andFont:(CGFloat)font
{
    CGRect rect = [str boundingRectWithSize:CGSizeMake(ITEMWITH, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
    return rect;
    
}

#pragma mark ************* 置顶
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    BOOL isLarge ;//是否要把菜单隐藏
//    NSLog(@"%f",scrollView.contentOffset.y);
    if (scrollView.contentOffset.y>50)
    {
        _upButton.frame = CGRectMake(WIDTH-40, self.bounds.size.height-50, 30, 30);
        _upButton.backgroundColor = [UIColor redColor];
        _upButton.layer.cornerRadius = 15;
        _upButton.layer.masksToBounds = YES;
        _upButton.alpha = 0.7;
        [_upButton setTitle:@"顶" forState:UIControlStateNormal];
        
        [_upButton addTarget:self action:@selector(upBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_upButton];
    }
    else
    {
        [_upButton removeFromSuperview];
    }
    if (scrollView.contentOffset.y>HEIGHT/2) {
        isLarge = YES;
        _collectionView.frame = CGRectMake(0, -20, WIDTH, HEIGHT-64-49);
        _upButton.frame = CGRectMake(WIDTH-40, self.bounds.size.height-50, 30, 30);
    }
    else if (scrollView.contentOffset.y<100)
    {
        isLarge = NO;
        _collectionView.frame = CGRectMake(0, 0, WIDTH, HEIGHT-64-33-49);
        _upButton.frame = CGRectMake(WIDTH-40, self.bounds.size.height-50, 30, 30);
        
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"TJSCROLLOFFSET" object:nil userInfo:@{@"isLarge":@(isLarge)}];

}

- (void)upBtnClick:(UIButton *)button
{
    [UIView animateWithDuration:0.1 animations:^{
        
        _collectionView.contentOffset =CGPointMake(0, 0);
        [button removeFromSuperview];

    }];
    
}


@end
