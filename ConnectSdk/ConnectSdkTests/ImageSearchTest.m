//
//  ImageSearch.m
//  sdk
//

#import <XCTest/XCTest.h>
#import "ConnectSdk.h"
#import "ImageSearch.h"

@interface ImageSearchTest : XCTestCase
-(ConnectSdk*) getSDKWithClientCredentials;
-(void) checkResponse: (NSObject * )imagesResponse;

@end

@implementation ImageSearchTest

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

- (void)testFindImagesWithClientCredentialsAuthorizations
{
    ConnectSdk *connectSDK = [self getSDKWithClientCredentials];
    // connectSDK.Search().Images().withPhrase("dog")
    NSDictionary *imagesResponse = [[[[connectSDK Search] Images] withPhrase:@"dog"] Execute];
    
    [self checkResponse: imagesResponse];
}
- (void)testFindImagesWithResourceOwnerAuthorizations
{
    NSString* APIKEY=[[[NSProcessInfo processInfo]environment]objectForKey:@"ConnectSDK_ApiKey"];
    NSString* APISECRET=[[[NSProcessInfo processInfo]environment]objectForKey:@"ConnectSDK_ApiSecret"];
    NSString* USERNAME=[[[NSProcessInfo processInfo]environment]objectForKey:@"ConnectSDK_UserName"];
    NSString* USERPASSWORD=[[[NSProcessInfo processInfo]environment]objectForKey:@"ConnectSDK_UserPassword"];
    ConnectSdk *connectSDK = [[ConnectSdk alloc] initWithApiKey:APIKEY andApiSecret:APISECRET andUserName:USERNAME andUserPassword:USERPASSWORD];
    // connectSDK.Search().Images().withPhrase("dog")

    NSDictionary *imagesResponse = [[[[connectSDK Search] Images] withPhrase:@"dog"] Execute];

    [self checkResponse: imagesResponse];
}
-(void)testFindCreativeImages
{
    ConnectSdk *connectSDK = [self getSDKWithClientCredentials];
    // connectSDK.Search().Images().Creative().withPhrase("dog")

    NSDictionary *images = [[[[[connectSDK Search] Images] Creative] withPhrase:@"dog"] Execute];
    XCTAssertNotNil(images, @"images is null");
    NSLog(@"images :\n%@", images);
}
-(void)testFindEditorialImages
{
    ConnectSdk *connectSDK = [self getSDKWithClientCredentials];

    // connectSDK.Search().Images().Editorial().withPhrase("dog")
    NSDictionary *imagesResponse = [[[[[connectSDK Search] Images] Editorial] withPhrase:@"dog"] Execute];
    [self checkResponse: imagesResponse];
}
-(void)testFindCreativeImagesWithTitles
{
    ConnectSdk *connectSDK = [self getSDKWithClientCredentials];
    // connectSDK.Search().Images().Creative().withPhrase("dog").withFields("title")
    
    NSDictionary *imagesResponse = [[[[[[connectSDK Search] Images] Creative] withPhrase:@"dog"] withResponseField:@"title"] Execute];
    XCTAssertNotNil(imagesResponse, @"images is null");
    NSLog(@"images :\n%@", imagesResponse);
    NSDictionary* images = [imagesResponse valueForKeyPath:@"images"];
    XCTAssertNotNil(images, @"images is null");
    NSDictionary* firstTitle = [images valueForKeyPath:@"title"][0];
    XCTAssertNotNil(firstTitle, @"first title is null");
}
-(void)testFindEditorialImagesWithTitles
{
    ConnectSdk *connectSDK = [self getSDKWithClientCredentials];
    
    // connectSDK.Search().Images().Editorial().withPhrase("dog").withResponseFields("title")
    NSDictionary *imagesResponse = [[[[[[connectSDK Search] Images] Editorial] withPhrase:@"dog"] withResponseField:@"title"] Execute];
    XCTAssertNotNil(imagesResponse, @"No images returned");
    NSLog(@"images :\n%@", imagesResponse);
    NSDictionary* images = [imagesResponse valueForKeyPath:@"images"];
    XCTAssertNotNil(images, @"images is null");
    NSDictionary* firstTitle = [images valueForKeyPath:@"title"][0];
    XCTAssertNotNil(firstTitle, @"first title is null");

}
-(void)testFindCreativeImagesWithAssetFamily
{
    ConnectSdk *connectSDK = [self getSDKWithClientCredentials];
    // connectSDK.Search().Images().Creative().withPhrase("dog").withResponseFields("asset_family")
    
    NSDictionary *imagesResponse = [[[[[[connectSDK Search] Images] Creative] withPhrase:@"dog"] withResponseField:@"asset_family"] Execute];
    XCTAssertNotNil(imagesResponse, @"No images response returned");
    NSLog(@"images :\n%@", imagesResponse);
    NSDictionary* images = [imagesResponse valueForKeyPath:@"images"];
    XCTAssertNotNil(images, @"images is null");
    NSDictionary* firstAssetFamily = [images valueForKeyPath:@"asset_family"][0];
    XCTAssertNotNil(firstAssetFamily, @"first asset family is null");
   
}
-(void)testFindEditorialImagesWithAssetFamily
{
    ConnectSdk *connectSDK = [self getSDKWithClientCredentials];
    
    // connectSDK.Search().Images().Editorial().withPhrase("dog").withResponseFields("asset_family")
    NSObject *imagesResponse = [[[[[[connectSDK Search] Images] Editorial] withPhrase:@"dog"] withResponseField:@"asset_family"] Execute];
    XCTAssertNotNil(imagesResponse, @"No images response returned");
    NSLog(@"images :\n%@", imagesResponse);
    NSDictionary* images = [imagesResponse valueForKeyPath:@"images"];
    XCTAssertNotNil(images, @"images is null");
    NSDictionary* firstAssetFamily = [images valueForKeyPath:@"asset_family"][0];
    XCTAssertNotNil(firstAssetFamily, @"first asset family is null");
}
-(void)testFindEditorialImagesUsingArchivalSegment
{
    ConnectSdk *connectSDK = [self getSDKWithClientCredentials];

    // connectSDK.Search().Images().Editorial().withPhrase("dog").withEditorialSegment("archival")
    NSObject *imagesResponse = [[[[[[connectSDK Search] Images] Editorial] withPhrase:@"All Vocabulary"] withEditorialSegment:@"archival"] Execute];
    [self checkResponse: imagesResponse];
}
-(void)testFindEditorialImagesUsingEntertainmentSegment
{
    ConnectSdk *connectSDK = [self getSDKWithClientCredentials];
    
    // connectSDK.Search().Images().Editorial().withPhrase("All Vocabulary").withEditorialSegment("entertainment")
    NSObject *imagesResponse = [[[[[[connectSDK Search] Images] Editorial] withPhrase:@"All Vocabulary"] withEditorialSegment:@"entertainment"] Execute];
    [self checkResponse: imagesResponse];
}
-(void)testFindEditorialImagesUsingNewsSegment
{
    ConnectSdk *connectSDK = [self getSDKWithClientCredentials];
    
    // connectSDK.Search().Images().Editorial().withPhrase("All Vocabulary").withEditorialSegment("news")
    NSObject *imagesResponse = [[[[[[connectSDK Search] Images] Editorial] withPhrase:@"All Vocabulary"] withEditorialSegment:@"news"] Execute];
    [self checkResponse: imagesResponse];
}
-(void)testFindEditorialImagesUsingPublicitySegment
{
    ConnectSdk *connectSDK = [self getSDKWithClientCredentials];
    
    // connectSDK.Search().Images().Editorial().withPhrase("dog").withEditorialSegment("publicity")
    NSObject *imagesResponse = [[[[[[connectSDK Search] Images] Editorial] withPhrase:@"All Vocabulary"] withEditorialSegment:@"publicity"] Execute];
    [self checkResponse: imagesResponse];
}
-(void)testFindEditorialImagesUsingRoyaltySegment
{
    ConnectSdk *connectSDK = [self getSDKWithClientCredentials];
    
    // connectSDK.Search().Images().Editorial().withPhrase("dog").withEditorialSegment("royalty")
    NSObject *imagesResponse = [[[[[[connectSDK Search] Images] Editorial] withPhrase:@"All Vocabulary"] withEditorialSegment:@"royalty"] Execute];
    [self checkResponse: imagesResponse];
}
-(void)testFindEditorialImagesUsingSportSegment
{
    ConnectSdk *connectSDK = [self getSDKWithClientCredentials];
    
    // connectSDK.Search().Images().Editorial().withPhrase("All Vocabulary").withEditorialSegment("sports")
    NSObject *imagesResponse = [[[[[[connectSDK Search] Images] Editorial] withPhrase:@"All Vocabulary"] withEditorialSegment:@"sport"] Execute];
    [self checkResponse: imagesResponse];
}
-(void)testFindCreativeImagesUsingFineArtGraphicalStyle
{
    ConnectSdk *connectSDK = [self getSDKWithClientCredentials];
    // connectSDK.Search().Images().Creative().withPhrase("All Vocabulary").withGraphicalStyle("fine_art")
    NSObject *imagesResponse = [[[[[[connectSDK Search] Images] Creative] withPhrase:@"All Vocabulary"] withGraphicalStyle:@"fine_art"] Execute];
    [self checkResponse: imagesResponse];
}
-(void)testFindCreativeImagesUsingPhotographyGraphicalStyle
{
    ConnectSdk *connectSDK = [self getSDKWithClientCredentials];
    // connectSDK.Search().Images().Creative().withPhrase("All Vocabulary").withGraphicalStyle("photography")
    NSObject *imagesResponse = [[[[[[connectSDK Search] Images] Creative] withPhrase:@"All Vocabulary"] withGraphicalStyle:@"photography"] Execute];
    [self checkResponse: imagesResponse];
}
-(void)testFindCreativeImagesUsingIllustrationGraphicalStyle
{
    ConnectSdk *connectSDK = [self getSDKWithClientCredentials];
    // connectSDK.Search().Images().Creative().withPhrase("All Vocabulary").withGraphicalStyle("illustration")
    NSObject *imagesResponse = [[[[[[connectSDK Search] Images] Creative] withPhrase:@"All Vocabulary"] withGraphicalStyle:@"illustration"] Execute];
    [self checkResponse: imagesResponse];
}
-(void)testFindEditorialImagesUsingPhotographyGraphicalStyle
{
    ConnectSdk *connectSDK = [self getSDKWithClientCredentials];
    // connectSDK.Search().Images().Editorial().withPhrase("All Vocabulary").withGraphicalStyle("photography")
    NSObject *imagesResponse = [[[[[[connectSDK Search] Images] Editorial] withPhrase:@"All Vocabulary"] withGraphicalStyle:@"photography"] Execute];
    [self checkResponse: imagesResponse];
}
-(void)testFindEditorialImagesUsingIllustrationGraphicalStyle
{
    ConnectSdk *connectSDK = [self getSDKWithClientCredentials];
    // connectSDK.Search().Images().Editorial().withPhrase("All Vocabulary").withGraphicalStyle("illustration")
    NSObject *imagesResponse = [[[[[[connectSDK Search] Images] Editorial] withPhrase:@"All Vocabulary"] withGraphicalStyle:@"illustration"] Execute];
    [self checkResponse: imagesResponse];
}
-(void)testFindCreativeImagesUsingFineArtAndPhotographyGraphicalStyle
{
    ConnectSdk *connectSDK = [self getSDKWithClientCredentials];
    // connectSDK.Search().Images().Creative().withPhrase("All Vocabulary").withGraphicalStyle("fine_art").withGraphicalStyle("photography")
    NSObject *imagesResponse = [[[[[[[connectSDK Search] Images] Creative] withPhrase:@"All Vocabulary"] withGraphicalStyle:@"fine_art"] withGraphicalStyle:@"photography"] Execute];
    [self checkResponse: imagesResponse];
}
-(void)testSearchForEmbeddableImages
{
    ConnectSdk *connectSDK = [self getSDKWithClientCredentials];
    // connectSDK.Search().Images().Creative().withPhrase("All Vocabulary").withEmbeddableImages
    NSObject *imagesResponse = [[[[[[connectSDK Search] Images] Creative] withPhrase:@"All Vocabulary"] withEmbeddableImages] Execute];
    [self checkResponse: imagesResponse];
}
-(void)testSearchForImagesExcludingNudity
{
    ConnectSdk *connectSDK = [self getSDKWithClientCredentials];
    // connectSDK.Search().Images().Creative().withPhrase("All Vocabulary").withExcludeNudity
    NSObject *imagesResponse = [[[[[[connectSDK Search] Images] Creative] withPhrase:@"All Vocabulary"] withExcludeNudity] Execute];
    [self checkResponse: imagesResponse];
}
-(void)testFindCreativeImagesUsingRoyaltyFreeLicenseModel
{
    ConnectSdk *connectSDK = [self getSDKWithClientCredentials];
    // connectSDK.Search().Images().Creative().withPhrase("dog").withLicenceModel("royalty_free")
    NSObject *imagesResponse = [[[[[[connectSDK Search] Images] Creative] withPhrase:@"dog"] withLicenseModel:@"royalty_free"] Execute];
    [self checkResponse: imagesResponse];
}
-(void)testFindCreativeImagesUsingRightsManagedLicenseModel
{
    ConnectSdk *connectSDK = [self getSDKWithClientCredentials];
    // connectSDK.Search().Images().Creative().withPhrase("dog").withLicenceModel("rights_managed")
    NSObject *imagesResponse = [[[[[[connectSDK Search] Images] Creative] withPhrase:@"dog"] withLicenseModel:@"rights_managed"] Execute];
    [self checkResponse: imagesResponse];
}
-(void)testFindCreativeImagesUsingHorizontalOrientation
{
    ConnectSdk *connectSDK = [self getSDKWithClientCredentials];
    // connectSDK.Search().Images().Creative().withPhrase("dog").withOrientation("horizontal")
    NSObject *imagesResponse = [[[[[[connectSDK Search] Images] Creative] withPhrase:@"dog"] withOrientation:@"horizontal"] Execute];
    [self checkResponse: imagesResponse];
}
-(void)testFindCreativeImagesUsingPanoramicHorizontalOrientation
{
    ConnectSdk *connectSDK = [self getSDKWithClientCredentials];
    // connectSDK.Search().Images().Creative().withPhrase("dog").withOrientation("panoramic_horizontal")
    NSObject *imagesResponse = [[[[[[connectSDK Search] Images] Creative] withPhrase:@"dog"] withOrientation:@"panoramic_horizontal"] Execute];
    [self checkResponse: imagesResponse];
}
-(void)testFindCreativeImagesUsingPanoramicVerticalOrientation
{
    ConnectSdk *connectSDK = [self getSDKWithClientCredentials];
    // connectSDK.Search().Images().Creative().withPhrase("dog").withOrientation("panoramic_vertical")
    NSObject *imagesResponse = [[[[[[connectSDK Search] Images] Creative] withPhrase:@"dog"] withOrientation:@"panoramic_vertical"] Execute];
    [self checkResponse: imagesResponse];
}
-(void)testFindCreativeImagesUsingSquareOrientation
{
    ConnectSdk *connectSDK = [self getSDKWithClientCredentials];
    // connectSDK.Search().Images().Creative().withPhrase("dog").withOrientation("square")
    NSObject *imagesResponse = [[[[[[connectSDK Search] Images] Creative] withPhrase:@"dog"] withOrientation:@"square"] Execute];
    [self checkResponse: imagesResponse];
}
-(void)testFindCreativeImagesUsingVerticalOrientation
{
    ConnectSdk *connectSDK = [self getSDKWithClientCredentials];
    // connectSDK.Search().Images().Creative().withPhrase("dog").withOrientation("vertical")
    NSObject *imagesResponse = [[[[[[connectSDK Search] Images] Creative] withPhrase:@"dog"] withOrientation:@"vertical"] Execute];
    [self checkResponse: imagesResponse];
}
-(void)testFindEditorialImagesUsingHorizontalOrientation
{
    ConnectSdk *connectSDK = [self getSDKWithClientCredentials];
    // connectSDK.Search().Images().Editorial().withPhrase("dog").withOrientation("horizontal")
    NSObject *imagesResponse = [[[[[[connectSDK Search] Images] Editorial] withPhrase:@"dog"] withOrientation:@"horizontal"] Execute];
    [self checkResponse: imagesResponse];
}
-(void)testFindEditorialImagesUsingPanoramicHorizontalOrientation
{
    ConnectSdk *connectSDK = [self getSDKWithClientCredentials];
    // connectSDK.Search().Images().Editorial().withPhrase("dog").withOrientation("panoramic_horizontal")
    NSObject *imagesResponse = [[[[[[connectSDK Search] Images] Editorial] withPhrase:@"dog"] withOrientation:@"panoramic_horizontal"] Execute];
    [self checkResponse: imagesResponse];
}
-(void)testFindEditorialImagesUsingPanoramicVerticalOrientation
{
    ConnectSdk *connectSDK = [self getSDKWithClientCredentials];
    // connectSDK.Search().Images().Editorial().withPhrase("dog").withOrientation("panoramic_vertical")
    NSObject *imagesResponse = [[[[[[connectSDK Search] Images] Editorial] withPhrase:@"dog"] withOrientation:@"panoramic_vertical"] Execute];
    [self checkResponse: imagesResponse];
}
-(void)testFindEditorialImagesUsingSquareOrientation
{
    ConnectSdk *connectSDK = [self getSDKWithClientCredentials];
    // connectSDK.Search().Images().Editorial().withPhrase("dog").withOrientation("square")
    NSObject *imagesResponse = [[[[[[connectSDK Search] Images] Editorial] withPhrase:@"dog"] withOrientation:@"square"] Execute];
    [self checkResponse: imagesResponse];
}
-(void)testFindEditorialImagesUsingVerticalOrientation
{
    ConnectSdk *connectSDK = [self getSDKWithClientCredentials];
    // connectSDK.Search().Images().Editorial().withPhrase("dog").withOrientation("vertical")
    NSObject *imagesResponse = [[[[[[connectSDK Search] Images] Editorial] withPhrase:@"dog"] withOrientation:@"vertical"] Execute];
    [self checkResponse: imagesResponse];
}
-(void)testFindImagesUsingHorizontalOrientation
{
    ConnectSdk *connectSDK = [self getSDKWithClientCredentials];
    // connectSDK.Search().Images().withPhrase("dog").withOrientation("horizontal")
    NSObject *imagesResponse = [[[[[connectSDK Search] Images] withPhrase:@"dog"] withOrientation:@"horizontal"] Execute];
    [self checkResponse: imagesResponse];
}
-(void)testFindImagesUsingPanoramicHorizontalOrientation
{
    ConnectSdk *connectSDK = [self getSDKWithClientCredentials];
    // connectSDK.Search().Images().withPhrase("dog").withOrientation("panoramic_horizontal")
    NSObject *imagesResponse = [[[[[connectSDK Search] Images] withPhrase:@"dog"] withOrientation:@"panoramic_horizontal"] Execute];
    [self checkResponse: imagesResponse];
}
-(void)testFindImagesUsingPanoramicVerticalOrientation
{
    ConnectSdk *connectSDK = [self getSDKWithClientCredentials];
    // connectSDK.Search().Images().withPhrase("dog").withOrientation("panoramic_vertical")
    NSObject *imagesResponse = [[[[[connectSDK Search] Images] withPhrase:@"dog"] withOrientation:@"panoramic_vertical"] Execute];
    [self checkResponse: imagesResponse];
}
-(void)testFindImagesUsingSquareOrientation
{
    ConnectSdk *connectSDK = [self getSDKWithClientCredentials];
    // connectSDK.Search().Images().withPhrase("dog").withOrientation("square")
    NSObject *imagesResponse = [[[[[connectSDK Search] Images] withPhrase:@"dog"] withOrientation:@"square"] Execute];
    [self checkResponse: imagesResponse];
}
-(void)testFindImagesUsingVerticalOrientation
{
    ConnectSdk *connectSDK = [self getSDKWithClientCredentials];
    // connectSDK.Search().Images().withPhrase("dog").withOrientation("vertical")
    NSObject *imagesResponse = [[[[[connectSDK Search] Images] withPhrase:@"dog"] withOrientation:@"vertical"] Execute];
    [self checkResponse: imagesResponse];
}
-(void)testFindMultipleCreativeImagesUsingPagingWithSameRequest
{
    ConnectSdk *connectSDK = [self getSDKWithClientCredentials];
    // connectSDK.Search().Images().withPhrase("dog").withPaging(1).withPageCount(5)
    ImageSearch *imagesRequest = [[[[connectSDK Search] Images] withPhrase:@"dog"] withPageSize:5];
    NSObject *imagesResponse = [[imagesRequest withPage:1] Execute];
    [self checkResponse: imagesResponse];
    
    // connectSDK.Search().Images().withPhrase("dog").withPaging(2).withPageCount(5)
    imagesResponse = [[imagesRequest withPage:2] Execute];
    
    [self checkResponse: imagesResponse];
}
-(ConnectSdk*) getSDKWithClientCredentials{
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
