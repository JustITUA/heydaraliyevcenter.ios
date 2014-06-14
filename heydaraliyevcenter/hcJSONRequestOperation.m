#import "hcJSONRequestOperation.h"

@implementation hcJSONRequestOperation

+ (instancetype)JSONRequestOperationWithRequest:(NSURLRequest *)urlRequest
										success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, id JSON))success
										failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON))failure
{

    hcJSONRequestOperation *requestOperation = [super JSONRequestOperationWithRequest:urlRequest
      success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"\n\n%@ \n%@\n-",[response URL], JSON);
        success(request, response, JSON);
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"statuscode - %d", [response statusCode]);
        NSLog(@"\n\n%@ \n%@\n-",[response URL], JSON);
        failure(request, response, error, JSON);
    }];
    return requestOperation;
}


@end
