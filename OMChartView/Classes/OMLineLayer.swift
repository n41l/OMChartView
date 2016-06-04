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
    private var gradientContent: Bool = false
    
    private var lineLayer: CAShapeLayer!
    private var contentLayer: CALayer?
    private var maskLayer: CAShapeLayer?
    private var gradientContentSize: CGSize = CGSizeZero
    
    public func isSolid(flag: Bool) -> OMChartLayer{
        solid = flag
        return self
    }
    
    public func withGradient(sp: CGPoint, ep: CGPoint, colors: [UIColor]) -> OMChartLayer {
        solid = true
        gradientContent = true
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = sp
        gradientLayer.endPoint = ep
        gradientLayer.colors = colors.map { $0.CGColor }
        
        contentLayer = gradientLayer
        
        return self
    }
    
    override func refineLayer(withRect: CGRect, _ andRectInset: UIEdgeInsets) -> OMChartLayer {
        if path == nil { path = OMLinePath(chartStatisticData) }
        path?.bottomExpand = andRectInset.bottom

        super.refineLayer(withRect, andRectInset)
        
        if gradientContent { gradientContentSize = CGSize(width: self.bounds.width, height: self.bounds.height + andRectInset.bottom) }
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
        
        guard solid || gradientContent else { return }
        
        if solid && gradientContent {
            contentLayer?.frame = CGRect(origin: CGPointZero, size: gradientContentSize)
            maskLayer = CAShapeLayer()
            maskLayer?.frame = self.bounds
            maskLayer?.path = path!.closedPath()
            contentLayer?.mask = maskLayer
        }else {
            let tempLayer = CAShapeLayer()
            tempLayer.frame = self.bounds
            tempLayer.path = path!.closedPath()
            tempLayer.fillColor = fillColor.CGColor
            tempLayer.backgroundColor = UIColor.clearColor().CGColor
            contentLayer = tempLayer
        }
        
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