//
//  ImageSearch.m
//  sdk
//


#import "ImageSearch.h"
#import "Credentials.h"

@implementation ImageSearch
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

-(ImageSearch*) withPhrase:(NSString *)phrase
{
    [QueryParameters setObject:phrase forKey:@"phrase"];
    return self;
}
-(ImageSearch*) withEditorialSegment:(NSString *)segment
{
    NSMutableString * allSegments = [[NSMutableString alloc] init];
    NSDictionary * existingSegments = [QueryParameters valueForKeyPath:@"editorial_segments"];
    if (existingSegments != nil)
    {
        allSegments = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@,%@",existingSegments,segment]];
    }
    else
    {
        allSegments = [NSMutableString stringWithString:segment];
    }
    [QueryParameters setObject:allSegments forKey:@"editorial_segments"];
    return self;
}
-(ImageSearch*) withGraphicalStyle:(NSString *)style
{
    NSMutableString * allStyles = [[NSMutableString alloc] init];
    NSDictionary * existingStyles = [QueryParameters valueForKeyPath:@"graphical_styles"];
    if (existingStyles != nil)
    {
        allStyles = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@,%@",existingStyles,style]];
    }
    else
    {
        allStyles = [NSMutableString stringWithString:style];
    }
    [QueryParameters setObject:allStyles forKey:@"graphical_styles"];
    return self;
}
-(ImageSearch*) withResponseField:(NSString *)field
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

-(ImageSearch*) Creative
{
    [QueryParameters setObject:@"/creative" forKey:@"assetType"];
    return self;
}

-(ImageSearch*) Editorial
{
    [QueryParameters setObject:@"/editorial" forKey:@"assetType"];
    return self;
}
-(ImageSearch*) withEmbeddableImages
{
    [QueryParameters setObject:@"true" forKey:@"embeddable"];
    return self;
}
-(ImageSearch*) withExcludeNudity
{
    [QueryParameters setObject:@"true" forKey:@"excludeNudity"];
    return self;
}
-(ImageSearch*) withLicenseModel:(NSString *)licenseModel
{
    [QueryParameters setObject:licenseModel forKey:@"licensemodel"];
    return self;
}
-(ImageSearch*) withOrientation:(NSString *)orientation
{
    NSMutableString * allOrientations = [[NSMutableString alloc] init];
    NSDictionary * existingOrientations = [QueryParameters valueForKeyPath:@"orientations"];
    if (existingOrientations != nil)
    {
        allOrientations = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@,%@",existingOrientations,orientation]];
    }
    else
    {
        allOrientations = [NSMutableString stringWithString:orientation];
    }
    [QueryParameters setObject:allOrientations forKey:@"orientations"];
    return self;
}
-(ImageSearch*) withPageSize:(int)pageSize
{
    [QueryParameters setObject:[NSString stringWithFormat:@"%d",pageSize] forKey:@"pagesize"];
    return self;
}
-(ImageSearch*) withPage:(int)pageNumber
{
    [QueryParameters setObject:[NSString stringWithFormat:@"%d",pageNumber] forKey:@"pagenumber"];
    return self;
}

-(NSString*) BuildUrl
{
    NSMutableString * url = [[NSMutableString alloc]init];
    url = [NSMutableString stringWithString:@"https://connect.gettyimages.com/v3/search/images"];
    // add assetType
    NSString* assetType = [QueryParameters valueForKeyPath:@"assetType"];
    if (assetType != nil)
    {
        [url appendString:[NSString stringWithFormat:@"%@", assetType]];
    }
    // add Phrase
    NSString* phrase = [QueryParameters valueForKeyPath:@"phrase"];
    if (phrase != nil)
    {
        NSString *escapedString = [phrase stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
        [url appendString:[NSString stringWithFormat:@"?phrase=%@", escapedString]];
    }
    // add Fields
    NSDictionary* fields = [QueryParameters valueForKeyPath:@"fields"];
    if (fields != nil)
    {
        [url appendString:[NSString stringWithFormat:@"&fields=%@", fields]];
    }
   
    // assetType editorial
    if ([assetType isEqualToString:@"/editorial"])
    {
        //  add editorial Segments
        NSDictionary* segments = [QueryParameters valueForKeyPath:@"editorial_segments"];
        if (segments != nil)
        {
            [url appendString:[NSString stringWithFormat:@"&editorial_segments=%@", segments]];
        }
    }
    //  add graphical styles
    NSDictionary* styles = [QueryParameters valueForKeyPath:@"graphical_styles"];
    if (styles != nil)
    {
        [url appendString:[NSString stringWithFormat:@"&graphical_styles=%@", styles]];
    }
    //  add embed_content_only flag
    NSString* embeddable = [QueryParameters valueForKeyPath:@"embeddable"];
    if ([embeddable isEqualToString:@"true"])
    {
        [url appendString:[NSString stringWithFormat:@"&embed_content_only=true"]];
    }
    //  add exclude nudity flag
    NSString* excludeNudity = [QueryParameters valueForKeyPath:@"excludeNudity"];
    if ([excludeNudity isEqualToString:@"true"])
    {
        [url appendString:[NSString stringWithFormat:@"&exclude_nudity=true"]];
    }
    // add license model
    NSDictionary* licensemodel = [QueryParameters valueForKeyPath:@"licensemodel"];
    if (licensemodel != nil)
    {
        [url appendString:[NSString stringWithFormat:@"&license_models=%@", licensemodel]];
    }
    // add orientations
    NSDictionary* orientations = [QueryParameters valueForKeyPath:@"orientations"];
    if (orientations != nil)
    {
        [url appendString:[NSString stringWithFormat:@"&orientations=%@", orientations]];
    }
    // add page number
    NSDictionary* pagenumber = [QueryParameters valueForKeyPath:@"pagenumber"];
    if (pagenumber != nil)
    {
        [url appendString:[NSString stringWithFormat:@"&page=%@", pagenumber]];
    }
    // add page size
    NSDictionary* pagesize = [QueryParameters valueForKeyPath:@"pagesize"];
    if (pagesize != nil)
    {
        [url appendString:[NSString stringWithFormat:@"&page_size=%@", pagesize]];
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
    NSLog(@"calling image Search...");
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
    NSLog(@"Finished image Search. Parsing data...");
    NSError *jsonParseError;
    NSMutableDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&jsonParseError];
    NSAssert(!jsonParseError, @"Error parsing JSON: %@", jsonParseError.description);
    
    NSDictionary *responseObject = [NSDictionary dictionaryWithDictionary:responseDictionary];
    
    return responseObject;
}
@end