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
    var rSize: CGSize
    
    var flipPointsPositon: [CGPoint] = []
    var realPointsPositon: [CGPoint] = []
    var allBezierParameters: [BezierParameters] = []

    
    var _path: CGMutablePath?
    
    init(_ withChartStatisticData: ChartStatisticData, _ andReferenceSize: CGSize) {
        data = withChartStatisticData
        rSize = andReferenceSize
    }
    
    func path() -> CGPath { return CGPathCreateMutable() }
    func closedPath() -> CGPath { return CGPathCreateMutable() }
    func refinedData(data: CGFloat) -> CGFloat {
        return data - nadir
    }
    
    func bezierParameters(xCoordinate: CGFloat) -> BezierParameters {
        guard allBezierParameters.count != 0 else { return (CGPointZero, CGPointZero, CGPointZero, CGPointZero) }
        return allBezierParameters[Int(floor(xCoordinate / xFragment))]
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