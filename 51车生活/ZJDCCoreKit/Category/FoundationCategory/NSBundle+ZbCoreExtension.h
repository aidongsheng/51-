//
//  NSBundle+ZbCoreExtension.h
//  Pods
//
//  Created by Prewindemon on 2017/4/21.
//
//

#import <Foundation/Foundation.h>

@interface NSBundle (ZbCoreExtension)

+ (NSBundle *)zbcore_myLibraryBundle: (NSString *)bundleName forClass: (Class)bundleClass;

+ (NSURL *)zbcore_LibraryBundleURL: (NSString *)bundleName forClass: (Class)bundleClass;

@end
