//
//  NineYuanVC.m
//  MeiLiYiChuApp
//
//  Created by mac on 16/9/7.
//  Copyright © 2016年 刘文海. All rights reserved.
//

#import "NineYuanVC.h"
#import "NineCollectionCell.h"
#import "SYsource.h"
#import "QT_headerModel.h"

#define ZongURL @"http://api.yuike.com/gmall/api/1.0/ninenine/category_list.php?mid=457465&sid=676efee5e73e6ea430dd66007f9deefa&yk_appid=1&yk_cbv=2.9.5&yk_pid=1&yk_user_id=5207629&sign=52ae08fd2d5dc64cfe1f3e322e2e26ca"
#define FenURL @"http://api.yuike.com/gmall/api/1.0/ninenine/list.php?mid=457465&category_ids=%@&yk_pid=3&yk_appid=1&yk_cc=baidu&yk_cvc=311&sort=%@&cursor=0&count=%%d"
@interface NineYuanVC ()<UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
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
     *  default/sales/time
     */
    NSArray * _classArr;
    /**
     *  三类别的点击过按钮
     */
    UIButton * _selectClassBtn;
    
    /**
     *  记录点击的是哪个类别的名称
     */
    NSString * _className;
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
 *  显示的20个按钮sc
 */
@property (nonatomic, strong) UIScrollView * twentyBtnSC;
/**
 *  最大的那个sc
 */
@property (nonatomic, strong) UICollectionView * BigCollectionView;


@end

