//
//  SliceCGContext.m
//  RasterizerSwift
//
//  Created by Nigel Barber on 21/04/2023.
//

#import "SliceCGContext.h"


@implementation ContextWrapper
@end

@implementation Slicer

+ (NSArray<ContextWrapper *> *)sliceCGContext:(CGContextRef)ctx into:(NSInteger)sliceCount {
    return @[[ContextWrapper new]];
}

@end


