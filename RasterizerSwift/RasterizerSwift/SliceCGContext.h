//
//  SliceCGContext.h
//  RasterizerSwift
//
//  Created by Nigel Barber on 21/04/2023.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface ContextWrapper : NSObject
@property(nonatomic) CGContextRef ctx;
@end

@interface Slicer : NSObject
+ (NSArray<ContextWrapper *> *)sliceCGContext:(CGContextRef)ctx into:(NSInteger)sliceCount;
@end
