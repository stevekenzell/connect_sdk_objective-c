//
//  Authenticate.m
//  sdk
//

#import <XCTest/XCTest.h>
#import "ConnectSdk.h"

@interface Authenticate : XCTestCase

@end

@implementation Authenticate

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExplicitClientCredentialsAuthorization
{
    NSString* APIKEY =[[[NSProcessInfo processInfo]environment]objectForKey:@"ConnectSDK_ApiKey"];
    NSString* APISECRET=[[[NSProcessInfo processInfo]environment]objectForKey:@"ConnectSDK_ApiSecret"];
    ConnectSdk *connectSDK = [[ConnectSdk alloc] initWithApiKey:APIKEY andApiSecret:APISECRET];
    
    NSDictionary *token = [connectSDK GetAccessToken];
    XCTAssertNotNil(token, @"Token is null");
    NSLog(@"Access Token:\n%@", token);
    NSString * accessToken = [token valueForKeyPath:@"accessToken"];
    NSDate * expirationDate = [token valueForKeyPath:@"expiration"];
    XCTAssertNotNil(accessToken, @"access token is null");
    XCTAssertNotNil(expirationDate, @"expiration date is null");
}

- (void)testExplicitResourceOwnerAuthorization
{
    NSString* APIKEY =[[[NSProcessInfo processInfo]environment]objectForKey:@"ConnectSDK_ApiKey"];
    NSString* APISECRET=[[[NSProcessInfo processInfo]environment]objectForKey:@"ConnectSDK_ApiSecret"];
    NSString* USERNAME=[[[NSProcessInfo processInfo]environment]objectForKey:@"ConnectSDK_UserName"];
    NSString* USERPASSWORD=[[[NSProcessInfo processInfo]environment]objectForKey:@"ConnectSDK_UserPassword"];
    ConnectSdk *connectSDK = [[ConnectSdk alloc] initWithApiKey:APIKEY andApiSecret:APISECRET andUserName:USERNAME andUserPassword:USERPASSWORD];
    
    NSDictionary *token = [connectSDK GetAccessToken];
    XCTAssertNotNil(token, @"Token is null");
    NSLog(@"Access Token:\n%@", token);
    NSString * accessToken = [token valueForKeyPath:@"accessToken"];
    NSDate * expirationDate = [token valueForKeyPath:@"expiration"];
    XCTAssertNotNil(accessToken, @"access token is null");
    XCTAssertNotNil(expirationDate, @"expiration date is null");
}
@end
