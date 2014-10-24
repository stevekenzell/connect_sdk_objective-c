//
//  FluentRequest.m
//  ConnectSdk
//

#import <Foundation/Foundation.h>
#import "FluentRequest.h"

@implementation FluentRequest
-(NSMutableDictionary*) requestParameters {
    return requestParameters;
}

-(NSString*) hostAndBaseRoute {
    return hostAndBaseRoute;
}

-(NSString*) route {
    return route;
}

-(NSString*) httpMethod {
    return httpMethod;
}

-(Credentials*) credentials {
    return credentials;
}

-(void) setRequestParameters:(NSMutableDictionary *)value {
    requestParameters = value;
}

-(void) setRoute:(NSString *)value {
    route = value;
}
-(id)init:(NSString*) destination withCredentials:(Credentials *)creds {
    self = [super init];
    if(requestParameters == nil) {
        requestParameters = [[NSMutableDictionary alloc] init];
    }
    
    route = [[NSString alloc] init];
    
    hostAndBaseRoute = destination;
    credentials = creds;
    httpMethod = @"GET";
    return self;
}

-(id)init:(NSString *)destination withCredentials:(Credentials *)creds withRequestDetails:(NSMutableDictionary *)requestParams {
    requestParameters = requestParams;
    self = [self init:destination withCredentials:creds];
    return self;
}

-(NSDictionary*) Execute {
    
    NSString* requestString = [self buildRequestString];
    
    NSURL* url = [NSURL URLWithString:requestString];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPMethod:[self httpMethod]];
    
    [self appendAuthenticationHeadersToRequest:request];
    
    NSError* responseError;
    NSURLResponse* response;
    
    NSData* responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&responseError];
    
    if(responseError) {
        NSLog(@"RESPONSE ERROR:\n%@",responseError.description);
        // setup dictionary and add error
        NSError *jsonError;
        NSDictionary *myDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&jsonError];
        return myDictionary;
    }
    
    NSError* jsonParserError;
    NSMutableDictionary* responseDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&jsonParserError];
    
    return responseDictionary;
}

-(void) appendAuthenticationHeadersToRequest:(NSMutableURLRequest*)request {
    NSError* error = nil;
    
    [[self credentials] GetAccessToken:&error];
    NSString* authToken = credentials.accessToken;
    [request setValue:[[self credentials] apiKey] forHTTPHeaderField:@"Api-Key"];
    [request setValue:[NSString stringWithFormat:@"Bearer %@", authToken] forHTTPHeaderField:@"Authorization"];
}

/**Appends value to the request parameter as an array item. If the parameter doesn't exist
 it will be created */
-(void) addArrayValueToRequestParameters:(NSString*)requestParameter withValue:(id)value {
    if([[self requestParameters] objectForKey:requestParameter] == nil) {
        [[self requestParameters] setObject:[[NSMutableArray alloc] init] forKey:requestParameter];
    }
    
    NSMutableArray* requestParamArray = [requestParameters objectForKey:requestParameter];
    if(![requestParamArray containsObject:value]) {
        [requestParamArray addObject:value];
    }
}

-(void) addValueToRequestParameters:(NSString *)requestParameter withValue:(NSString *)value {
    [[self requestParameters] setObject:value forKey:requestParameter];
}

-(void) setHttpMethod:(NSString*)value {
    
}

-(NSString*) buildRequestString {
    
    NSMutableString* requestString = [[NSMutableString alloc] init];
    NSMutableArray* queryParameters = [[NSMutableArray alloc] init];
    
    [requestString appendString:[self hostAndBaseRoute]];
    [requestString appendString:[self route]];
    //
    // add id
    NSString* image = [requestParameters valueForKeyPath:@"id"];
    if (image != nil)
    {
        [requestString appendString:[NSString stringWithFormat:@"/%@", image]];
        [requestParameters removeObjectForKey:@"id"];
    }

    for (NSString* key in requestParameters) {
        id value = [requestParameters objectForKey:key];
        if([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSMutableArray class]])
        {
            value = [value componentsJoinedByString:@","];
            
        }
        
        [queryParameters addObject:[NSString stringWithFormat:@"%@=%@",key,value]];
    }
    if (queryParameters.count > 0)
    {
        [requestString appendString:@"/?"];
        [requestString appendString:[queryParameters componentsJoinedByString:@"&"]];
    }
    return requestString;
}
@end
