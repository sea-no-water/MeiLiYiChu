//
//  JX_data.h
//  MeiLiYiChuApp
//
//  Created by mac on 16/9/8.
//  Copyright © 2016年 刘文海. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JX_products.h"
@interface JX_data : NSObject
/**
 *  product
 */
@property (nonatomic,strong)JX_products * products;

@property (nonatomic,strong)NSMutableArray * productsArray;
- (id)initWithDictionary:(NSDictionary * )dic;
@end
