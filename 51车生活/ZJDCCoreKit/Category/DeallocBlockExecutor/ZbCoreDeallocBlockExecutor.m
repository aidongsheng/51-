//
//  DeallocBlockExecutor.m
//  DKNightVersion
//
//  Created by nathanwhy on 16/2/24.
//  Copyright © 2016年 Draveness. All rights reserved.
//

#import "ZbCoreDeallocBlockExecutor.h"

@implementation ZbCoreDeallocBlockExecutor

+ (instancetype)executorWithDeallocBlock:(void (^)())deallocBlock {
    ZbCoreDeallocBlockExecutor *o = [ZbCoreDeallocBlockExecutor new];
    o.deallocBlock = deallocBlock;
    return o;
}

- (void)dealloc {
    if (self.deallocBlock) {
        self.deallocBlock();
        self.deallocBlock = nil;
    }
}
@end
