//
//  View.swift
//  RasterizerSwift
//
//  Created by Nigel Barber on 20/04/2023.
//

import Cocoa

func fract(_ n: Double) -> Double {
    n - floor(n)
}

class View: NSView, CALayerDelegate {
    var sceneList: Rasterizer.SceneList = [] {
        didSet {
            self.layer?.setNeedsDisplay()
        }
    }
    
    // MARK: - NSView
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        wantsLayer = true
        layer?.contentsFormat = .RGBA8Uint
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
            let count = 9
            let t = fract(CACurrentMediaTime() / interval)
            let size = self.bounds.size
            sceneList = (0...count).map({ i in
                let it = fract(t + Double(i) / Double(count))
                return .init(layer: layer, ctm: CGAffineTransformMakeTranslation(it * size.width, it * size.height))
            })
        }
    }
    
    static let featureSize = CGSize(width: 100, height: 100)
    
    let ellipse: CGLayer? = Rasterizer.createCGLayer(size: View.featureSize, drawClosure: { ctx in
        ctx.fillEllipse(in: CGRect(origin: .zero, size: View.featureSize))
    })
}
