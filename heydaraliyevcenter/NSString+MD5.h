//
//  NSDate+MD5.h
//  ECommpay
//
//  Created by Evgen Bakumenko on 10/22/13.
//  Copyright (c) 2013 Evgen Bakumenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString (MD5)
- (NSString*)md5;
@end
