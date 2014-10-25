# Getty Images Connect SDK 

Seamlessly integrate Getty Images' expansive digital content, powerful search technology, and rich metadata into your publishing tools, products and services!

- Search for images from our extensive creative and editorial catalogs.
- Get image metadata.
- Download files using your Getty Images products (e.g., Editorial subscriptions, Easy Access, Thinkstock Subscriptions, and Image Packs).

## What's provided?
This solution contains two projects
* ConnectSdk - the SDK library
* ConnectSdkTests - tests for the SDK library

## Assumptions
* You have the latest XCode ide.
* You have "Getty Test" credentials from http://api.gettyimages.com
* Clone https://github.com/gettyimages/connect_sdk_objective-c

## Usage
* Add all the files in the ConnectSdk/ConnectSdk directory to your project
* Add the following code to your project.

```
#import "ConnnectSdk.h"
#import "ImageSearch.h"

- (void) execute{
    NSString* APIKEY=[[[NSProcessInfo processInfo]environment]objectForKey:@"ConnectSDK_ApiKey"];
    NSString* APISECRET=[[[NSProcessInfo processInfo]environment]objectForKey:@"ConnectSDK_ApiSecret"];
    ConnectSdk *connectSDK = [[ConnectSdk alloc] initWithApiKey:APIKEY andApiSecret:APISECRET];

    // connectSDK.Search().Images().withPhrase("dog")
    NSDictionary *imagesResponse = [[[[connectSDK Search] Images] withPhrase:@"dog"] Execute];
    NSLog(@"images :\n%@", imagesResponse);
    NSDictionary* images = [imagesResponse valueForKeyPath:@"images"];
	...
	}
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/ConnectSdk/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
