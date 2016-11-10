//
//  JPTJModel.m
//  MeiLiYiChuApp
//
//  Created by mac on 16/9/18.
//  Copyright © 2016年 刘文海. All rights reserved.
//

#import "JPTJModel.h"

@implementation JPTJModel
- (id)initWithDictionary:(NSDictionary * )dic
{
    if (self)
    {
        NSDictionary * dic1 = dic[@"data"];
        self.data = [[JPTJModel_data alloc]initWithDictionary:dic1];
    }
    return self;
    
}
@end
