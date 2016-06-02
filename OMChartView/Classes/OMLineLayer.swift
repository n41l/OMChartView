//
//  OMLineLayer.swift
//  Pods
//
//  Created by HuangKun on 16/6/2.
//
//

import UIKit

class OMLineLayer: OMChartLayer {
    
    var solid: Bool = false
    
    private var lineLayer: CAShapeLayer!
    private var contentLayer: CAShapeLayer?
    
    func isSolid(flag: Bool) -> OMChartLayer{
        self.solid = flag
        return self
    }
    
    override func draw() -> OMChartLayer {
        path = OMLinePath(path.data, path.rSize)
        drawContentLayer()
        drawLineLayer()
        return self
    }
    
    private func drawLineLayer() {
        lineLayer = CAShapeLayer()
        lineLayer.frame = self.bounds
        lineLayer.path = path.path()
        lineLayer.strokeColor = strokeColor.CGColor
        lineLayer.lineWidth = lineWidth
        lineLayer.lineCap = lineCap.rawValue
        lineLayer.fillColor = UIColor.clearColor().CGColor
        lineLayer.backgroundColor = UIColor.clearColor().CGColor
        self.addSublayer(lineLayer)
    }
    
    private func drawContentLayer() {
        guard solid else { return }
        contentLayer = CAShapeLayer()
        contentLayer?.frame = self.bounds
        contentLayer?.path = path.closedPath()
        contentLayer?.fillColor = fillColor.CGColor
        contentLayer?.backgroundColor = UIColor.clearColor().CGColor
        self.addSublayer(contentLayer!)
        
    }
    
    private func lineAnimation() {
        let lineAnimation = CABasicAnimation(keyPath: "strokeEnd")
        lineAnimation.duration = 3
        lineAnimation.fromValue = 0
        lineAnimation.toValue = 1.0
        lineLayer.addAnimation(lineAnimation, forKey: "lineAnimation")
    }
}