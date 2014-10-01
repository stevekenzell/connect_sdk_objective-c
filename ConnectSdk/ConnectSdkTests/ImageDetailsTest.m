//
//  ImageDetailsTest.m
//  sdk
//

#import <XCTest/XCTest.h>
#import "ConnectSdk.h"
#import "ImageDetail.h"

@interface ImageDetailsTest : XCTestCase
-(ConnectSdk*) getSDKWithClientCredentials1;

@end

@implementation ImageDetailsTest

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

- (void)testFindImageDetailsWithClientCredentialsAuthorizations
{
    ConnectSdk *connectSDK = [self getSDKWithClientCredentials1];
    // connectSDK.Images().withId("452777084")
    NSDictionary *imagesResponse = [[[connectSDK Image] withId:@"452777084"] Execute];
    [self checkResponse: imagesResponse];
}
- (void)testFindImagesWithResourceOwnerAuthorizations
{
    NSString* APIKEY=[[[NSProcessInfo processInfo]environment]objectForKey:@"ConnectSDK_ApiKey"];
    NSString* APISECRET=[[[NSProcessInfo processInfo]environment]objectForKey:@"ConnectSDK_ApiSecret"];
    NSString* USERNAME=[[[NSProcessInfo processInfo]environment]objectForKey:@"ConnectSDK_UserName"];
    NSString* USERPASSWORD=[[[NSProcessInfo processInfo]environment]objectForKey:@"ConnectSDK_UserPassword"];
    ConnectSdk *connectSDK = [[ConnectSdk alloc] initWithApiKey:APIKEY andApiSecret:APISECRET andUserName:USERNAME andUserPassword:USERPASSWORD];
    // connectSDK.Images().withId("452777084")
    NSDictionary *imagesResponse = [[[connectSDK Image] withId:@"452777084"] Execute];
    
    [self checkResponse: imagesResponse];
}
- (void)testFindImageDetailsWithSpecifiedFields
{
    ConnectSdk *connectSDK = [self getSDKWithClientCredentials1];
    // connectSDK.Images().withId("452777084").withResponseField("title").withResponseField("caption")
    NSDictionary *imagesResponse = [[[[[connectSDK Image] withId:@"452777084"] withResponseField:@"title"] withResponseField:@"caption"] Execute];
    [self checkResponse: imagesResponse];
}

-(ConnectSdk*) getSDKWithClientCredentials1{
    NSString* APIKEY=[[[NSProcessInfo processInfo]environment]objectForKey:@"ConnectSDK_ApiKey"];
    NSString* APISECRET=[[[NSProcessInfo processInfo]environment]objectForKey:@"ConnectSDK_ApiSecret"];
    ConnectSdk *connectSDK = [[ConnectSdk alloc] initWithApiKey:APIKEY andApiSecret:APISECRET];
    return connectSDK;
}
-(void) checkResponse: (NSObject *) imagesResponse
{
    XCTAssertNotNil(imagesResponse, @"No images response returned");
    NSLog(@"images :\n%@", imagesResponse);
    NSDictionary* images = [imagesResponse valueForKeyPath:@"images"];
    XCTAssertNotNil(images, @"images is null");
}
@end
