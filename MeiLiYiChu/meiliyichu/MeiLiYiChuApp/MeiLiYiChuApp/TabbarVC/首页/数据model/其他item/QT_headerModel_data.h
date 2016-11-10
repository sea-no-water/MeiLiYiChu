//
//  QT_headerModel_data.h
//  MeiLiYiChuApp
//
//  Created by mac on 16/9/21.
//  Copyright © 2016年 刘文海. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QT_headerModel_data_category_list.h"
@interface QT_headerModel_data : NSObject

/**
 *  category_list类对象
 */
@property (nonatomic, strong)QT_headerModel_data_category_list * category_list;
/**
 *  存放category的类对象
 */
@property (nonatomic, strong)NSMutableArray * categoryMArray;
- (id)initWithDictionary:(NSDictionary *)dic;
@end
