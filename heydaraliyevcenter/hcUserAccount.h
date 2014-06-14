//
//  hcUserAccount.h
//  heydaraliyevcenter
//
//  Created by Anton Rogachevskiy on 6/14/14.
//  Copyright (c) 2014 JustIT. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface hcUserAccount : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *facebookId;
@property (nonatomic, copy) NSString *userName;


@end
