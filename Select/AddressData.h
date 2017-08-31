//
//  AddressData.h
//  Select
//
//  Created by YaSha_Tom on 2017/8/30.
//  Copyright © 2017年 YaSha-Tom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressData : NSObject

+ (NSArray *)getAddressDataArray:(NSArray *)components  andDiction:(NSDictionary *)areaDic andArea:(BOOL) isArea;

@end
