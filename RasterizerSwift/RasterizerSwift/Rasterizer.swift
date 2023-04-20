//
//  Rasterizer.swift
//  RasterizerSwift
//
//  Created by Nigel Barber on 20/04/2023.
//

import Foundation
import CoreGraphics

class Rasterizer {
    typealias drawClosure = ((CGContext) -> Void)
    
    class Scene {
        required init?(draw: drawClosure) {
            guard let data = CFDataCreateMutable(nil, 0),
                  let consumer = CGDataConsumer(data: data),
                  let pdf = CGContext(consumer: consumer, mediaBox: nil, nil),
                  let layer = CGLayer(pdf, size: CGSize(width: 100, height: 100), auxiliaryInfo: nil),
                  let context = layer.context
            else {
                return nil
            }
            self.layer = layer
            draw(context)
        }
        func draw(ctx: CGContext) {
            guard let layer = layer else {
                return
            }
            ctx.draw(layer, at: .zero)
        }
        let layer: CGLayer?
    }
}
