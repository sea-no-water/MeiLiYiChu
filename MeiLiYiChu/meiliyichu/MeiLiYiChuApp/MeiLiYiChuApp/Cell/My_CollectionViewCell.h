//
//  My_CollectionViewCell.h
//  MeiLiYiChuApp
//
//  Created by mac on 16/9/8.
//  Copyright © 2016年 刘文海. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface My_CollectionViewCell : UICollectionViewCell

#pragma mark ****  自定义的collectionCell中的控件等  必须要在.h 文件中声明成公用属性才可以显示在屏幕上
/**
 *  展示的图片
 */
@property (nonatomic,strong)UIImageView * Image ;
/**
 *  商品描述
 */
@property (nonatomic,strong)UILabel * discripton;
/**
 *  价格
 */
@property (nonatomic,strong)UILabel * nPrice ;
/**
 *  旧的价格
 */
@property (nonatomic,strong)UILabel * oldPrice ;
/**
 *  打折Lab
 */
@property (nonatomic,strong)UILabel * zheLab;

@end
