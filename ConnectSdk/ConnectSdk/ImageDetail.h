//
//  ImageDetail.h
//  sdk
//

#import <Foundation/Foundation.h>
#import "FluentRequest.h"

@interface ImageDetail : FluentRequest
-(id)init:(NSString*)destination initWithCredentials:(Credentials*)authorize;
-(ImageDetail *) withId: (NSString*) id;
-(ImageDetail *) withResponseField: (NSString*) field;
@end
