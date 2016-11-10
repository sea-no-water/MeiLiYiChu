//
//  NineCollectionCell.h
//  MeiLiYiChuApp
//
//  Created by mac on 16/9/13.
//  Copyright © 2016年 刘文海. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NineCollectionCell : UICollectionViewCell<UICollectionViewDelegate, UICollectionViewDataSource>

/**
 *  接收首页请求cell的数据
 */
@property (nonatomic, strong)NSMutableArray * SourceArray;
/**
 *  承接数据的流布局
 */
@property (nonatomic, strong)UICollectionView * collectionView;
/**
 *  传过来的cellNameURL
 */
@property (nonatomic, strong)NSString * cellNameURL;

/**
 *  重写的set方法
 */
@property (nonatomic, strong)NSString * REset;
/**
 *  置顶按钮
 */
@property (nonatomic, strong) UIButton * upButton;
/**
 *  滚动的偏移量
 */
@property (nonatomic ,assign) CGPoint  scrollPoint;
/**
 *  滚动到顶部的set方法
 */
@property (nonatomic, strong)NSString * toTop;
@end
