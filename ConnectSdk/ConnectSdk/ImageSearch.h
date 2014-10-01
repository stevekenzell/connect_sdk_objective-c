//
//  ImageSearch.h
//  sdk
//

#import <Foundation/Foundation.h>
#import "Credentials.h"

@interface ImageSearch : NSObject

-(id) initWithCredentials: (Credentials*) authorize;
-(ImageSearch *) withPhrase: (NSString*) phrase;
-(ImageSearch *) withResponseField: (NSString*) field;
-(ImageSearch *) withEditorialSegment: (NSString*) segment;
-(ImageSearch *) withGraphicalStyle: (NSString*) style;
-(ImageSearch *) withLicenseModel: (NSString*) licenseModel;
-(ImageSearch *) withOrientation: (NSString*) orientation;
-(ImageSearch *) withEmbeddableImages;
-(ImageSearch *) withExcludeNudity;
-(ImageSearch *) withPage: (int) pageNumber;
-(ImageSearch *) withPageSize: (int) pageSize;
-(ImageSearch *) Creative;
-(ImageSearch *) Editorial;
-(NSString *) BuildUrl;
-(NSDictionary *) Execute;
@end
