//
//  OMCircleLayer.swift
//  Pods
//
//  Created by HuangKun on 16/6/2.
//
//

import UIKit

class OMCircleLayer: OMChartLayer {
    
    var circleRadius: CGFloat = 1
    
    func withRadius(value: CGFloat) -> OMChartLayer {
        circleRadius = value
        return self
    }
    
    override func refineLayer(withRect: CGRect, _ andRectInset: UIEdgeInsets) -> OMChartLayer {
        if path == nil { path = OMCirclePath(chartStatisticData, circleRadius) }
        super.refineLayer(withRect, andRectInset)
        return self
    }
    
    override func draw() -> OMChartLayer {
        drawPoinst()
        return self
    }
    
    private func drawPoinst() {
        let rpath = path!.path()
        for point in path!.flipPointsPositon {
            let pointLayer = CAShapeLayer()
            pointLayer.frame = CGPathGetPathBoundingBox(rpath)
            pointLayer.path = rpath
            pointLayer.fillColor = fillColor.CGColor
            pointLayer.position = point
            self.addSublayer(pointLayer)
        }
    }
    
    
}
