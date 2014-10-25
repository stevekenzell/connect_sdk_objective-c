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

-(id)init:(NSString*)destination initWithCredentials:(Credentials*)authorize {
    self = [super init:destination withCredentials:authorize];
    [self setRoute:@"/search/images"];
    requestParameters = [[NSMutableDictionary alloc] init];
    return self;
}

-(void) setCredentials:(Credentials *)authorization
{
    credentials = authorization;
}

-(ImageSearch*) withPhrase:(NSString *)phrase
{
    [requestParameters setObject:phrase forKey:@"phrase"];
    return self;
}
-(ImageSearch*) withEditorialSegment:(NSString *)segment
{
    NSMutableString * allSegments = [[NSMutableString alloc] init];
    NSDictionary * existingSegments = [requestParameters valueForKeyPath:@"editorial_segments"];
    if (existingSegments != nil)
    {
        allSegments = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@,%@",existingSegments,segment]];
    }
    else
    {
        allSegments = [NSMutableString stringWithString:segment];
    }
    [requestParameters setObject:allSegments forKey:@"editorial_segments"];
    return self;
}
-(ImageSearch*) withGraphicalStyle:(NSString *)style
{
    NSMutableString * allStyles = [[NSMutableString alloc] init];
    NSDictionary * existingStyles = [requestParameters valueForKeyPath:@"graphical_styles"];
    if (existingStyles != nil)
    {
        allStyles = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@,%@",existingStyles,style]];
    }
    else
    {
        allStyles = [NSMutableString stringWithString:style];
    }
    [requestParameters setObject:allStyles forKey:@"graphical_styles"];
    return self;
}
-(ImageSearch*) withResponseField:(NSString *)field
{
    NSMutableString * allFields = [[NSMutableString alloc] init];
    NSDictionary * existingFields = [requestParameters valueForKeyPath:@"fields"];
    if (existingFields != nil)
    {
        allFields = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@,%@",existingFields,field]];
    }
    else
    {
        allFields = [NSMutableString stringWithString:field];
    }
    [requestParameters setObject:allFields forKey:@"fields"];
    return self;
}

-(ImageSearch*) Creative
{
    [self setRoute:@"/search/images/creative"];
    return self;
}

-(ImageSearch*) Editorial
{
    [self setRoute:@"/search/images/editorial"];
    return self;
}
-(ImageSearch*) withEmbeddableImages
{
    [requestParameters setObject:@"true" forKey:@"embed_content_only"];
    return self;
}
-(ImageSearch*) withExcludeNudity
{
    [requestParameters setObject:@"true" forKey:@"exclude_nudity"];
    return self;
}
-(ImageSearch*) withLicenseModel:(NSString *)licenseModel
{
    [requestParameters setObject:licenseModel forKey:@"license_models"];
    return self;
}
-(ImageSearch*) withOrientation:(NSString *)orientation
{
    NSMutableString * allOrientations = [[NSMutableString alloc] init];
    NSDictionary * existingOrientations = [requestParameters valueForKeyPath:@"orientations"];
    if (existingOrientations != nil)
    {
        allOrientations = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@,%@",existingOrientations,orientation]];
    }
    else
    {
        allOrientations = [NSMutableString stringWithString:orientation];
    }
    [requestParameters setObject:allOrientations forKey:@"orientations"];
    return self;
}
-(ImageSearch*) withPageSize:(int)pageSize
{
    [requestParameters setObject:[NSString stringWithFormat:@"%d",pageSize] forKey:@"page_size"];
    return self;
}
-(ImageSearch*) withPage:(int)pageNumber
{
    [requestParameters setObject:[NSString stringWithFormat:@"%d",pageNumber] forKey:@"page"];
    return self;
}
@end