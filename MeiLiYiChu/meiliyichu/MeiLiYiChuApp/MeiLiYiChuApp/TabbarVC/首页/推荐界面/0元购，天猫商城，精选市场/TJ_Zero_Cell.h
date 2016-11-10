//
//  TJ_Zero_Cell.h
//  MeiLiYiChuApp
//
//  Created by mac on 16/9/19.
//  Copyright © 2016年 刘文海. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface TJ_Zero_Cell : UIView

/**
 *  0元秒好货
 */
@property (nonatomic, strong) UIButton * zeroBtn;
/**
 *  存放data数组
 */
@property (nonatomic, strong) NSArray * dataArray;
/**
 *  天猫商城前面的lable
 */
@property (nonatomic, strong) UILabel * TMFontLab;
/**
 *  天猫商城后面的lable
 */
@property (nonatomic, strong) UILabel * TMBackLab;
/**
 *  天猫商城
 */
@property (nonatomic, strong) UIView * TMView;
/**
 *  精选市场前面lable
 */
@property (nonatomic, strong) UILabel * JXFontLab;
/**
 *  精选市场后面lable
 */
@property (nonatomic, strong) UILabel * JXBackLab;
/**
 *  精选市场
 */
@property (nonatomic, strong) UIView * JXView;
/**
 *  精品推荐View
 */
@property (nonatomic, strong) UIView * JPTJView;

@end
