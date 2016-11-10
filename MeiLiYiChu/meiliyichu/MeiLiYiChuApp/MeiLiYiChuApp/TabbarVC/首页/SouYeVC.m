//
//  SouYeVC.m
//  MeiLiYiChuApp
//
//  Created by mac on 16/9/7.
//  Copyright © 2016年 刘文海. All rights reserved.
//

#import "SouYeVC.h"
#import "TJCollectionCell.h"
#import "SYsource.h"
#import "QTCollectionCell.h"
#import "QT_headerModel.h"
#import "JPTJModel.h"

#define HEADERURLSTR  @"http://api.yuike.com/gmall/api/1.0/allbuy/category_list.php?mid=457465&type=%@&yk_pid=3&yk_appid=1&yk_cc=huawei&yk_cvc=311&cursor=0&count=40"

#define CELLURLSTR  @"http://api.yuike.com/gmall/api/1.0/allbuy/list.php?mid=457465&type=%@&category_ids=0&channel_id=1464783926&sort=default&yk_pid=3&yk_appid=1&yk_cc=huawei&yk_cvc=311&cursor=0&count=%%d"
@interface SouYeVC ()<UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
{
    /**
     *  菜单view
     */
    UIView * _MuneView;
    /**
     *  这是滚动菜单
     */
    UIScrollView * _MenuScrollView;
    /**
     *  这是滚动菜单按钮的名字
     */
    NSArray * _munuNameArr;
    /**
     *  菜单指示线
     */
    UILabel * _lineLab;
    /**
     *  _MenuScrollView 前一个点击的按钮
     */
    UIButton * _fontSelectBtn;
    /**
     *  箭头按钮
     */
    UIButton * _topButton;
    /**
     *  twentyBtnSC 前一个点击的按钮
     */
    UIButton * _TWfontSelectBtn;
    
    /**
     *  菜单英文名字数组
     */
    NSArray * _menuEngNameArray;
    /**
     *  记录bigCollection的item 的size
     */
    CGSize _bigSize;
}
/**
 *  替换的lab 显示 “选择分类”
 */
@property (nonatomic, strong) UILabel * PlachoderLab;
/**
 *  灰色半透明的背景按钮
 */
@property (nonatomic, strong) UIButton* grayBgBtn;
/**
 *  显示的20个按钮
 */
@property (nonatomic, strong) UIScrollView * twentyBtnSC;
/**
 *  最大的那个collection
 */
@property (nonatomic, strong) UICollectionView * BigCollectionView;

@end

@implementation SouYeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:186/255.0 green:0/255.0 blue:0/255.0 alpha:1];
//    self.navigationController.navigationBar.hidden = YES
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.tintColor = [UIColor colorWithWhite:0.9 alpha:1 ];
    
    self.SourceArray = [NSMutableArray array];
    self.HeaderArray = [NSMutableArray array];
    
    _munuNameArr = @[@"推荐",@"女装",@"鞋包",@"美妆",@"配饰",@"零食",@"家居",@"家电",@"厨具",@"男装",@"中老年",@"童装",@"家纺",@"母婴",@"车配",@"保健",@"图书",@"数码",@"水果",@"建材"];
    _menuEngNameArray = @[@"dress",@"shoes",@"makeup",@"ornament",@"snackdrink",@"homefurnish",@"homeappliance",@"kitchenstorage",@"men",@"agedness",@"children",@"textiles",@"toy",@"autoparts",@"medicalcare",@"book",@"digitaloffice",@"freshfruit",@"homedepot"];

    //接收通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(natificationAction:) name:@"TJSCROLLOFFSET" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(natificationAction:) name:@"QTSCROLLOFFSET" object:nil];
    
    //导航栏
    [self customNavBar];
    
    self.BigCollectionView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];

    //滚动菜单
    [self scrollMenu];
   
}
//通知方法
- (void)natificationAction:(NSNotification *)noti
{
    NSDictionary * dic = noti.userInfo;
    BOOL islarge = [dic[@"isLarge"] boolValue];
    if (islarge == YES)
    {
        [UIView animateWithDuration:0.5 animations:^{
            
            _MuneView.frame = CGRectMake(0, 0, WIDTH, 33);
        }];
        _bigSize = CGSizeMake(WIDTH, HEIGHT-64-49);
        _BigCollectionView.frame = CGRectMake(0, 64, WIDTH, HEIGHT-64-49);
    }
    else
    {
        [UIView animateWithDuration:0.5 animations:^{
            _MuneView.frame = CGRectMake(0, 64, WIDTH, 33);
            
        }];
        _bigSize = CGSizeMake(WIDTH, HEIGHT-64-33-49);
        _BigCollectionView.frame = CGRectMake(0, 64+33, WIDTH, HEIGHT-64-33-49);
    }
}

