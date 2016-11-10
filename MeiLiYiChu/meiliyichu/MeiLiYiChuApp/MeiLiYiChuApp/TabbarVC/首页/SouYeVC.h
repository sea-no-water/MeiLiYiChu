//
//  SouYeVC.h
//  MeiLiYiChuApp
//
//  Created by mac on 16/9/7.
//  Copyright © 2016年 刘文海. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SouYeVC : UIViewController
/**
 *  存放请求cell的数据
 */
@property (nonatomic, strong)NSMutableArray * SourceArray;
/**
 *  存放请求header的数码
 */
@property (nonatomic, strong)NSMutableArray * HeaderArray;
@end
