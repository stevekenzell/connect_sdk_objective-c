//
//  FluentRequest.h
//  ConnectSdk
//

#import <Foundation/Foundation.h>
#import "Credentials.h"

@interface FluentRequest : NSObject
{
    NSMutableDictionary* requestParameters;
    NSString* hostAndBaseRoute;
    Credentials* credentials;
    NSString* route;
    NSString* httpMethod;
}

-requestParameters;
-hostAndBaseRoute;
-credentials;
-route;
-httpMethod;

-(void) setRequestParameters:(NSDictionary*)value;
-(void) setRoute:(NSString*)value;

-(id)init:(NSString*)destination withCredentials:(Credentials*)creds;
-(id)init:(NSString*)destination withCredentials:(Credentials*)creds withRequestDetails:(NSMutableDictionary*) requestParams;

-(void) addArrayValueToRequestParameters:(NSString*)requestParameter withValue:(id)value;
-(void) addValueToRequestParameters:(NSString*)requestParameter withValue:(NSString*)value;

-(void) setHttpMethod:(NSString*)value;

-(NSDictionary*) Execute;


@end
