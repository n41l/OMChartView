//
//  OMPath.swift
//  Pods
//
//  Created by HuangKun on 16/6/2.
//
//

import UIKit

class OMChartPath {
    var data: ChartStatisticData
    var rSize: CGSize = CGSizeZero
    
    var flipPointsPosition: [CGPoint] = []
    var realPointsPosition: [CGPoint] = []
    var allBezierParameters: [BezierParameters] = []
    var bottomExpand: CGFloat = 0

    
    var _path: CGMutablePath?
    
    init(_ withChartStatisticData: ChartStatisticData) {
        data = withChartStatisticData
    }
    
    func path() -> CGPath { return CGPathCreateMutable() }
    func closedPath() -> CGPath { return CGPathCreateMutable() }
    func refinedData(data: CGFloat) -> CGFloat {
        return data - nadir
    }
    
    func bezierParameters(xCoordinate: CGFloat) -> BezierParameters {
        guard allBezierParameters.count != 0 else { return (CGPointZero, CGPointZero, CGPointZero, CGPointZero) }
        
        var index = Int(xCoordinate / xFragment)
        
        if xCoordinate == rSize.width {
            index -= 1
        }
        
        return allBezierParameters[index]
    }
}

extension OMChartPath {
    var dataCount: CGFloat {
        get {
            return CGFloat(data.count)
        }
    }
    
    var peak: CGFloat {
        get {
            return data.sort { $0 > $1 }.first!
        }
    }
    
    var nadir: CGFloat {
        get {
            return data.sort { $0 > $1 }.last!
        }
    }
    
    var xFragment: CGFloat {
        get {
            return rSize.width / (dataCount - 1)
        }
    }
    
    var yRatio: CGFloat {
        get {
            return rSize.height / (peak - nadir)
        }
    }
}