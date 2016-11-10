//
//  JXModel.m
//  MeiLiYiChuApp
//
//  Created by mac on 16/9/8.
//  Copyright © 2016年 刘文海. All rights reserved.
//

#import "JXModel.h"

@implementation JXModel
- (id)initWithDictionary:(NSDictionary * )dic
{
    if (self) {
        
        NSDictionary * dic1 = dic[@"data"];
        self.data = [[JX_data alloc]initWithDictionary:dic1];
        
        
        
    }
    return self;
}


@end
