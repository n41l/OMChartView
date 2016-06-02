//
//  OMCircleLayer.swift
//  Pods
//
//  Created by HuangKun on 16/6/2.
//
//

import UIKit

class OMCircleLayer: OMChartLayer {
    
    func withRadius(value: CGFloat) -> OMChartLayer {
        path = OMCirclePath(path.data, path.rSize, andRadius: value)
        return self
    }
    
    override func draw() -> OMChartLayer {
        drawPoinst()
        return self
    }
    
    private func drawPoinst() {
        let rpath = path.path()
        for point in path.flipPointsPositon {
            let pointLayer = CAShapeLayer()
            pointLayer.frame = CGPathGetPathBoundingBox(rpath)
            pointLayer.path = rpath
            pointLayer.fillColor = fillColor.CGColor
            pointLayer.position = point
            self.addSublayer(pointLayer)
        }
    }
    
    
}
