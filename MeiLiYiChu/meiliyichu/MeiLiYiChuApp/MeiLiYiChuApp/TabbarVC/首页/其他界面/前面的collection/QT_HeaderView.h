//
//  QT_HeaderView.h
//  MeiLiYiChuApp
//
//  Created by mac on 16/9/20.
//  Copyright © 2016年 刘文海. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QT_HeaderView : UIView
/**
 *  摆放小图button&lable的view
 */
@property (nonatomic, strong)UIView * BtnsView;
/**
 *  精品推荐View
 */
@property (nonatomic, strong) UIView * JPTJView;

/**
 *  接收请求到的数据
 */
@property (nonatomic, strong)NSArray * dataArray;
/**
 *  传过来的itemname
 */
@property (nonatomic, strong)NSString * name;
@end
