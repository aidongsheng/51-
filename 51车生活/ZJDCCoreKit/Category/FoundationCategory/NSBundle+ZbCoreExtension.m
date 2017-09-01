//
//  NSBundle+ZbCoreExtension.m
//  Pods
//
//  Created by Prewindemon on 2017/4/21.
//
//

#import "NSBundle+ZbCoreExtension.h"


@implementation NSBundle (ZbCoreExtension)

+ (NSBundle *)zbcore_myLibraryBundle: (NSString *)bundleName forClass: (Class)bundleClass{
    NSURL *bundleURL = [self zbcore_LibraryBundleURL: bundleName forClass: bundleClass];
    if (bundleURL) {
        return [self bundleWithURL:bundleURL];
    }
    return nil;
}

+ (NSURL *)zbcore_LibraryBundleURL: (NSString *)bundleName forClass: (Class)bundleClass{
    NSBundle *bundle = [NSBundle bundleForClass:bundleClass];
    return [bundle URLForResource: bundleName withExtension:@"bundle"];
}
@end
