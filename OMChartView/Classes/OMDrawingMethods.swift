//
//  OMDrawingMethods.swift
//  Pods
//
//  Created by HuangKun on 16/6/1.
//
//

import UIKit

// point calculation
func +(l: CGPoint, r: CGPoint) -> CGPoint {
    return CGPoint(x: l.x + r.x, y: l.y + r.y)
}

func -(l: CGPoint, r: CGPoint) -> CGPoint {
    return CGPoint(x: l.x - r.x, y: l.y - r.y)
}

func /(l: CGPoint, r: CGFloat) -> CGPoint {
    return CGPoint(x: l.x / r, y: l.y / r)
}

func *(l: CGPoint, r: CGFloat) -> CGPoint {
    return CGPoint(x: l.x * r, y: l.y * r)
}

// size calculation

func /(l: CGSize, r: CGFloat) -> CGSize {
    return CGSize(width: l.width/r, height: l.height/r)
}

func pointWithMaximalX(points: CGPoint...) -> CGPoint {
    return points.sort { $0.x > $1.x }.first!
}

func pointWithMaximalY(points: CGPoint...) -> CGPoint {
    return points.sort { $0.y > $1.y }.first!
}

func centerOfTwoPoints(p1: CGPoint, _ p2: CGPoint) -> CGPoint {
    return (p1 + p2) / 2
}

func CGPathMoveToPointWithoutCTM(_ path: CGMutablePath?, _ point: CGPoint) {
    CGPathMoveToPoint(path, nil, point.x, point.y)
}

/// always draw from left to right

func CGPathAddHorizontalCurveToPointWithoutCTM(_ path: CGMutablePath?, _ point: CGPoint) {
    let currentPoint = CGPathGetCurrentPoint(path)
    let center = centerOfTwoPoints(currentPoint, point)
    let cp1 = CGPoint(x: center.x, y: currentPoint.y)
    let cp2 = CGPoint(x: center.x, y: point.y)
    
    CGPathAddCurveToPoint(path, nil, cp1.x, cp1.y, cp2.x, cp2.y, point.x, point.y)
}

func CGPathAddVerticalCurveToPointWithoutCTM(_ path: CGMutablePath?, _ point: CGPoint) {
    let currentPoint = CGPathGetCurrentPoint(path)
    let center = centerOfTwoPoints(currentPoint, point)
    let cp1 = CGPoint(x: currentPoint.x, y: center.y)
    let cp2 = CGPoint(x: point.x, y: center.y)
    
    CGPathAddCurveToPoint(path, nil, cp1.x, cp1.y, cp2.x, cp2.y, point.x, point.y)
}

func bezierFunction(bParameter: BezierParameters) -> (t: CGFloat) -> CGPoint {
    let result = { (t: CGFloat) -> CGPoint in
        let p1 = bParameter.startPoint * pow((1 - t), 3)
        let p2 = bParameter.cp1 * (3 * t * pow((1 - t), 2))
        let p3 = bParameter.cp2 * (3 * pow(t, 2) * (1 - t))
        let p4 = bParameter.endPoint * pow(t, 3)
        
        return p1 + p2 + p3 + p4
    }
    return result
}