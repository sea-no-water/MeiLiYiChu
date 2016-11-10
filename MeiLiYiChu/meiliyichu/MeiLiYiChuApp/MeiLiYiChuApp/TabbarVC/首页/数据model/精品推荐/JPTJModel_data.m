//
//  JPTJModel_data.m
//  MeiLiYiChuApp
//
//  Created by mac on 16/9/18.
//  Copyright © 2016年 刘文海. All rights reserved.
//

#import "JPTJModel_data.h"

@implementation JPTJModel_data
- (id)initWithDictionary:(NSDictionary * )dic

{
    if (self)
    {
        self.ProductsArr = [NSMutableArray array];
        
        id  array = dic[@"products"];
        if ([array isKindOfClass:[NSArray class]])
        {
            for (NSDictionary * dic1 in array)
            {
                self.products = [[JPTJModel_products alloc]initWithDictionary:dic1];
                [self.ProductsArr addObject:self.products];
            }
        }
       
        
    }
    return self;
    
    
}


@end
