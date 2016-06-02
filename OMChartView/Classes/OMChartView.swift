
//
//  OMChartView.swift
//  Pods
//
//  Created by HuangKun on 16/6/1.
//
//

import UIKit


public class OMChartView: UIView {

    var statisticData: ChartStatisticData
//    public var rectInset: UIEdgeInsets = UIEdgeInsetsZero
    
    private var _chartLinePath: OMLinePath!
    private var _chartCirclePath: OMCirclePath!
    
    private var interactiveView: OMChartInteractiveView!
    
    public init(frame: CGRect, withStatisticData: ChartStatisticData) {
        statisticData = withStatisticData
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func drawRect(rect: CGRect) {
        let lineLayer = OMLineLayer(statisticData, CGSize(width: self.bounds.width, height: self.bounds.height/2)).isSolid(true).draw()
        lineLayer.frame = CGRect(origin: CGPoint(x: 0, y: self.bounds.height/2), size: lineLayer.bounds.size)
        let points = OMCircleLayer(statisticData, CGSize(width: self.bounds.width, height: self.bounds.height/2)).withRadius(6)
        points.frame = CGRect(origin: CGPoint(x: 0, y: self.bounds.height/2), size: points.bounds.size)
        points.fillColor = UIColor.whiteColor()
        points.draw()
        let line2 = OMLineLayer([13, 42, 25, 37, 43, 24, 50], self.bounds.size)
        line2.lineWidth = 4
        line2.draw()
        
        self.layer.addSublayer(lineLayer)
        self.layer.addSublayer(points)
        self.layer.addSublayer(line2)
        
        interactiveView = OMChartInteractiveView(frame: self.bounds)
        interactiveView.backgroundColor = UIColor.clearColor()
        interactiveView.appendLayers(lineLayer)
        self.addSubview(interactiveView)
    }

}
