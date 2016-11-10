//
//  JXModel.h
//  MeiLiYiChuApp
//
//  Created by mac on 16/9/8.
//  Copyright © 2016年 刘文海. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JX_data.h"
#import "JX_products.h"

@interface JXModel : NSObject
@property (nonatomic,strong)JX_data * data;

- (id)initWithDictionary:(NSDictionary * )dic;

@end
