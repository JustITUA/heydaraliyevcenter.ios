//
//  hcUserAccount.m
//  heydaraliyevcenter
//
//  Created by Anton Rogachevskiy on 6/14/14.
//  Copyright (c) 2014 JustIT. All rights reserved.
//

#import "hcUserAccount.h"

@implementation hcUserAccount

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"facebookId" : @"id",
             @"userName"   : @"name",
             @"userEmail"  : @"email",
             @"location"   : @"location"
             };
}

@end
