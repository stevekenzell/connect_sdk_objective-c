//
//  ConnectSdk.h
//  ConnectSdk
//

#import <Foundation/Foundation.h>
#import "ImageSearch.h"
#import "ImageDetail.h"
#import "Download.h"
#import "Credentials.h"

@interface ConnectSdk : NSObject
-(id) initWithApiKey: (NSString*) apiKey andApiSecret: (NSString*) apiSecret;
-(id) initWithApiKey: (NSString*) apiKey andApiSecret: (NSString*) apiSecret andUserName: (NSString*) userName andUserPassword: (NSString*) userPassword;
-(ConnectSdk *) Search;
-(ImageSearch *) Images;
-(ImageDetail *) Image;
-(Download *) Download;
-(NSDictionary *) GetAccessToken;
-(void) setApiKey: (NSString*) apiKey;
-(void) setApiSecret: (NSString*) apiSecret;
-(void) setUsername: (NSString*) userName;
-(void) setPassword: (NSString*) passWord;
@end
