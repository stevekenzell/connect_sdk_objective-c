//
//  DownloadTest.m
//  sdk

#import <XCTest/XCTest.h>
#import "ConnectSdk.h"
#import "Download.h"

@interface DownloadTest : XCTestCase
-(ConnectSdk*) getSDKWithClientCredentials1;

@end

@implementation DownloadTest

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

- (void)testDownloadWithClientCredentialsAuthorizations
{
    ConnectSdk *connectSDK = [self getSDKWithClientCredentials1];
    // connectSDK.Download().withId("452777084")
    NSDictionary *downloadResponse = [[[connectSDK Download] withId:@"452777084"] Execute];
    
    XCTAssertNotNil(downloadResponse, @"No error response returned");
    NSLog(@"error :\n%@", downloadResponse);
    NSDictionary* error = [downloadResponse valueForKeyPath:@"ErrorCode"];
    XCTAssertNotNil(error, @"error code is null");
}

- (void)testDownloadWithResourceOwnerAuthorizations
{
    NSString* APIKEY=[[[NSProcessInfo processInfo]environment]objectForKey:@"ConnectSDK_ApiKey"];
    NSString* APISECRET=[[[NSProcessInfo processInfo]environment]objectForKey:@"ConnectSDK_ApiSecret"];
    NSString* USERNAME=[[[NSProcessInfo processInfo]environment]objectForKey:@"ConnectSDK_UserName"];
    NSString* USERPASSWORD=[[[NSProcessInfo processInfo]environment]objectForKey:@"ConnectSDK_UserPassword"];
    ConnectSdk *connectSDK = [[ConnectSdk alloc] initWithApiKey:APIKEY andApiSecret:APISECRET andUserName:USERNAME andUserPassword:USERPASSWORD];
    // connectSDK.Download().withId("452777084")
    NSDictionary *downloadResponse = [[[connectSDK Download] withId:@"452777084"] Execute];
    NSDictionary* uri = [downloadResponse valueForKeyPath:@"uri"];
    XCTAssertNotNil(uri, @"uri is null");
}

-(ConnectSdk*) getSDKWithClientCredentials1{
    NSString* APIKEY=[[[NSProcessInfo processInfo]environment]objectForKey:@"ConnectSDK_ApiKey"];
    NSString* APISECRET=[[[NSProcessInfo processInfo]environment]objectForKey:@"ConnectSDK_ApiSecret"];
    ConnectSdk *connectSDK = [[ConnectSdk alloc] initWithApiKey:APIKEY andApiSecret:APISECRET];
    return connectSDK;
}
@end
