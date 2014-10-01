//
//  Download.h
//  sdk
//

#import <Foundation/Foundation.h>
#import "Credentials.h"

@interface Download : NSObject
-(id) initWithCredentials: (Credentials*) authorize;
-(Download *) withId: (NSString*) id;
-(NSString *) BuildUrl;
-(NSDictionary *) Execute;

@end
