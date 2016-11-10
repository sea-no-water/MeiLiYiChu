//
//  QT_headerModel.m
//  MeiLiYiChuApp
//
//  Created by mac on 16/9/21.
//  Copyright © 2016年 刘文海. All rights reserved.
//

#import "QT_headerModel.h"

@implementation QT_headerModel

- (id)initWithDictionary:(NSDictionary *)dic;
{
    
    if (self)
    {
        NSDictionary * dic1 = dic[@"data"];
        self.Data = [[QT_headerModel_data alloc]initWithDictionary:dic1];
        
    }
    return self;
    
}
@end
