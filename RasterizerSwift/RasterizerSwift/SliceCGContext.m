//
//  SliceCGContext.m
//  RasterizerSwift
//
//  Created by Nigel Barber on 21/04/2023.
//

#import "SliceCGContext.h"


@implementation ContextWrapper

- (instancetype)init:(CGContextRef)ctx {
    self = [super init];
    if (self) {
        self.ctx = CGContextRetain(ctx);
    }
    return self;
}

-(void)dealloc {
    CGContextRelease(self.ctx);
}

@end

@implementation Slicer

+ (NSArray<ContextWrapper *> *)sliceCGContext:(CGContextRef)ctx into:(NSInteger)sliceCount {
    return @[[[ContextWrapper alloc] init:ctx]];
}

@end


