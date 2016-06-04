
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
//    
//    public var xView: UIView?
//    public var yView: UIView?
    
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
        chartLayers.map { $0.refineLayer(self.bounds, rectInset).draw() }
    }

}
