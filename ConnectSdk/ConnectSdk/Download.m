//
//  Download.m
//  sdk
//

#import "Download.h"
#import "Credentials.h"

@implementation Download
{
    NSMutableDictionary* QueryParameters;
    Credentials* credentials;
}

-(id) initWithCredentials:(Credentials *) authorize {
    if (self = [super init]){
        [self setCredentials:authorize];
    }
    QueryParameters = [[NSMutableDictionary alloc] init];
    return self;
}
-(void) setCredentials:(Credentials *)authorization
{
    credentials = authorization;
}

-(Download*) withId:(NSString *)id
{
    [QueryParameters setObject:id forKey:@"id"];
    return self;
}
-(NSString*) BuildUrl
{
    NSMutableString * url = [[NSMutableString alloc]init];
    url = [NSMutableString stringWithString:@"https://connect.gettyimages.com/v3/downloads"];
    // add id
    NSString* id = [QueryParameters valueForKeyPath:@"id"];
    if (id != nil)
    {
        [url appendString:[NSString stringWithFormat:@"/%@", id]];
    }
    [url appendString:[NSString stringWithFormat:@"?auto_download=false"]];
   
    return [NSString stringWithFormat:@"%@", url];
}
-(NSDictionary*) Execute
{
    NSString* rawURL = [self BuildUrl];
    NSURL *url = [NSURL URLWithString:rawURL];
    [credentials GetAccessToken];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:credentials.apiKey forHTTPHeaderField:@"Api-Key"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:[NSString stringWithFormat:@"Bearer %@", credentials.accessToken] forHTTPHeaderField:@"Authorization"];
    [request setHTTPMethod:@"POST"];
    
    NSError *responseError;
    NSURLResponse *response;
    
    //SEND REQUEST
    NSLog(@"calling download...");
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&responseError];
    //DEBUG: LOG OUT THE REPONSE
    //    NSLog(@"===================================================");
    //    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    //    NSLog(@"RESPONSE:\n%@",responseString);
    //    NSLog(@"===================================================");
    
    
    // CHECK FOR RESPONSE ERROR
    if (responseError)
    {
        NSLog(@"RESPONSE ERROR:\n%@",responseError.description);
        // setup dictionary and add error
        NSError *jsonError;
        NSDictionary *myDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&jsonError];
        return myDictionary;
    }
    
    // ATTEMPT TO PARSE THE RESPONSE AS JSON
    NSLog(@"Finished download. Parsing data...");
    NSError *jsonParseError;
    NSMutableDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&jsonParseError];
    NSAssert(!jsonParseError, @"Error parsing JSON: %@", jsonParseError.description);
    
    NSDictionary *responseObject = [NSDictionary dictionaryWithDictionary:responseDictionary];
    
    return responseObject;
}
@end
