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
    var tapGestrue: UITapGestureRecognizer?
    var chartLayers: [OMChartLayer] = []
    var rectInset: UIEdgeInsets = UIEdgeInsetsZero
    public lazy var snappingPositions: [CGPoint] = {
        guard self.chartLayers.count != 0 else { fatalError("use this property after appending layers") }
        return Array(self.chartLayers.first!.path!.flipPointsPosition.map { (point) -> CGPoint in
            return self.currentOffsets(point.x).first!
        }.dropFirst())
    }()
    
    public lazy var xFragment: CGFloat = {
        guard self.chartLayers.count != 0 else { fatalError("use this property after appending layers") }
        return self.chartLayers.first!.path!.xFragment
    }()
    
    var isInteractive: Bool = false {
        didSet {
            if isInteractive {
                panGestrue = UIPanGestureRecognizer(target: self, action: #selector(OMChartInteractiveView.handlePan(_:)))
                self.addGestureRecognizer(panGestrue!)
                tapGestrue = UITapGestureRecognizer(target: self, action: #selector(OMChartInteractiveView.handleTap(_:)))
                self.addGestureRecognizer(tapGestrue!)
            }
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }
    
    public required init?(coder aDecoder: NSCoder) {
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
            panBegan(location, sender.velocityInView(self), currentOffsets(min(max(location.x - rectInset.left, 0), rRect.width - 1)))
        case .Changed:
            let location = sender.locationInView(self)
            panChanged(location, sender.velocityInView(self), currentOffsets(min(max(location.x - rectInset.left, 0), rRect.width - 1)))
        case .Ended:
            let location = sender.locationInView(self)
            panEnded(location, sender.velocityInView(self), currentOffsets(min(max(location.x - rectInset.left, 0), rRect.width - 1)))
        default:
            break
        }
    }
    
    func handleTap(sender: UITapGestureRecognizer) {
        tap(sender.locationInView(self), sender.numberOfTouches())
    }
    
    public func currentOffsets(x: CGFloat) -> [CGPoint] {
        return chartLayers.map { (layer) -> CGPoint in
            var t = x / layer.path!.xFragment
            t = t - CGFloat(Int(t))
            let orgin = layer.frame.origin
            let parameter = layer.path!.bezierParameters(x)
            return bezierFunction(parameter)(t: t) + CGPoint(x: orgin.x, y: orgin.y)
            }.sort { $0.y < $1.y }
    }
    
    public func tap(withLocation: CGPoint, _ count: Int) {
        
    }
    
    public func panBegan(location: CGPoint, _ velocity: CGPoint, _ currentOffsets: [CGPoint]) {
        
    }
    
    public func panChanged(location: CGPoint, _ velocity: CGPoint, _ currentOffsets: [CGPoint]) {
        
    }
    
    public func panEnded(location: CGPoint, _ velocity: CGPoint, _ currentOffsets: [CGPoint]) {
        
    }
    
}

