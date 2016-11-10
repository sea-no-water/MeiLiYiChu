//
//  JPTJModel_products.h
//  MeiLiYiChuApp
//
//  Created by mac on 16/9/18.
//  Copyright © 2016年 刘文海. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JPTJModel_products : NSObject
@property (nonatomic, copy)NSString * ID;
@property (nonatomic, copy)NSString * title;
@property (nonatomic, copy)NSString * pic_url;
@property (nonatomic, copy)NSString * selling_price;
@property (nonatomic, copy)NSString * mobile_cps_url;
/**
 *  卖出的数量
 */
@property (nonatomic, copy)NSString * sales_volume;

- (id)initWithDictionary:(NSDictionary * )dic;

@end
