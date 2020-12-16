//
//  NSURL+BXH.m
//  BXHCategory
//
//  Created by baishuang on 2020/12/14.
//

#import "NSURL+BXH.h"

@implementation NSURL (BXH)

- (NSURL *)URLWithChangedHost:(NSString *)host {
    if (!host || host.length == 0) {
        return self;
    }
    NSURL *URL = self;
    if (URL.host && URL.host.length > 0 && URL.scheme && URL.scheme.length > 0) {
        NSString *currentScheme = URL.scheme;
        NSString *currentHost = URL.host;
        NSString *componentString = [NSString stringWithFormat:@"%@://%@", currentScheme, currentHost];
        NSString *path = [URL.absoluteString componentsSeparatedByString:componentString].lastObject;
        if (path && path.length > 0) {
            NSString *resultURLString = [NSString stringWithFormat:@"%@%@", host, path];
            return [NSURL URLWithString:resultURLString];
        }
    }
    return URL;
}

- (NSString *)relativeURLString {
    if (!self || !self.path) {
        return nil;
    }
    NSString *relativeURLString = self.path;
    if (self.query) {
        relativeURLString = [relativeURLString stringByAppendingFormat:@"?%@", self.query];
    }
    return relativeURLString;
}

@end
