//
//  ImageDetail.m
//  sdk
//

#import "ImageDetail.h"
#import "Credentials.h"

@implementation ImageDetail
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
-(ImageDetail*) withId:(NSString *)id
{
    [QueryParameters setObject:id forKey:@"id"];
    return self;
}
-(ImageDetail*) withResponseField:(NSString *)field
{
    NSMutableString * allFields = [[NSMutableString alloc] init];
    NSDictionary * existingFields = [QueryParameters valueForKeyPath:@"fields"];
    if (existingFields != nil)
    {
        allFields = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@,%@",existingFields,field]];
    }
    else
    {
        allFields = [NSMutableString stringWithString:field];
    }
    [QueryParameters setObject:allFields forKey:@"fields"];
    return self;
}

-(NSString*) BuildUrl
{
    NSMutableString * url = [[NSMutableString alloc]init];
    url = [NSMutableString stringWithString:@"https://connect.gettyimages.com/v3/images"];
    // add id
    NSString* id = [QueryParameters valueForKeyPath:@"id"];
    if (id != nil)
    {
        [url appendString:[NSString stringWithFormat:@"/%@", id]];
    }
    // add response Fields
    NSDictionary* fields = [QueryParameters valueForKeyPath:@"fields"];
    if (fields != nil)
    {
        [url appendString:[NSString stringWithFormat:@"?fields=%@", fields]];
    }
    
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
    [request setHTTPMethod:@"GET"];
    
    NSError *responseError;
    NSURLResponse *response;
    
    //SEND REQUEST
    NSLog(@"calling image detail...");
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
        return nil;
    }
    
    // ATTEMPT TO PARSE THE RESPONSE AS JSON
    NSLog(@"Finished image detail. Parsing data...");
    NSError *jsonParseError;
    NSMutableDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&jsonParseError];
    NSAssert(!jsonParseError, @"Error parsing JSON: %@", jsonParseError.description);
    
    NSDictionary *responseObject = [NSDictionary dictionaryWithDictionary:responseDictionary];
    
    return responseObject;
}
@end
