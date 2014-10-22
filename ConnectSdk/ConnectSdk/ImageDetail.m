//
//  ImageDetail.m
//  sdk
//

#import "ImageDetail.h"
#import "Credentials.h"

@implementation ImageDetail
{
    Credentials* credentials;
}

-(id)init:(NSString*)destination initWithCredentials:(Credentials*)authorize {
    self = [super init:destination withCredentials:authorize];
    [self setRoute:@"/images"];
    requestParameters = [[NSMutableDictionary alloc] init];
    return self;
}

-(void) setCredentials:(Credentials *)authorization
{
    credentials = authorization;
}
-(ImageDetail*) withId:(NSString *)id
{
    [requestParameters setObject:id forKey:@"id"];
    return self;
}
-(ImageDetail*) withResponseField:(NSString *)field
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

@end