#pragma mark ************* 懒加载
- (UILabel * )PlachoderLab
{
    if (!_PlachoderLab)
    {
        _PlachoderLab = [[UILabel alloc]init];
        _PlachoderLab.text = @"  选择分类";
        _PlachoderLab.textColor = [UIColor grayColor];
        _PlachoderLab.textAlignment = NSTextAlignmentLeft;
        _PlachoderLab.frame = CGRectMake(0, 0, WIDTH-50, 32);
        _PlachoderLab.backgroundColor = [UIColor whiteColor];
        _PlachoderLab.font = [UIFont systemFontOfSize:15];
        _PlachoderLab.alpha = 0.5;
        [_MuneView addSubview:_PlachoderLab];
    }
    return _PlachoderLab;
}

- (UIButton * )grayBgBtn
{
    if (!_grayBgBtn)
    {
        _grayBgBtn = [[UIButton alloc]init];
        _grayBgBtn.frame = CGRectMake(0, 64+33, WIDTH, 0);
        _grayBgBtn.backgroundColor = [UIColor lightGrayColor];
        _grayBgBtn.alpha = 0.5;
        [_grayBgBtn addTarget:self action:@selector(grayBgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_grayBgBtn];
    }
    return _grayBgBtn;
}

- (void)grayBgBtnClick:(UIButton * )button
{
    //旋转180
    button.transform = CGAffineTransformRotate(button.transform, M_PI);

    _grayBgBtn.frame = CGRectMake(0, 64+33, WIDTH, 0);
    [UIView animateWithDuration:0.3 animations:^{
        self.PlachoderLab.alpha = 0;
        self.twentyBtnSC.frame = CGRectMake(0, 64+33, WIDTH, 0);
    }];
    
    _topButton.selected = NO;
}

//20个菜单按钮
- (UIScrollView *)twentyBtnSC
{
    if (!_twentyBtnSC)
    {
        _twentyBtnSC = [[UIScrollView alloc]init];
        _twentyBtnSC.frame = CGRectMake(0, 64+33, WIDTH, 0);
        _twentyBtnSC.showsVerticalScrollIndicator = NO;
        _twentyBtnSC.backgroundColor = [UIColor whiteColor];
        _twentyBtnSC.showsHorizontalScrollIndicator = NO;
        
        for (int i = 0; i < 20 ; i ++)
        {
            UIButton * button = [[UIButton alloc]init];
            button.frame = CGRectMake(i%4*((WIDTH - 50)/4+10)+10, i/4*40+10, (WIDTH - 50)/4, 30);
            [button setTitle:_munuNameArr[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(twBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            button.tag = i;
            button.layer.cornerRadius = 15;
            button.layer.masksToBounds = YES;
            button.layer.borderWidth = 1;
            button.layer.borderColor = [[UIColor colorWithWhite:0.5 alpha:1]CGColor];
            [_twentyBtnSC addSubview:button];
            if (button.tag == 0) {
                [button setTitleColor:[UIColor colorWithRed:220/255.0 green:0/255.0 blue:0/255.0 alpha:1] forState:UIControlStateNormal];
                _TWfontSelectBtn = button;
            }
        }
        _twentyBtnSC.contentSize = CGSizeMake(WIDTH, 5*40+11);

        [self.view addSubview:_twentyBtnSC];
        
    }
    return _twentyBtnSC;
}

- (void)twBtnClick:(UIButton * )button
{
    //点击按钮缩起sc
    _topButton.transform = CGAffineTransformRotate(button.transform, M_PI);
    _topButton.selected = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.PlachoderLab.alpha = 0;
        self.twentyBtnSC.frame = CGRectMake(0, 64+33, WIDTH, 0);
    }];
    //缩起灰色背景
    _grayBgBtn.frame = CGRectMake(0, 64+33, WIDTH, 0);
    
    //更改点击按钮的颜色
    [_TWfontSelectBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

    [button setTitleColor:[UIColor colorWithRed:220/255.0 green:0/255.0 blue:0/255.0 alpha:1] forState:UIControlStateNormal];

    for (int i = 1; i < 21 ; i++)
    {
        UIButton * btn = (UIButton *)_MenuScrollView.subviews[i];
        if (btn.tag == _TWfontSelectBtn.tag)
        {
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

        }
        if (btn.tag == button.tag)
        {

            [btn setTitleColor:[UIColor colorWithRed:220/255.0 green:0/255.0 blue:0/255.0 alpha:1] forState:UIControlStateNormal];
            [self BtnJuZhong:btn];

            //更改当前显示的item
            _BigCollectionView.contentOffset = CGPointMake(WIDTH*btn.tag, 0);
        }

    }
    _TWfontSelectBtn = button;
}

//最大的collection
- (UICollectionView * )BigCollectionView
{
    if (!_BigCollectionView)
    {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.itemSize = CGSizeMake(WIDTH, HEIGHT-64-33-49);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        

        _BigCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64+33, WIDTH, HEIGHT-64-33-49) collectionViewLayout:flowLayout];
        _BigCollectionView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        _BigCollectionView.delegate = self;
        _BigCollectionView.dataSource = self;
        _BigCollectionView.pagingEnabled = YES;
        _BigCollectionView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_BigCollectionView];
        
        [_BigCollectionView registerClass:[TJCollectionCell class] forCellWithReuseIdentifier:@"cell"];
        [_BigCollectionView registerClass:[QTCollectionCell class] forCellWithReuseIdentifier:@"cell1"];
    }
    return _BigCollectionView;
}

