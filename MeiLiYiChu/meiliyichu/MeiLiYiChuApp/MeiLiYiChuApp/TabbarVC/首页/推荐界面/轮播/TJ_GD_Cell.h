//
//  TJ_GD_Cell.h
//  MeiLiYiChuApp
//
//  Created by mac on 16/9/19.
//  Copyright © 2016年 刘文海. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface TJ_GD_Cell : UIView<UIScrollViewDelegate>



/**
 *  轮播的图片数组
 */
@property (nonatomic, strong) NSMutableArray * ImgArr;
/**
 *  无限轮播的滚动视图
 */
@property (nonatomic, strong) UIScrollView * lunboSc;

/**
 *  页面控制器
 */
@property (nonatomic, strong) UIPageControl * page;
@end
