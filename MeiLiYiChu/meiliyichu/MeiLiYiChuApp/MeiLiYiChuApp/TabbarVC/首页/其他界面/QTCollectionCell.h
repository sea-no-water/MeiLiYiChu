//
//  QTCollectionCell.h
//  MeiLiYiChuApp
//
//  Created by mac on 16/9/20.
//  Copyright © 2016年 刘文海. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QTCollectionCell : UICollectionViewCell<UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout>

/**
 *  承接数据的流布局
 */
@property (nonatomic, strong)UICollectionView * collectionView;

/**
 *  接收首页请求cell的数据
 */
@property (nonatomic, strong)NSMutableArray * SourceArray;
/**
 *  接收首页请求header的数据
 */
@property (nonatomic, strong)NSMutableArray * HeaderArray;
/**
 *  传过来的headNameURL
 */
@property (nonatomic, strong)NSString * headNameURL;
/**
 *  传过来的cellNameURL
 */
@property (nonatomic, strong)NSString * cellNameURL;

/**
 *  重写的set方法
 */
@property (nonatomic, strong)NSString * REset;
/**
 *  接收的需要返回的count
 */
@property (nonatomic, assign)int count;
/**
 *  三种类别名字
 */
@property (nonatomic, strong)NSString * className;
/**
 *  置顶按钮
 */
@property (nonatomic, strong) UIButton * upButton;
/**
 *  滚动到顶部的set方法
 */
@property (nonatomic, strong)NSString * toTop;
@end
