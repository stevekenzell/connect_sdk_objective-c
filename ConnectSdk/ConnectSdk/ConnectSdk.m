//
//  ConnectSdk.m
//  ConnectSdk
//

#import "ConnectSdk.h"
#import "ImageSearch.h"
#import "ImageDetail.h"
#import "Download.h"

@implementation ConnectSdk
{
    NSString *apikey;
    NSString *apisecret;
    NSString *username;
    NSString *password;
    Credentials* authorize;
}

-(id) initWithApiKey: (NSString*) apiKey andApiSecret: (NSString*) apiSecret {
    if (self = [super init]){
        [self setApiKey:apiKey];
        [self setApiSecret:apiSecret];
    }
    //token = [[NSMutableDictionary alloc] init];
    authorize = [[Credentials alloc] init];
    [authorize setApiKey:apiKey];
    [authorize setApiSecret:apiSecret];
    return self;
}
-(id) initWithApiKey:(NSString*) apiKey andApiSecret:(NSString*) apiSecret andUserName:(NSString *) userName andUserPassword:(NSString *)userPassword{
    if (self = [super init]){
        [self setApiKey:apiKey];
        [self setApiSecret:apiSecret];
        [self setUsername:userName];
        [self setPassword:userPassword];
    }
    //token = [[NSMutableDictionary alloc] init];
    authorize = [[Credentials alloc] init];
    [authorize setApiKey:apiKey];
    [authorize setApiSecret:apiSecret];
    [authorize setUsername:userName];
    [authorize setPassword:userPassword];
    return self;
}

-(ConnectSdk*)Search{
    //[self GetAccessToken];
    return self;
}
-(ImageSearch*) Images{
    ImageSearch *imagesearch = [[ImageSearch alloc] initWithCredentials:authorize];
    return imagesearch;
}
-(ImageDetail*) Image{
    //[self GetAccessToken];
    ImageDetail *imagedetail = [[ImageDetail alloc] initWithCredentials:authorize];
    return imagedetail;
}
-(Download*) Download{
    //[self GetAccessToken];
    Download *download = [[Download alloc] initWithCredentials:authorize];
    return download;
}
-(NSDictionary*)GetAccessToken
{
    return [authorize GetAccessToken];
}

-(void) setApiKey: (NSString*) apiKey
{
    apikey = apiKey;
}

-(void) setApiSecret: (NSString*) apiSecret
{
    apisecret = apiSecret;
}

-(void) setUsername: (NSString*) userName
{
    username = userName;
}

-(void) setPassword: (NSString*) passWord
{
    password = passWord;
}
@end