#pragma mark ************* 导航栏
- (void)customNavBar
{
    //中间的titleview
    UIView * view = [[UIView alloc]init];
    view.frame = CGRectMake(100, 4, WIDTH-80-40, 30);
    view.tintColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UIButton * titleViewBtn = [[UIButton alloc]init];
    titleViewBtn.frame = CGRectMake(30, 0, WIDTH-80-55, 30);
    titleViewBtn.backgroundColor = [UIColor colorWithRed:140/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    titleViewBtn.tintColor = [UIColor whiteColor];

    [view addSubview:titleViewBtn];
    UIImageView * img = [[UIImageView alloc]init];
    img.image = [UIImage imageNamed:@"搜索图片"];
    img.frame = CGRectMake(5, 5, 20, 20);
    [titleViewBtn addSubview:img];
    
    UILabel * lab = [[UILabel alloc]init];
    lab.text = @"在865249款商品中搜索";
    lab.textColor = [ UIColor whiteColor];
    lab.textAlignment = NSTextAlignmentLeft;
    lab.frame = CGRectMake(30, 0, view.bounds.size.width-35, 30);
    lab.font = [UIFont systemFontOfSize:12];
    [titleViewBtn addSubview:lab];
    
    self.navigationItem.titleView = view;
    self.navigationItem.titleView.frame = CGRectMake(100, 4, WIDTH-80-40, 30);
    
    //左边的图标
    UIImageView * imageView = [[UIImageView alloc]init];
    imageView.frame = CGRectMake(5, 4, 80, 30);
    imageView.image = [UIImage imageNamed:@"美丽衣橱icon"];
    [self.navigationController.navigationBar addSubview:imageView];
    
    //右边的按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"导航栏右边按钮"] style:UIBarButtonItemStylePlain target:self action:@selector(navRightBtn)];
}

- (void)navRightBtn
{
    NSLog(@"点击了nav右边按钮");
}

#pragma mark ************* 滚动菜单
- (void)scrollMenu
{
    
    _MuneView = [[UIView alloc]init];
    _MuneView.frame = CGRectMake(0, 64, WIDTH, 33 );
    _MuneView.backgroundColor = [UIColor whiteColor ];
    [self.view addSubview:_MuneView];
    //灰线
    UILabel * lab = [[UILabel alloc]init];
    lab.frame = CGRectMake(0, 32, WIDTH, 1);
    lab.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    [_MuneView addSubview:lab];
    
    //scrollView
    _MenuScrollView = [[UIScrollView alloc]init];
    _MenuScrollView.frame = CGRectMake(0, 0, WIDTH-50, 32);
    _MenuScrollView.backgroundColor = [UIColor whiteColor ];
    _MenuScrollView.contentOffset = CGPointMake(0, 0);
    _MenuScrollView.showsHorizontalScrollIndicator = NO;
    _MenuScrollView.showsVerticalScrollIndicator = NO;
    
    [_MuneView addSubview:_MenuScrollView];
    
    //创建灰色背景
    self.grayBgBtn.alpha = 0.5;
    //创建好显示按钮的sc
    self.twentyBtnSC.alpha = 1;
    
    //指示线
    _lineLab = [[UILabel alloc]init];
    _lineLab.backgroundColor =  [UIColor colorWithRed:200/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    [_MenuScrollView addSubview:_lineLab];
    
    //向滚动菜单中添加按钮
    [self addButton];
    
    //箭头按钮
    _topButton = [[UIButton alloc]init];
    _topButton.frame = CGRectMake(WIDTH-50, 0, 50, 32);
    _topButton.backgroundColor = [UIColor whiteColor ];
    [_topButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_topButton setImage:[UIImage imageNamed:@"向下箭头"] forState:UIControlStateNormal];
    [_MuneView addSubview:_topButton];
}
//向滚动菜单中添加按钮
- (void)addButton
{
    static CGFloat x;//记录上一个按钮的x
    for (int i = 0; i < 20; i ++)
    {
        UIButton * button = [[UIButton alloc]init];
        [button setTitle:_munuNameArr[i] forState:UIControlStateNormal];
        CGRect rect = [self jisuanLabLength:_munuNameArr[i] andInt:14];
        
        button.frame = CGRectMake(x, 0, rect.size.width + 10, 30);
        x += rect.size.width + 10;

        button.tag = i;
        button.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(MenuButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_MenuScrollView addSubview:button];
        if (button.tag == 0)
        {
            [button setTitleColor:[UIColor colorWithRed:220/255.0 green:0/255.0 blue:0/255.0 alpha:1] forState:UIControlStateNormal];
            
            _lineLab.frame = CGRectMake(0, 30, button.bounds.size.width, 2);
            _fontSelectBtn = button;
        }
        if (button.tag == 19)
        {
            _MenuScrollView.contentSize = CGSizeMake(button.frame.origin.x + button.bounds.size.width, 32);
        }
    }
    
}

//点击箭头按钮事件
- (void)buttonClick:(UIButton * )button
{
    //旋转180
    button.transform = CGAffineTransformRotate(button.transform, M_PI);
    if (button.selected == NO )
    {
        _grayBgBtn.frame = CGRectMake(0, 64+33, WIDTH, HEIGHT-64-33-49);

        [UIView animateWithDuration:0.3 animations:^{
            self.PlachoderLab.alpha = 1;
            self.twentyBtnSC.frame = CGRectMake(0, 64+33, WIDTH, 210);
        }];

    }
    else if(button.selected == YES|| _grayBgBtn.selected == NO)
    {
        _grayBgBtn.frame = CGRectMake(0, 64+33, WIDTH, 0);
        [UIView animateWithDuration:0.3 animations:^{
            self.PlachoderLab.alpha = 0;
            self.twentyBtnSC.frame = CGRectMake(0, 64+33, WIDTH, 0);
        }];
     
    }
    
    
    button.selected = !button.selected;
}

//点击菜单按钮事件
- (void)MenuButtonClick:(UIButton * )button
{
    //重新设置指示线的长度
    _lineLab.bounds = CGRectMake(0, 0, button.bounds.size.width, 2);
    //按钮居中
    [self BtnJuZhong:button];
    //更改点击的按钮字体颜色
    [_fontSelectBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

     [button setTitleColor:[UIColor colorWithRed:220/255.0 green:0/255.0 blue:0/255.0 alpha:1] forState:UIControlStateNormal];
    
    //遍历 _twentyBtnSC 的子视图 更改按钮字体颜色
    [_twentyBtnSC.subviews enumerateObjectsUsingBlock:^(__kindof UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.tag == _fontSelectBtn.tag)
        {
            [obj setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
        if (obj.tag == button.tag)
        {
            [obj setTitleColor:[UIColor colorWithRed:220/255.0 green:0/255.0 blue:0/255.0 alpha:1] forState:UIControlStateNormal];
            _TWfontSelectBtn = obj;

        }
        
    }];
    _fontSelectBtn = button;

    //更改当前显示的item
    _BigCollectionView.contentOffset = CGPointMake(WIDTH*button.tag, 0);
    
}

//菜单按钮居中
- (void)BtnJuZhong:(UIButton * )button
{
    CGFloat btnX = button.center.x;
    [UIView animateWithDuration:0.3 animations:^{
        
        _lineLab.center = CGPointMake(btnX, 31);
    }];
    if (btnX < WIDTH/2)
    {
        [_MenuScrollView setContentOffset: CGPointMake(0, 0) animated:YES];
        
    }
    else if (btnX > _MenuScrollView.contentSize.width - WIDTH/2)
    {
        [_MenuScrollView setContentOffset: CGPointMake(_MenuScrollView.contentSize.width - WIDTH+50, 0) animated:YES];
    }
    else
    {
        [_MenuScrollView setContentOffset: CGPointMake(btnX - WIDTH/2, 0) animated:YES];
    }
    
    
    
}

//计算label 的长度
- (CGRect)jisuanLabLength:(NSString * )text andInt:(int)font
{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(0, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
    return rect;
    
}

#pragma mark ************* 大的collection协议方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.item==0)
    {
        TJCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        cell.toTop = @"toTop";
        return cell;
    }
  
    //其他页面
    QTCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
    //请求header 的数据
    NSString * headURl = nil;
    //请求cell 的数据
    NSString * cellURL = nil;
    if (indexPath.item == 1)
    {
        cellURL = [NSString stringWithFormat:@"http://api.yuike.com/gmall/api/1.0/allbuy/list.php?mid=457465&type=dress&category_ids=4796%%2C4797%%2C4798%%2C4805%%2C4838%%2C4839%%2C4840%%2C4841%%2C4843%%2C4892%%2C22150%%2C22153%%2C22155&channel_id=1464783721&sort=default&yk_pid=3&yk_appid=1&yk_cc=huawei&yk_cvc=311&cursor=0&count=%d",40];
        headURl = @"http://api.yuike.com/gmall/api/1.0/allbuy/category_list.php?mid=457465&type=dress&yk_pid=3&yk_appid=1&yk_cc=huawei&yk_cvc=311&cursor=0&count=40";
       
    }
    else if(indexPath.item !=0&&indexPath.item !=1)
    {
        headURl = [NSString stringWithFormat:HEADERURLSTR,_menuEngNameArray[indexPath.item-1]];
        cellURL = [NSString stringWithFormat:CELLURLSTR,_menuEngNameArray[indexPath.item-1]];
    }
    cell.headNameURL = headURl;
    cell.cellNameURL = cellURL;
    cell.tag = indexPath.row;
   
//    NSLog(@"\n===head%@",headURl);
    cell.REset = @"reset";
    cell.toTop = @"toTop";

    return cell;
    
}

//当滚动减速结束后，置顶后显示菜单栏菜单栏显示
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int a = scrollView.contentOffset.x/WIDTH;
    
    UIButton * button1 = _MenuScrollView.subviews[a+1];
//    NSLog(@"%@",button1.titleLabel.text);
    [self BtnJuZhong:button1];
    [button1 setTitleColor:[UIColor colorWithRed:220/255.0 green:0/255.0 blue:0/255.0 alpha:1] forState:UIControlStateNormal];
   
    
    if (_fontSelectBtn != button1 ) {
        [_fontSelectBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
         _fontSelectBtn = button1;
    }
    

    UIButton * button2 = _twentyBtnSC.subviews[a];
    [button2 setTitleColor:[UIColor colorWithRed:220/255.0 green:0/255.0 blue:0/255.0 alpha:1] forState:UIControlStateNormal];

    if (_TWfontSelectBtn != button2)
    {
        [_TWfontSelectBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _TWfontSelectBtn = button2;

    }
}

//当滚动减速结束后，置顶后显示菜单栏菜单栏显示
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [UIView animateWithDuration:0.5 animations:^{
        _MuneView.frame = CGRectMake(0, 64, WIDTH, 33);
        
    }];
    _bigSize = CGSizeMake(WIDTH, HEIGHT-64-33-49);
    _BigCollectionView.frame = CGRectMake(0, 64+33, WIDTH, HEIGHT-64-33-49);
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
