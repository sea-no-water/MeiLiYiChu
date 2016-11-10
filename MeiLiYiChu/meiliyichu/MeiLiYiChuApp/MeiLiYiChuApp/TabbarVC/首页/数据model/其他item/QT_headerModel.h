//
//  QT_headerModel.h
//  MeiLiYiChuApp
//
//  Created by mac on 16/9/21.
//  Copyright © 2016年 刘文海. All rights reserved.
//

/*
 
    首页除推荐页面的其他页面  和 9块9页面 数据使用此model类
 
*/


#import <Foundation/Foundation.h>
#import "QT_headerModel_data.h"
#import "QT_headerModel_data_category_list.h"
@interface QT_headerModel : NSObject
/**
 *  解析data数据
 */
@property (nonatomic, strong)QT_headerModel_data * Data;

- (id)initWithDictionary:(NSDictionary *)dic;
@end
