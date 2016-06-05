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
    var indicatorPoints: [CALayer] = []
    var statisticPopover: OMSimplePopoverView = OMSimplePopoverView()
    var popoverContentView: UIView?
//    var currentSnapPositionIndex: Int = 0 {
//        willSet {
//            if newValue != currentSnapPositionIndex {
//                guard let popoverContentView = popoverContentView else { return }
//                statisticPopover.removeFromSuperview()
//                print(newValue)
////                print(snappingPositions)
//                statisticPopover.setup(popoverContentView, self, snappingPositions[newValue])
//                print(snappingPositions[newValue])
//            }
//        }
//    }
    
    private lazy var indicatorImage: UIImage? = {
        return UIImage(named: "statistic_indicator_point")
    }()
    
    override func panBegan(location: CGPoint, _ currentOffsets: [CGPoint]) {
//        currentIndicatorPointLayers(currentOffsets)
    }
    
    override func panChanged(location: CGPoint, _ currentOffsets: [CGPoint]) {
        currentIndicatroLineLayer(currentOffsets)
        currentIndicatorPointLayers(currentOffsets)
        
//        print(currentOffsets.last)
//        let rPoint = currentOffsets.last!
//        let delta = rPoint.x / xFragment
//        
//        let intBit = Int(delta)
//        let decimalBit = delta - CGFloat(intBit)
//        
//        if decimalBit < 0.5 {
//            currentSnapPositionIndex = intBit
//        }else {
//            currentSnapPositionIndex = intBit + 1
//        }
//
//        if decimalBit < 0.2 {
//            statisticPopover.showWithInterativeParameter(1 - (decimalBit / 0.2))
//        }
//        
//        if decimalBit > 0.8 {
//            currentSnapPositionIndex = intBit + 1
//            statisticPopover.showWithInterativeParameter(1 - ((decimalBit - 0.8) / 0.2))
//        }
        
        
        
    }
    
    override func panEnded(location: CGPoint, _ currentOffsets: [CGPoint]) {
//        indicatorLine?.removeFromSuperlayer()
//        indicatorLine = nil
//        
//        for point in indicatorPoints {
//            point.removeFromSuperlayer()
//        }
//        indicatorPoints.removeAll()
    }
    
    
    private func currentIndicatroLineLayer(withCurrentOffsets: [CGPoint]) {
        
        indicatorLine?.removeFromSuperlayer()
        indicatorLine = nil

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
        layer.strokeColor = UIColor(white: 1, alpha: 0.58).CGColor
        layer.lineWidth = 2
        
        indicatorLine = layer
        
        self.layer.addSublayer(indicatorLine!)
        
    }
    
    private func currentIndicatorPointLayers(withCurrentOffsets: [CGPoint]) {
        
        guard let image = indicatorImage else { return }
        
        for point in indicatorPoints {
            point.removeFromSuperlayer()
        }
        indicatorPoints.removeAll()
        
        for item in withCurrentOffsets {
            let layer = CALayer()
            layer.frame = CGRect(origin: CGPointZero, size: image.size)
            layer.position = item
            layer.contents = image.CGImage
            self.indicatorPoints.append(layer)
            self.layer.addSublayer(layer)
        }
    }
    
    private func snapIndicator() {
//        snappingPositions
    }
    
}
