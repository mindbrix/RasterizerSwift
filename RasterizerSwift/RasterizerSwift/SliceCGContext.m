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
    CGContextRef newCtx = CGBitmapContextCreate(CGBitmapContextGetData(ctx), CGBitmapContextGetWidth(ctx), CGBitmapContextGetHeight(ctx), CGBitmapContextGetBitsPerComponent(ctx), CGBitmapContextGetBytesPerRow(ctx), CGBitmapContextGetColorSpace(ctx), CGBitmapContextGetBitmapInfo(ctx));
    CGContextConcatCTM(newCtx, CGContextGetCTM(ctx));
    return @[[[ContextWrapper alloc] init:newCtx]];
}

@end


