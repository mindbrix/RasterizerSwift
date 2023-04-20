//
//  View.swift
//  RasterizerSwift
//
//  Created by Nigel Barber on 20/04/2023.
//

import Cocoa

class View: NSView, CALayerDelegate {
    var sceneList: Rasterizer.SceneList {
        didSet {
            self.layer?.setNeedsDisplay()
        }
    }
    
    static let DrawEllipse: Rasterizer.DrawClosure = { ctx in
        ctx.fillEllipse(in: CGRect(x: 0, y: 0, width: 100, height: 100))
    }
    required init?(coder: NSCoder) {
        sceneList = Rasterizer.SceneList()
        super.init(coder: coder)
        wantsLayer = true
        layer?.delegate = self
        
        if let scene = Rasterizer.Scene(drawClosure: Self.DrawEllipse) {
            let list = Rasterizer.SceneList()
            list.elements = [.init(scene: scene, ctm: .identity)]
            sceneList = list
        }
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    func draw(_ layer: CALayer, in ctx: CGContext) {
        sceneList.draw(ctx: ctx)
    }

}
