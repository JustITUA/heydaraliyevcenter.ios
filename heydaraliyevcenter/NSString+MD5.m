//
//  NSDate+MD5.m
//  ECommpay
//
//  Created by Evgen Bakumenko on 10/22/13.
//  Copyright (c) 2013 Evgen Bakumenko. All rights reserved.
//

#import "NSString+MD5.h"

@implementation NSString (MD5)

- (NSString*)md5 {
    const char* str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    
    NSMutableString* ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

@end
