//
//  Rasterizer.swift
//  RasterizerSwift
//
//  Created by Nigel Barber on 20/04/2023.
//

import Foundation
import CoreGraphics

class Rasterizer {
    typealias DrawClosure = ((CGContext) -> Void)
    
    struct Element {
        let layer: CGLayer
        let ctm: CGAffineTransform
    }
    
    typealias SceneList = [Element]
    
    static func createCGLayer(size: CGSize? = nil, drawClosure: DrawClosure) -> CGLayer? {
        guard let data = CFDataCreateMutable(nil, 0),
              let consumer = CGDataConsumer(data: data),
              let pdf = CGContext(consumer: consumer, mediaBox: nil, nil),
              let layer = CGLayer(pdf, size: size ?? CGSize(width: 100, height: 100), auxiliaryInfo: nil),
              let context = layer.context
        else {
            return nil
        }
        drawClosure(context)
        return layer
    }
    
    
    static let IterationCount = 0
    static func drawList(list: SceneList, in ctx: CGContext) {
        DispatchQueue.concurrentPerform(iterations: Self.IterationCount, execute: { i in
            print(i)
        })
        for element in list {
            ctx.saveGState()
            ctx.concatenate(element.ctm)
            ctx.draw(element.layer, at: .zero)
            ctx.restoreGState()
        }
    }
}
