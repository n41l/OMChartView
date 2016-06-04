//
//  OMChartLayer.swift
//  Pods
//
//  Created by HuangKun on 16/6/2.
//
//

import UIKit

public class OMChartLayer: CALayer {
    var path: OMChartPath?
    public var strokeColor: UIColor = UIColor(white: 0.66, alpha: 1)
    public var lineWidth: CGFloat = 1
    public var lineCap: OMChartLayerLineCap = .Round
    public var fillColor: UIColor = UIColor.redColor()
    public var yCoordinateScale: CGFloat = 1
    
    var chartStatisticData: ChartStatisticData
    public init(_ withChartStatisticData: ChartStatisticData, _ andYCoordinateScale: CGFloat) {
        chartStatisticData = withChartStatisticData
        yCoordinateScale = andYCoordinateScale
        super.init()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        chartStatisticData = []
        super.init(coder: aDecoder)
    }
    
    func refineLayer(withRect: CGRect, _ andRectInset: UIEdgeInsets) -> OMChartLayer {
        let insetedRect = UIEdgeInsetsInsetRect(withRect, andRectInset)
        let tempRect = CGRect(x: andRectInset.left, y: andRectInset.top, width: insetedRect.width, height: insetedRect.height)
        path?.rSize = tempRect.size * CGPoint(x: 1, y: yCoordinateScale)
        self.frame = CGRect(origin: tempRect.origin + CGPoint(x: 0, y: tempRect.height * (1 - yCoordinateScale)), size: tempRect.size * CGPoint(x: 1, y: yCoordinateScale))
        return self
    }
    
    public func draw() -> OMChartLayer { return self }
}
