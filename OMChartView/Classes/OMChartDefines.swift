//
//  OMChartDefines.swift
//  Pods
//
//  Created by HuangKun on 16/6/2.
//
//

import UIKit

public typealias ChartStatisticData = [CGFloat]


public enum OMChartLayerLineCap: String {
    case Round = "round"
    case Butt = "butt"
    case Square = "square"
}

public typealias BezierParameters = (startPoint: CGPoint, cp1: CGPoint, cp2: CGPoint, endPoint: CGPoint)