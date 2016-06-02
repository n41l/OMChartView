//
//  OMChartLayer.swift
//  Pods
//
//  Created by HuangKun on 16/6/2.
//
//

import UIKit

class OMChartLayer: CALayer {
    var path: OMChartPath
    var strokeColor: UIColor = UIColor(white: 0.66, alpha: 1)
    var lineWidth: CGFloat = 1
    var lineCap: OMChartLayerLineCap = .Round
    var fillColor: UIColor = UIColor.redColor()
    
    init(_ withChartStatisticData: ChartStatisticData, _ andReferenceSize: CGSize) {
        path = OMChartPath(withChartStatisticData, andReferenceSize)
        super.init()
        self.frame = CGRect(x: 0, y: 0, width: andReferenceSize.width, height: andReferenceSize.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        path = OMChartPath([], CGSizeZero)
        super.init(coder: aDecoder)
    }
    
    func draw() -> OMChartLayer { return self }
}
