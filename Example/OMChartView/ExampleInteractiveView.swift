//
//  ExampleInteractiveView.swift
//  OMChartView
//
//  Created by HuangKun on 16/6/3.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit
import OMChartView

class ExampleInteractiveView: OMChartInteractiveView {
    var indicatorLine: CALayer?
    
    override func panBegan(location: CGPoint, _ currentOffsets: [CGPoint]) {
//        indicatorLine = currentIndicatroLineLayer(currentOffsets)
//        self.layer.addSublayer(indicatorLine!)
    }
    
    override func panChanged(location: CGPoint, _ currentOffsets: [CGPoint]) {
        indicatorLine?.removeFromSuperlayer()
        indicatorLine = nil
        
        
        indicatorLine = currentIndicatroLineLayer(currentOffsets)
            print(currentOffsets)
        self.layer.addSublayer(indicatorLine!)
    }
    
    override func panEnded(location: CGPoint, _ currentOffsets: [CGPoint]) {
        indicatorLine?.removeFromSuperlayer()
        indicatorLine = nil
    }
    
    
    private func currentIndicatroLineLayer(withCurrentOffsets: [CGPoint]) -> CALayer {

        let path = CGPathCreateMutable()
        
        for (index, offset) in withCurrentOffsets.enumerate() {
            if index == 0 {
                CGPathMoveToPoint(path, nil, offset.x, offset.y)
            }else {
                CGPathAddLineToPoint(path, nil, offset.x, offset.y)
            }
        }
        
        let layer = CAShapeLayer()
        layer.path = path
        layer.strokeColor = UIColor.yellowColor().CGColor
        layer.lineWidth = 2
        
        return layer
    }
}
