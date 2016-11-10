//
//  JX_data.m
//  MeiLiYiChuApp
//
//  Created by mac on 16/9/8.
//  Copyright © 2016年 刘文海. All rights reserved.
//

#import "JX_data.h"

@implementation JX_data

- (id)initWithDictionary:(NSDictionary * )dic
{
    if (self)
    {
        self.productsArray = [NSMutableArray array];
        NSArray * array = dic[@"products"];
        for (NSDictionary * dic1 in array)
        {
            self.products = [[JX_products alloc]initWithDictionary:dic1];
            [self.productsArray addObject:self.products];
        }
        
    }
    return self;
    
}


@end