@implementation NineYuanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"9块9包邮";
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor colorWithWhite:0.5 alpha:1]};
    self.view.backgroundColor = [UIColor whiteColor];

    _bigSize = CGSizeMake(WIDTH, HEIGHT-64-33-49-30);
    
    _munuNameArr = @[@"全部",@"女士",@"美食",@"美妆",@"配饰",@"男士",@"居家",@"女士内衣",@"男士内衣",@"数码家电",@"母婴",@"鞋包",@"文体",@"女鞋",@"男鞋",@"3C产品"];
    _classArr = @[@"default",@"sales",@"time"];
    _className = _classArr[0];
    
    //数据
    [SYsource getLunBoScImg:^(NSDictionary *dic) {
        QT_headerModel * model = [[QT_headerModel alloc]initWithDictionary:dic];
        _ZongArr = model.Data.categoryMArray;
        
        //接收通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(natificationAction:) name:@"SCROLLOFFSET" object:nil];
        
        //创建显示的collectionView
        self.BigCollectionView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        
        //三种类别
        [self.view addSubview:self.ClassView];
        
        //滚动菜单
        [self scrollMenu];
    } WithURL:ZongURL];
    
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
            _ClassView.frame = CGRectMake(0, 0, WIDTH, 30);

        }];
        _bigSize = CGSizeMake(WIDTH, HEIGHT-64-49);
        _BigCollectionView.frame = CGRectMake(0, 64, WIDTH, HEIGHT-64-49);
    }
    else
    {
        [UIView animateWithDuration:0.5 animations:^{
            _MuneView.frame = CGRectMake(0, 64, WIDTH, 33);
            _ClassView.frame = CGRectMake(0, 64+33, WIDTH, 30);

        }];
        _bigSize = CGSizeMake(WIDTH, HEIGHT-64-33-49-30);
        _BigCollectionView.frame = CGRectMake(0, 64+33+30, WIDTH, HEIGHT-64-33-49-30);
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

//显示的16个按钮sc
- (UIScrollView *)twentyBtnSC
{
    if (!_twentyBtnSC)
    {
        _twentyBtnSC = [[UIScrollView alloc]init];
        _twentyBtnSC.frame = CGRectMake(0, 64+33, WIDTH, 0);
        _twentyBtnSC.showsVerticalScrollIndicator = NO;
        _twentyBtnSC.backgroundColor = [UIColor whiteColor];
        _twentyBtnSC.showsHorizontalScrollIndicator = NO;
        
        for (int i = 0; i < 16 ; i ++)
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
        _twentyBtnSC.contentSize = CGSizeMake(WIDTH, 4*40+11);
        
        [self.view addSubview:_twentyBtnSC];
        
    }
    return _twentyBtnSC;
}

//点击tw按钮事件
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
    
    for (int i = 1; i < 17 ; i++)
    {
        UIButton * btn = (UIButton *)_MenuScrollView.subviews[i];
        if (btn.tag == _TWfontSelectBtn.tag)
        {
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
        if (btn.tag == button.tag)
        {
//            NSLog(@"相等");
            [btn setTitleColor:[UIColor colorWithRed:220/255.0 green:0/255.0 blue:0/255.0 alpha:1] forState:UIControlStateNormal];
            [self BtnJuZhong:btn];
//            _fontSelectBtn = btn;
            //更改当前显示的item
            _BigCollectionView.contentOffset = CGPointMake(WIDTH*btn.tag, 0);
           
        }
        
    }
     _TWfontSelectBtn = button;
}

//最大的collection 全屏
- (UICollectionView * )BigCollectionView
{
    if (!_BigCollectionView)
    {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.itemSize = CGSizeMake(WIDTH, HEIGHT-64-33-49-30);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        
        _BigCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64+33+30, WIDTH, HEIGHT-64-33-49-30) collectionViewLayout:flowLayout];
        _BigCollectionView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        _BigCollectionView.delegate = self;
        _BigCollectionView.dataSource = self;
        _BigCollectionView.pagingEnabled = YES;
        [self.view addSubview:_BigCollectionView];
        
        [_BigCollectionView registerClass:[NineCollectionCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _BigCollectionView;
}

//class 默认销量
-(UIView *)ClassView
{
    if (!_ClassView)
    {
        _ClassView = [[UIView alloc]init];
        _ClassView.backgroundColor = [UIColor whiteColor];
        _ClassView.frame = CGRectMake(0, 64+33, WIDTH, 30);
        
        NSArray * array = @[@"默认",@"销量",@"最新"];
        for (int i = 0 ; i < 3; i ++)
        {
            UIButton * button = [[UIButton alloc]init];
            button.frame = CGRectMake(i*WIDTH/3, 0, WIDTH/3, 29);
            [button setTitle:array[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            button.tag = i;
            [button addTarget:self action:@selector(ClassBtn:) forControlEvents:UIControlEventTouchUpInside];
            [_ClassView addSubview:button];
           
            UIImageView * imageview = [[UIImageView alloc]init];
            imageview.image = [UIImage imageNamed:@"down箭头普通"];
            imageview.frame = CGRectMake(WIDTH/3/2+17, 0, 10, 30);
            [button addSubview:imageview];
           
            if (button.tag == 0)
            {
                button.selected = YES;
                imageview.image = [UIImage imageNamed:@"down箭头点击"];
                _selectClassBtn = button;
            }
        }
        //灰线
        UILabel * lab = [[UILabel alloc]init];
        lab.frame = CGRectMake(0, 29, WIDTH, 1);
        lab.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
        [_ClassView addSubview:lab];
    }
    return _ClassView;
}

- (void)ClassBtn:(UIButton * )btn
{
    if (btn.selected == NO && btn != _selectClassBtn)
    {
        UIImageView * img = btn.subviews.lastObject;
        img.image = [UIImage imageNamed:@"down箭头点击"];
        _selectClassBtn.selected = NO;
        UIImageView * img1 = _selectClassBtn.subviews.lastObject;
        img1.image = [UIImage imageNamed:@"down箭头普通"];
        
        //更改类别名称
        _className = _classArr[btn.tag];

        [_BigCollectionView reloadData];
    }
    btn.selected = !btn.selected;
    _selectClassBtn = btn;


}
#pragma mark ************* 滚动菜单
- (void)scrollMenu
{
    
    _MuneView = [[UIView alloc]init];
    _MuneView.frame = CGRectMake(0, 64, WIDTH, 33);
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
    static CGFloat x;//记录上一次的按钮的x值
    for (int i = 0; i < 16; i ++)
    {
        UIButton * button = [[UIButton alloc]init];
        [button setTitle:_munuNameArr[i] forState:UIControlStateNormal];
        
        CGRect rect = [self jisuanLabLength:_munuNameArr[i] andInt:14];
        
        button.frame = CGRectMake(x, 0, rect.size.width+10, 30);
        x += rect.size.width+10;

        button.tag = i;
        button.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(MenuButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_MenuScrollView addSubview:button];
        if (button.tag == 0)
        {
            [button setTitleColor:[UIColor colorWithRed:220/255.0 green:0/255.0 blue:0/255.0 alpha:1] forState:UIControlStateNormal];
            _lineLab.frame = CGRectMake(0, 30, rect.size.width+10, 2);

            _fontSelectBtn = button;
        }
        
        if (button.tag == 15)
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
    
    if (button.selected == NO)
    {
        _grayBgBtn.frame = CGRectMake(0, 64+33, WIDTH, HEIGHT-64-33-49);

        [UIView animateWithDuration:0.3 animations:^{
            self.PlachoderLab.alpha = 1;
            self.twentyBtnSC.frame = CGRectMake(0, 64+33, WIDTH, 4*40+10);
        }];
        
    }
    else
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
    return 16;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NineCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.cellNameURL =[NSString stringWithFormat:FenURL,[_ZongArr[indexPath.item] cids],_className];
    cell.REset = @"set";
    cell.toTop = @"toTop";

    return cell;
}

//返回item的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return _bigSize;
}
//当滚动结束后
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
//    [_BigCollectionView reloadData];
}

//当滚动减速结束后，置顶后显示菜单栏菜单栏显示
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    [UIView animateWithDuration:0.5 animations:^{
        _MuneView.frame = CGRectMake(0, 64, WIDTH, 33);
        _ClassView.frame = CGRectMake(0, 64+33, WIDTH, 30);
        
    }];
    _bigSize = CGSizeMake(WIDTH, HEIGHT-64-33-49-30);
    _BigCollectionView.frame = CGRectMake(0, 64+33+30, WIDTH, HEIGHT-64-33-49-30);
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
