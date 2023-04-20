//
//  View.swift
//  RasterizerSwift
//
//  Created by Nigel Barber on 20/04/2023.
//

import Cocoa

class View: NSView, CALayerDelegate {
    static let DrawEllipse: Rasterizer.drawClosure = { ctx in
        ctx.fillEllipse(in: CGRect(x: 0, y: 0, width: 100, height: 100))
    }
    required init?(coder: NSCoder) {
        scene = Rasterizer.Scene(draw: Self.DrawEllipse)
        
        super.init(coder: coder)
        wantsLayer = true
        layer?.delegate = self
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    func draw(_ layer: CALayer, in ctx: CGContext) {
        guard let scene = scene else {
            return
        }
        scene.draw(ctx: ctx)
    }
    
    var scene: Rasterizer.Scene?
    
}
