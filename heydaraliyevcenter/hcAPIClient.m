#import "hcAPIClient.h"
#import <AFOAuth2Client.h>
#import "hcJSONRequestOperation.h"
#import <Mantle/MTLJSONAdapter.h>
#import <AFNetworking/AFImageRequestOperation.h>
#import <SSKeychain.h>
#import "NSString+Base64.h"

static NSString * const SERVER_DEV = @"http://localhost/heydaraliyevcenter/heydaraliyevcenter.api/index.php/api";
static NSString * const SERVER_PROD = @"https://api.mbank.ru";

static NSString * const kClientSecret = @"";

static NSString * const kTestPath = @"/test";
static NSString* hcAPIBaseURLString;

@implementation hcAPIClient

+ (instancetype)sharedClient {
    static hcAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // init server URL
        hcAPIBaseURLString = SERVER_DEV;
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:hcAPIBaseURLString]];
    });
    
    return _sharedClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    [self setDefaultHeader:@"HTTP_X_REQUESTED_WITH" value:@"xmlhttprequest"];
    __weak typeof(self) weakSelf = self;
    
    [self setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
        NSLog(@"status - %d", status);
        
        if (weakSelf.networkReachabilityStatus == AFNetworkReachabilityStatusReachableViaWWAN ||
            weakSelf.networkReachabilityStatus == AFNetworkReachabilityStatusReachableViaWiFi ) {
            
            NSLog(@"connection success");
        }
        else {
            NSLog(@"connection fail");
        }
    }];
    
    return self;
}


- (void)setBasicAuthForRequest:(NSMutableURLRequest *)request
{
    NSString * account = [[[SSKeychain accountsForService:kKeychainServiceName] objectAtIndex:0] objectForKey:@"acct"];
    NSString *basicAuthCredentials = [NSString stringWithFormat:@"%@:%@", account, [SSKeychain passwordForService:kKeychainServiceName account:account]];
     NSString *value = [NSString stringWithFormat:@"Basic %@", [NSString Base64EncodedStringFromString:basicAuthCredentials]];
     [request setValue:value forHTTPHeaderField:@"Authorization"];
}


- (void)checkConnection
{
    __weak typeof(self) weakSelf = self;
    [self setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
        NSLog(@"%d", status);
        
        if (weakSelf.networkReachabilityStatus == AFNetworkReachabilityStatusReachableViaWWAN ||
            weakSelf.networkReachabilityStatus == AFNetworkReachabilityStatusReachableViaWiFi ) {
            
            NSLog(@"connection");
        }
        else {
            NSLog(@"fail");
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Отсутствует подключение" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }];
}



#pragma mark - HTTP methods

- (void)testWithCompletion:(void(^)(BOOL, NSString *))completion
{
    NSMutableURLRequest* request = [self requestWithMethod:@"GET" path:[NSString stringWithFormat:@"%@%@", hcAPIBaseURLString,kTestPath] parameters:nil];
    hcJSONRequestOperation* operation = [hcJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        completion(YES, nil);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        completion(NO, JSON[@"error"][@"message"]);
    }];
    
    operation.JSONReadingOptions = NSJSONReadingAllowFragments;
    [operation start];
}






@end
