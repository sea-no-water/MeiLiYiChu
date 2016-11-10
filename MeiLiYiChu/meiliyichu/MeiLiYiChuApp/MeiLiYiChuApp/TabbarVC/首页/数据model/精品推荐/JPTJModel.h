//
//  JPTJModel.h
//  MeiLiYiChuApp
//
//  Created by mac on 16/9/18.
//  Copyright © 2016年 刘文海. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JPTJModel_data.h"
#import "JPTJModel_products.h"
@interface JPTJModel : NSObject

@property (nonatomic, strong)JPTJModel_data * data;

- (id)initWithDictionary:(NSDictionary * )dic;

@end
