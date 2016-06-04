
//
//  OMChartView.swift
//  Pods
//
//  Created by HuangKun on 16/6/1.
//
//

import UIKit


public class OMChartView: UIView {

    public var rectInset: UIEdgeInsets = UIEdgeInsetsZero
    
    public var xView: UIView?
    public var yView: UIView?
    
    private var chartLayers: [OMChartLayer] = []
    private var interactiveView: OMChartInteractiveView?
    
    public func appendChartLayers(layers: [OMChartLayer]) -> OMChartView {
        chartLayers = layers
        return self
    }
    
    public func withInteractiveView(view: OMChartInteractiveView) -> OMChartView {
        interactiveView = view
        interactiveView?.isInteractive = true
        return self
    }
    
    public func commit() -> OMChartView {
        refineLayers()
        if interactiveView == nil { interactiveView = OMChartInteractiveView(frame: self.bounds) }
        interactiveView?.frame = self.bounds
        interactiveView?.rectInset = rectInset
        interactiveView?.appendLayers(chartLayers)
        self.addSubview(interactiveView!)
        
        return self
    }
    
    private func refineLayers() {
        let temp = UIEdgeInsetsInsetRect(self.bounds, rectInset)
        chartLayers.map { $0.refineLayer(CGRect(x: rectInset.left, y: rectInset.top, width: temp.width, height: temp.height)).draw() }
    }

//    public override func drawRect(rect: CGRect) {
//        let lineLayer = OMLineLayer(statisticData, CGSize(width: self.bounds.width, height: self.bounds.height/2)).isSolid(true).draw()
//        lineLayer.frame = CGRect(origin: CGPoint(x: 0, y: self.bounds.height/2), size: lineLayer.bounds.size)
//        let points = OMCircleLayer(statisticData, CGSize(width: self.bounds.width, height: self.bounds.height/2)).withRadius(6)
//        points.frame = CGRect(origin: CGPoint(x: 0, y: self.bounds.height/2), size: points.bounds.size)
//        points.fillColor = UIColor.whiteColor()
//        points.draw()
//        let line2 = OMLineLayer([13, 42, 25, 37, 43, 24, 50], self.bounds.size)
//        line2.lineWidth = 4
//        line2.draw()
        
//        self.layer.addSublayer(lineLayer)
//        self.layer.addSublayer(points)
//        self.layer.addSublayer(line2)
        
//        interactiveView = OMChartInteractiveView(frame: self.bounds)
//        self.addSubview(interactiveView)
//    }

}
