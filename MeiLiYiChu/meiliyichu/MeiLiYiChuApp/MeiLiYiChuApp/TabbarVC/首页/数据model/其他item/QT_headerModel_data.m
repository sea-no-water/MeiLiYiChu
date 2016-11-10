//
//  QT_headerModel_data.m
//  MeiLiYiChuApp
//
//  Created by mac on 16/9/21.
//  Copyright © 2016年 刘文海. All rights reserved.
//

#import "QT_headerModel_data.h"

@implementation QT_headerModel_data
- (id)initWithDictionary:(NSDictionary *)dic
{
    if (self)
    {
        self.categoryMArray = [NSMutableArray array];
        NSArray * array = dic[@"category_list"];

        for (NSDictionary * dic1 in array)
        {
            self.category_list = [[QT_headerModel_data_category_list alloc]initWithDictionary:dic1];
            [self.categoryMArray addObject:self.category_list];
        }
    }
    return self;
    
}
@end
