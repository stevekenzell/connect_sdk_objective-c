//
//  ImageSearch.h
//  sdk
//

#import <Foundation/Foundation.h>
#import "FluentRequest.h"

@interface ImageSearch : FluentRequest
-(id)init:(NSString*)destination initWithCredentials:(Credentials*)authorize;

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
@end
