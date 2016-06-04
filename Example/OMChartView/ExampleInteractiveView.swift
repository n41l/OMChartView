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
    
    private lazy var indicatorImage: UIImage? = {
        return UIImage(named: "statistic_indicator_point")
    }()
    
    override func panBegan(location: CGPoint, _ currentOffsets: [CGPoint]) {
        currentIndicatorPointLayers(currentOffsets)
    }
    
    override func panChanged(location: CGPoint, _ currentOffsets: [CGPoint]) {
        indicatorLine?.removeFromSuperlayer()
        indicatorLine = nil
        
        indicatorLine = currentIndicatroLineLayer(currentOffsets)
        self.layer.addSublayer(indicatorLine!)
        
        for point in indicatorPoints {
            point.removeFromSuperlayer()
        }
        indicatorPoints.removeAll()
        currentIndicatorPointLayers(currentOffsets)
        
    }
    
    override func panEnded(location: CGPoint, _ currentOffsets: [CGPoint]) {
        indicatorLine?.removeFromSuperlayer()
        indicatorLine = nil
        
        for point in indicatorPoints {
            point.removeFromSuperlayer()
        }
        indicatorPoints.removeAll()
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
        layer.strokeColor = UIColor(white: 1, alpha: 0.58).CGColor
        layer.lineWidth = 2
        
        return layer
    }
    
    private func currentIndicatorPointLayers(withCurrentOffsets: [CGPoint]) {
//        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) { 
//            UIGraphicsBeginImageContext(CGSize(width: 20, height: 20))
//            UIImage(named: "statistic_indicator_point")?.drawInRect(CGRect(origin: CGPointZero, size: CGSize(width: 20, height: 20)))
//            let image = UIGraphicsGetImageFromCurrentImageContext()
//            
//            dispatch_async(dispatch_get_main_queue(), { 
//                for item in withCurrentOffsets {
//                    let layer = CALayer()
//                    layer.frame = CGRect(origin: CGPointZero, size: image.size)
//                    layer.position = item
//                    layer.contents = image.CGImage
//                    self.indicatorPoints.append(layer)
//                    self.layer.addSublayer(layer)
//                }
//            })
//        }
        
        guard let image = indicatorImage else { return }
        
        for item in withCurrentOffsets {
            let layer = CALayer()
            layer.frame = CGRect(origin: CGPointZero, size: image.size)
            layer.position = item
            layer.contents = image.CGImage
            self.indicatorPoints.append(layer)
            self.layer.addSublayer(layer)
        }
    }
    
}
