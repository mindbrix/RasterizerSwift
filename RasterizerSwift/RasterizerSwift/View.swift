//
//  View.swift
//  RasterizerSwift
//
//  Created by Nigel Barber on 20/04/2023.
//

import Cocoa

class View: NSView, CALayerDelegate {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        wantsLayer = true
        layer?.delegate = self
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    func draw(_ layer: CALayer, in ctx: CGContext) {
        ctx.fillEllipse(in: CGRect(x: 0, y: 0, width: 100, height: 100))
    }
    
}
