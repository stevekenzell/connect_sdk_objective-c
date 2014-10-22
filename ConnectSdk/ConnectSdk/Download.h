//
//  Download.h
//  sdk
//

#import <Foundation/Foundation.h>
#import "FluentRequest.h"

@interface Download : FluentRequest
-(id)init:(NSString*)destination initWithCredentials:(Credentials*)authorize;
//-(id) initWithCredentials: (Credentials*) authorize;
-(Download *) withId: (NSString*) id;
//-(NSString *) BuildUrl;
//-(NSDictionary *) Execute;

@end
