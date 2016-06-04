//
//  OMLineLayer.swift
//  Pods
//
//  Created by HuangKun on 16/6/2.
//
//

import UIKit

public class OMLineLayer: OMChartLayer {
    
    private var solid: Bool = false
    
    private var lineLayer: CAShapeLayer!
    private var contentLayer: CAShapeLayer?
    
    public func isSolid(flag: Bool) -> OMChartLayer{
        solid = flag
        return self
    }
    
    override func refineLayer(withRect: CGRect, _ andRectInset: UIEdgeInsets) -> OMChartLayer {
        if path == nil { path = OMLinePath(chartStatisticData) }
        path?.bottomExpand = andRectInset.bottom
        super.refineLayer(withRect, andRectInset)
        return self
    }
    
    public override func draw() -> OMChartLayer {
        if solid {
            drawContentLayer()
        }else {
            drawLineLayer()
        }
        return self
    }
    
    private func drawLineLayer() {
        lineLayer = CAShapeLayer()
        lineLayer.frame = self.bounds
        lineLayer.path = path!.path()
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
        contentLayer?.path = path!.closedPath()
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