//
//  NSObject+DeallocBlock.m
//  DKNightVersion
//
//  Created by nathanwhy on 16/2/24.
//  Copyright © 2016年 Draveness. All rights reserved.
//

#import "NSObject+ZbCoreDeallocBlock.h"
#import "ZbCoreDeallocBlockExecutor.h"
#import <objc/runtime.h>

static void *kNSObject_DeallocBlocks;

@implementation NSObject (ZbCoreDeallocBlock)

- (id)zbcore_addDeallocBlock:(void (^)())deallocBlock {
    if (deallocBlock == nil) {
        return nil;
    }
    
    NSMutableArray *deallocBlocks = objc_getAssociatedObject(self, &kNSObject_DeallocBlocks);
    if (deallocBlocks == nil) {
        deallocBlocks = [NSMutableArray array];
        objc_setAssociatedObject(self, &kNSObject_DeallocBlocks, deallocBlocks, OBJC_ASSOCIATION_RETAIN);
    }
    // Check if the block is already existed
    for (ZbCoreDeallocBlockExecutor *executor in deallocBlocks) {
        if (executor.deallocBlock == deallocBlock) {
            return nil;
        }
    }
    
    ZbCoreDeallocBlockExecutor *executor = [ZbCoreDeallocBlockExecutor executorWithDeallocBlock:deallocBlock];
    [deallocBlocks addObject:executor];
    return executor;
}

@end
