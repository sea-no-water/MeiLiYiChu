//
//  JPTJModel_data.h
//  MeiLiYiChuApp
//
//  Created by mac on 16/9/18.
//  Copyright © 2016年 刘文海. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JPTJModel_products.h"
@interface JPTJModel_data : NSObject

@property (nonatomic, strong)JPTJModel_products * products;

@property (nonatomic, strong)NSMutableArray * ProductsArr;

- (id)initWithDictionary:(NSDictionary *)dic;
@end
