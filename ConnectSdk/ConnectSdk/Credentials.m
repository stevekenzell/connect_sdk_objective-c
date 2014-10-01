//
//  Credentials.m
//  sdk
//

#import "Credentials.h"

@implementation Credentials
{
    NSString *apisecret;
    NSString *username;
    NSString *password;
    NSMutableDictionary *token;
}
@synthesize apiKey = _apiKey;
@synthesize accessToken = _accessToken;

-(NSDictionary*)GetAccessToken
{
    if (token == nil)
    {
        token = [[NSMutableDictionary alloc]init];
    }
    NSString * accessToken = [token valueForKeyPath:@"accessToken"];
    NSDate * expirationDate = [token valueForKeyPath:@"expiration"];
    
    if (accessToken != nil && expirationDate != nil  ) {
        
        NSDate *now = [NSDate date];
        NSDate *expiresDate = [now dateByAddingTimeInterval:-300];
        if (expirationDate >= expiresDate)
        {
            return token;
        }
    }
    NSAssert(_apiKey != @"", @"SYSTEM ID and SYSTEM PASSWORD are not set. Have you set the properties ApiKey and ApiSecret?");
    NSURL *url = [NSURL URLWithString:@"https://connect.gettyimages.com/oauth2/token"];
    
    NSString * credentials = [NSString stringWithFormat:@"client_id=%@&client_secret=%@", _apiKey, apisecret];
    
    NSString * grantType = @"client_credentials";
    
    if (username != nil)
    {
        grantType = @"password";
        credentials = [NSString stringWithFormat:@"client_id=%@&client_secret=%@&username=%@&password=%@", _apiKey, apisecret, username, password];
    }
    // Use APIKEY and APISecret to get Access token
    //PREPARE REQUEST
    NSString *requestBody = [NSString stringWithFormat:@"%@&grant_type=%@", credentials, grantType];
    
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[requestBody dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *responseError;
    NSURLResponse *response;
    
    //SEND REQUEST
    NSLog(@"calling Token...");
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
    NSLog(@"Finished token. Parsing data...");
    NSError *jsonParseError;
    NSMutableDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&jsonParseError];
    NSAssert(!jsonParseError, @"Error parsing JSON: %@", jsonParseError.description);
    
    NSDictionary *responseObject = [NSDictionary dictionaryWithDictionary:responseDictionary];
    
    NSString * AccessToken = [responseObject objectForKey: @"access_token"];
    NSString * expires = [responseObject objectForKey: @"expires_in"];
    double expiresSeconds = [expires doubleValue];
    NSDate *now = [NSDate date];
    NSDate *expiresDate = [now dateByAddingTimeInterval:expiresSeconds];
    [self setAccessToken:AccessToken];
    _accessToken = AccessToken;
    [token setObject:AccessToken forKey:@"accessToken"];
    [token setObject:expiresDate forKey:@"expiration"];
    
    return token;
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
