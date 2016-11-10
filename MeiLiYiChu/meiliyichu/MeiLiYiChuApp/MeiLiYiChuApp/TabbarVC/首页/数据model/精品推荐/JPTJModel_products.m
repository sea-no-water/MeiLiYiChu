//
//  JPTJModel_products.m
//  MeiLiYiChuApp
//
//  Created by mac on 16/9/18.
//  Copyright © 2016年 刘文海. All rights reserved.
//

#import "JPTJModel_products.h"

@implementation JPTJModel_products
- (id)initWithDictionary:(NSDictionary * )dic
{
    if (self) {
        
        self.ID =               dic[@"id"];
        self.title =            dic[@"title"];
        self.pic_url =          dic[@"pic_url"];
        self.selling_price =    dic[@"selling_price"];
        self.mobile_cps_url =   dic[@"mobile_cps_url"];
        self.sales_volume =     dic[@"sales_volume"];
    }
    return self;
}

@end
