//
//  View.swift
//  RasterizerSwift
//
//  Created by Nigel Barber on 20/04/2023.
//

import Cocoa

class View: NSView, CALayerDelegate {
    var sceneList: Rasterizer.SceneList = [] {
        didSet {
            self.layer?.setNeedsDisplay()
        }
    }
    
    static let DrawEllipse: Rasterizer.DrawClosure = { ctx in
        ctx.fillEllipse(in: CGRect(x: 0, y: 0, width: 100, height: 100))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        wantsLayer = true
        layer?.delegate = self
        if let layer = Rasterizer.createLayer(drawClosure: Self.DrawEllipse) {
            sceneList = [.init(layer: layer, ctm: .identity)]
        }
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
    func draw(_ layer: CALayer, in ctx: CGContext) {
        Rasterizer.drawList(list: sceneList, in: ctx)
    }

}
