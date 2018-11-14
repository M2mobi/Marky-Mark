//
//  URLOpener.m
//  markymark
//
//  Created by Martin Höller on 14.11.18.
//

#import "URLOpener.h"

BOOL IsRunningAsAnExtension()
{
    // Per Apple, an extension will have a top level NSExtension dictionary in the info.plist
    // https://developer.apple.com/library/ios/documentation/General/Reference/InfoPlistKeyReference/Articles/SystemExtensionKeys.html
    
    static BOOL sIsExtension;
    static dispatch_once_t sOnceToken;
    dispatch_once(& sOnceToken, ^{
        NSDictionary *extensionDictionary = [[NSBundle mainBundle] infoDictionary][@"NSExtension"];
        sIsExtension = [extensionDictionary isKindOfClass:[NSDictionary class]];
    });
    return sIsExtension;
}

@implementation URLOpener
    
- (void)openURL:(NSURL *)url
    {
#if TARGET_OS_IPHONE
        if (IsRunningAsAnExtension()) {
            return;
        }
        
        Class UIApplicationClass = NSClassFromString(@"UIApplication");
        id sharedApplication = [UIApplicationClass sharedApplication];
        [sharedApplication performSelector:@selector(openURL:) withObject:url];
#endif
    }
    
    @end
