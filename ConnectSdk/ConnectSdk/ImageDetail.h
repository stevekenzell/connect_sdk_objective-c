//
//  ImageDetail.h
//  sdk
//

#import <Foundation/Foundation.h>
#import "Credentials.h"

@interface ImageDetail : NSObject
-(id) initWithCredentials: (Credentials*) authorize;
-(ImageDetail *) withId: (NSString*) id;
-(ImageDetail *) withResponseField: (NSString*) field;
-(NSString *) BuildUrl;
-(NSDictionary *) Execute;
@end
