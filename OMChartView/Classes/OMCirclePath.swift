//
//  OMCirclePath.swift
//  Pods
//
//  Created by HuangKun on 16/6/2.
//
//

import UIKit

class OMCirclePath: OMChartPath {
    var radius: CGFloat
    
    private var lastPoint: CGPoint?
    init(_ withChartStatisticData: ChartStatisticData, _ andReferenceSize: CGSize, andRadius: CGFloat) {
        radius = andRadius
        super.init(withChartStatisticData, andReferenceSize)
    }
    
    override func path() -> CGPath {
        let rRect = CGRect(x: 0, y: 0, width: radius, height: radius)
        for (index, item) in data.enumerate() {
            var tempPoint = CGPoint(x: CGFloat(index) * xFragment, y: refinedData(item) * yRatio)
            realPointsPositon.append(tempPoint)
            tempPoint.y = rSize.height - tempPoint.y
            flipPointsPositon.append(tempPoint)
            guard let lastPoint = lastPoint else { continue }
            let center = centerOfTwoPoints(lastPoint, tempPoint)
            let cp1 = CGPoint(x: center.x, y: lastPoint.y)
            let cp2 = CGPoint(x: center.x, y: tempPoint.y)
            
            allBezierParameters.append((lastPoint, cp1, cp2, tempPoint))

            self.lastPoint = tempPoint
            
        }
        let pointPath = CGPathCreateMutable()
        CGPathAddEllipseInRect(pointPath, nil, rRect)
        
        return pointPath
    }
}

