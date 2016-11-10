//
//  JX_ products.h
//  MeiLiYiChuApp
//
//  Created by mac on 16/9/8.
//  Copyright © 2016年 刘文海. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JX_products : NSObject
/**
 *  现在价钱
 */
@property (nonatomic,strong)NSString * taobao_selling_price;

/**
 *  old价钱
 */
@property (nonatomic,strong)NSString * taobao_price;

/**
 *  商品图片
 */
@property (nonatomic,strong)NSString * taobao_pic_url;

/**
 *  商品描述
 */
@property (nonatomic,strong)NSString * taobao_title;

/**
 *  钱的标示
 */
@property (nonatomic,strong)NSString * money_symbol;

/**
 *  折扣
 */
@property (nonatomic,strong)NSString * discount;
/**
 *  链接
 */
@property (nonatomic,strong)NSString * taobao_url;

- (id)initWithDictionary:(NSDictionary * )dic;


@end
