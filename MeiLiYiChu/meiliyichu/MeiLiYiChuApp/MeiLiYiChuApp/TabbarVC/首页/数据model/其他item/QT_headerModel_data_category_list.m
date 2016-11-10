//
//  QT_headerModel_data_category_list.m
//  MeiLiYiChuApp
//
//  Created by mac on 16/9/21.
//  Copyright © 2016年 刘文海. All rights reserved.
//

#import "QT_headerModel_data_category_list.h"

@implementation QT_headerModel_data_category_list

- (id)initWithDictionary:(NSDictionary *)dic
{
    if (self)
    {
        self.pic_url = dic[@"pic_url"];
        self.title   = dic[@"title"];
        self.cids    = dic[@"cids"];
    }
    return self;
    
    
}
@end
