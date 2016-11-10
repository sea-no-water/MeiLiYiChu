//
//  JX_ products.m
//  MeiLiYiChuApp
//
//  Created by mac on 16/9/8.
//  Copyright © 2016年 刘文海. All rights reserved.
//

#import "JX_products.h"

@implementation JX_products

- (id)initWithDictionary:(NSDictionary * )dic
{
    
    if (self)
    {
        self.taobao_pic_url = dic[@"taobao_pic_url"];
        self.taobao_title = dic[@"taobao_title"];
        self.taobao_selling_price = dic[@"taobao_selling_price"] ;
        self.taobao_price = dic[@"taobao_price"];
        self.money_symbol = dic[@"money_symbol"];
        self.discount = dic[@"discount"];
        self.taobao_url = dic[@"taobao_url"];
        
    }
    return self;
    
}

@end
