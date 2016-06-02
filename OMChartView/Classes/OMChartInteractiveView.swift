//
//  OMChartInteractiveView.swift
//  Pods
//
//  Created by HuangKun on 16/6/2.
//
//

import UIKit

class OMChartInteractiveView: UIView {
    var panGestrue: UIPanGestureRecognizer
    var chartLayers: [OMChartLayer] = []
    var indicatorLine: CALayer?
//    var
    
    override init(frame: CGRect) {
        panGestrue = UIPanGestureRecognizer()
        super.init(frame: frame)
        panGestrue.addTarget(self, action: #selector(OMChartInteractiveView.handlePan(_:)))
        self.addGestureRecognizer(panGestrue)
    }
    
    required init?(coder aDecoder: NSCoder) {
        panGestrue = UIPanGestureRecognizer()
        super.init(coder: aDecoder)
        panGestrue.addTarget(self, action: #selector(OMChartInteractiveView.handlePan(_:)))
        self.addGestureRecognizer(panGestrue)
    }
    
    func appendLayers(layers: OMChartLayer...) {
        for item in layers {
            chartLayers.append(item)
        }
    }
    
    func handlePan(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .Began:
            let location = sender.locationInView(self)
            indicatorLine = currentLineLayer(location)
            self.layer.addSublayer(indicatorLine!)
            
        case .Changed:
            let location = sender.locationInView(self)
                indicatorLine?.removeFromSuperlayer()
                indicatorLine = nil
                indicatorLine = currentLineLayer(location)
                self.layer.addSublayer(indicatorLine!)
        default:
            break
        }
    }
    
    func currentLineLayer(atLocation: CGPoint) -> CALayer {
        let x = atLocation.x
        let offsets = chartLayers.map { (layer) -> CGPoint in
            let t = (x % layer.path.xFragment) / layer.path.xFragment
            let parameter = layer.path.bezierParameters(x)
            return bezierFunction(parameter)(t: t) + CGPoint(x: 0, y: 100)
            }.sort { $0.y < $1.y }
        
        let path = CGPathCreateMutable()
        CGPathAddEllipseInRect(path, nil, CGRect(x: 0, y: 0, width: 4, height: 4))
//        for (index, y) in yOffsets.enumerate() {
//            if index == 0 {
//                CGPathMoveToPoint(path, nil, x, y)
//            }else {
//                CGPathAddLineToPoint(path, nil, x, y)
//            }
//        }
        
        let layer = CAShapeLayer()
        layer.frame = CGPathGetPathBoundingBox(path)
        layer.path = path
        layer.strokeColor = UIColor.yellowColor().CGColor
        layer.lineWidth = 4
        layer.position = offsets.first!
        
        return layer
    }
    
}
