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
    
    // MARK: - NSView
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        wantsLayer = true
        layer?.delegate = self
        Timer.scheduledTimer(withTimeInterval: 1 / 60, repeats: true, block: { [weak self] _ in
            self?.update()
        })
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
    // MARK: - CALayerDelegate
    
    func draw(_ layer: CALayer, in ctx: CGContext) {
        Rasterizer.drawList(list: sceneList, in: ctx)
    }

    func update() {
        if let layer = ellipse {
            let interval: CFTimeInterval = 3
            let time = CACurrentMediaTime() / interval
            let t = time - floor(time)
            let size = self.bounds.size
            sceneList = [.init(layer: layer, ctm: CGAffineTransformMakeTranslation(t * size.width, t * size.height))]
        }
    }
    
    let ellipse: CGLayer? = Rasterizer.createCGLayer(drawClosure: View.DrawEllipse)
}
