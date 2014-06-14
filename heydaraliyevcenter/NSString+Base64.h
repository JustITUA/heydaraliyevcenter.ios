//
//  NSString+Base64.h
//  MBank
//
//  Created by Evgen Bakumenko on 2/3/14.
//  Copyright (c) 2014 Evgen Bakumenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Base64)

+ (NSString *)Base64EncodedStringFromString:(NSString *)string;

@end
