//
//  TJCollectionCell.h
//  MeiLiYiChuApp
//
//  Created by mac on 16/9/13.
//  Copyright © 2016年 刘文海. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJCollectionCell : UICollectionViewCell<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/**
 *  存储模型数据
 */
@property (nonatomic, strong) NSMutableArray * DataArray;

/**
 *  总的collectionView
 */
@property (nonatomic, strong) UICollectionView * collectionView;
/**
 *  jptjCell观察的对象
 */
@property (nonatomic, assign) int count;
/**
 *  置顶按钮
 */
@property (nonatomic, strong) UIButton * upButton;
/**
 *  滚动到顶部的set方法
 */
@property (nonatomic, strong)NSString * toTop;
@end
