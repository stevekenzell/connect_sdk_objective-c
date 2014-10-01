
//
//  Credentials.h
//  sdk
//


#import <Foundation/Foundation.h>

@interface Credentials : NSObject
-(void) setApiSecret: (NSString*) apiSecret;
-(void) setUsername: (NSString*) userName;
-(void) setPassword: (NSString*) passWord;
-(NSDictionary *) GetAccessToken;

@property NSString* apiKey;
@property NSString* accessToken;

@end
