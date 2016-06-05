//
//  OMLinePath.swift
//  Pods
//
//  Created by HuangKun on 16/6/1.
//
//

import UIKit

class OMLinePath: OMChartPath {
    
    override func path() -> CGPath {
        guard _path == nil else { return _path! }
        _path = CGPathCreateMutable()
        for (index, item) in data.enumerate() {
            var tempPoint = CGPoint(x: CGFloat(index) * xFragment, y: refinedData(item) * yRatio)
            realPointsPosition.append(tempPoint)
            
            tempPoint.y = rSize.height - tempPoint.y
            if index == 0 {
                CGPathMoveToPointWithoutCTM(_path, tempPoint)
            }else {
                addHorizontalCurveToPointWithoutCTM(tempPoint)
            }
            flipPointsPosition.append(tempPoint)
        }
        return _path!
    }
    
    override func closedPath() -> CGPath {
        let path = CGPathCreateMutableCopy(_path ?? self.path())
        CGPathAddLineToPoint(path, nil, CGPathGetCurrentPoint(path).x, rSize.height + bottomExpand)
        CGPathAddLineToPoint(path, nil, 0, CGPathGetCurrentPoint(path).y)
        CGPathCloseSubpath(path)
        return path!
    }
    
    private func addHorizontalCurveToPointWithoutCTM(point: CGPoint) {
        let currentPoint = CGPathGetCurrentPoint(_path)
        let center = centerOfTwoPoints(currentPoint, point)
        let cp1 = CGPoint(x: center.x, y: currentPoint.y)
        let cp2 = CGPoint(x: center.x, y: point.y)
        allBezierParameters.append((currentPoint, cp1, cp2, point))
        
        CGPathAddCurveToPoint(_path, nil, cp1.x, cp1.y, cp2.x, cp2.y, point.x, point.y)
    }
}


