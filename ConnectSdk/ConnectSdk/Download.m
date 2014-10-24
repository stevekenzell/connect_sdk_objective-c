//
//  Download.m
//  sdk
//

#import "Download.h"
#import "Credentials.h"

@implementation Download
{
    Credentials* credentials;
}

-(id)init:(NSString*)destination initWithCredentials:(Credentials*)authorize {
    self = [super init:destination withCredentials:authorize];
    [self setRoute:@"/downloads"];
    requestParameters = [[NSMutableDictionary alloc] init];
    httpMethod = @"POST";
    return self;
}

-(void) setCredentials:(Credentials *)authorization
{
    credentials = authorization;
}

-(Download*) withId:(NSString *)id
{
    [requestParameters setObject:id forKey:@"id"];
    [requestParameters setObject:@"false" forKey:@"auto_download"];
    return self;
}
@end
