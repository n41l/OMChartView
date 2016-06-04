//
//  OMChartInteractiveView.swift
//  Pods
//
//  Created by HuangKun on 16/6/2.
//
//

import UIKit

public class OMChartInteractiveView: UIView {
    var panGestrue: UIPanGestureRecognizer?
    var chartLayers: [OMChartLayer] = []
    var rectInset: UIEdgeInsets = UIEdgeInsetsZero
//        {
//        didSet {
//            interactiveRect = UIEdgeInsetsInsetRect(interactiveRect, rectInset)
//        }
//    }
    
//    var interactiveRect: CGRect
    
    var isInteractive: Bool = false {
        didSet {
            if isInteractive {
                panGestrue = UIPanGestureRecognizer(target: self, action: #selector(OMChartInteractiveView.handlePan(_:)))
                self.addGestureRecognizer(panGestrue!)
            }
        }
    }
    
    public override init(frame: CGRect) {
//        interactiveRect = CGRect(origin: CGPointZero, size: frame.size)
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }
    
    public required init?(coder aDecoder: NSCoder) {
//        interactiveRect = CGRectZero
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clearColor()
    }
    
    func appendLayers(layers: [OMChartLayer]) {
        chartLayers = layers
    }
    
    public override func drawRect(rect: CGRect) {
        for item in chartLayers {
            self.layer.addSublayer(item)
        }
    }
    
    func handlePan(sender: UIPanGestureRecognizer) {
        
        let rRect = UIEdgeInsetsInsetRect(self.bounds, rectInset)
        switch sender.state {
        case .Began:
            let location = sender.locationInView(self)
            panBegan(location, currentOffsets(min(max(location.x - rectInset.left, 0), rRect.width - 1)))
        case .Changed:
            let location = sender.locationInView(self)
            panChanged(location, currentOffsets(min(max(location.x - rectInset.left, 0), rRect.width - 1)))
        case .Ended:
            let location = sender.locationInView(self)
            panEnded(location, currentOffsets(min(max(location.x - rectInset.left, 0), rRect.width - 1)))
        default:
            break
        }
    }
    
    private func currentOffsets(x: CGFloat) -> [CGPoint] {
        return chartLayers.map { (layer) -> CGPoint in
            var t = x / layer.path!.xFragment
            t = t - CGFloat(Int(t))
            let orgin = layer.frame.origin
            let parameter = layer.path!.bezierParameters(x)
            return bezierFunction(parameter)(t: t) + CGPoint(x: orgin.x, y: orgin.y)
            }.sort { $0.y < $1.y }
    }
    
    public func panBegan(location: CGPoint, _ currentOffsets: [CGPoint]) {
        
    }
    
    public func panChanged(location: CGPoint, _ currentOffsets: [CGPoint]) {
        
    }
    
    public func panEnded(location: CGPoint, _ currentOffsets: [CGPoint]) {
        
    }
    
}

