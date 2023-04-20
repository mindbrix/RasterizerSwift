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
    
    class Scene {
        required init?(drawClosure: DrawClosure) {
            guard let data = CFDataCreateMutable(nil, 0),
                  let consumer = CGDataConsumer(data: data),
                  let pdf = CGContext(consumer: consumer, mediaBox: nil, nil),
                  let layer = CGLayer(pdf, size: CGSize(width: 100, height: 100), auxiliaryInfo: nil),
                  let context = layer.context
            else {
                return nil
            }
            self.layer = layer
            drawClosure(context)
        }
        let layer: CGLayer?
    }
    
    struct Element {
        let scene: Scene
        let ctm: CGAffineTransform
    }
    
    typealias SceneList = [Element]
    
    
    static func drawList(list: SceneList, in ctx: CGContext) {
        for element in list {
            ctx.saveGState()
            ctx.concatenate(element.ctm)
            if let layer = element.scene.layer {
                ctx.draw(layer, at: .zero)
            }
            ctx.restoreGState()
        }
    }
}
