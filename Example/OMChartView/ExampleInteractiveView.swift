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
    var canResponedToGesture: Bool = true
    
    var displayLink: CADisplayLink?
    var addedX: CGFloat = 0
    var remainingDistance: CGFloat = 0
    var currentXOffset: CGFloat = 0
    var displayLinkCount: Int = 12
    
    var popoverPosition: CGPoint = CGPointZero {
        willSet {
            if newValue != popoverPosition {
                guard let popoverContentView = popoverContentView else { return }
                statisticPopover.setup(popoverContentView, self, newValue)
            }
        }
    }
    
    lazy var snappingPositionsWithOffset: [CGPoint] = {
        return self.snappingPositions.map { CGPoint(x: $0.x, y: $0.y - 10) }
    }()
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
//        currentIndicatorPointLayers(snappingPositions)
        guard canResponedToGesture else { return }

    }
    
    override func panChanged(location: CGPoint, _ currentOffsets: [CGPoint]) {
        currentIndicatroLineLayer(currentOffsets)
        currentIndicatorPointLayers(currentOffsets)
        
        
        guard canResponedToGesture else { return }
        let index = Int(round(location.x / xFragment))
//        let decimal = location.x / xFragment - CGFloat(index)
        
//        if decimal > 0.3 && decimal < 0.7 { return }
        
//        if decimal > 0.7 {
//            index += 1
//        }
        
        
        
        guard index != 0 else { return }
        guard index != snappingPositionsWithOffset.count else { return }
        
        popoverPosition = snappingPositionsWithOffset[index - 1]
        
        let distance = abs(location.x - popoverPosition.x)
        
        if distance / xFragment > 0.4 {
            canResponedToGesture = false
            UIView.animateWithDuration(0.01, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .CurveEaseIn, animations: {
                self.statisticPopover.transform = CGAffineTransformMakeScale(0.1, 0.1)
                self.statisticPopover.alpha = 0
            }) { finished in
//                self.statisticPopover.removeFromSuperview()
                self.statisticPopover.transform = CGAffineTransformIdentity
                self.statisticPopover.alpha = 0
                self.canResponedToGesture = true
            }
            
            return
        }
        
        let delta = min(max(0, 1 - abs(location.x - popoverPosition.x)/(xFragment)), 1)
        statisticPopover.alpha = delta
        statisticPopover.showWithInterativeParameter(delta)
    }
    
    override func panEnded(location: CGPoint, _ currentOffsets: [CGPoint]) {
        guard canResponedToGesture else { return }
        displayLink = CADisplayLink(target: self, selector: #selector(ExampleInteractiveView.drawNewIndicator(_: )))
        displayLink?.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
        addedX = 0
        remainingDistance = 0
        currentXOffset = 0
        displayLinkCount = 12
        
        
        let index = Int(round(location.x / xFragment))
        
        guard index != 0 else { return }
        guard index != snappingPositionsWithOffset.count else { return }
        
        popoverPosition = snappingPositionsWithOffset[index - 1]
        remainingDistance = location.x - popoverPosition.x
        addedX = remainingDistance / 12
        currentXOffset = location.x
        
        if statisticPopover.alpha != 0 {
            canResponedToGesture = false
            UIView.animateWithDuration(0.01, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .CurveEaseInOut, animations: {
                self.statisticPopover.transform = CGAffineTransformIdentity
                self.statisticPopover.alpha = 1
            }) { finished in
                self.canResponedToGesture = true
            }
            
            return
        }
        
        statisticPopover.alpha = 1
        statisticPopover.showWithAnimation()
        
        
    }
    
    func drawNewIndicator(sender: CADisplayLink) {
        guard remainingDistance != 0 else { return }
        
        currentIndicatroLineLayer(currentOffsets(currentXOffset))
        currentIndicatorPointLayers(currentOffsets(currentXOffset))
        currentXOffset -= addedX
        displayLinkCount -= 1
        
        if displayLinkCount == 0 {
            displayLink?.invalidate()
            displayLink = nil
        }
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
            layer.zPosition = 10
            self.indicatorPoints.append(layer)
            self.layer.addSublayer(layer)
        }
    }
    
    private func snapIndicator() {
//        snappingPositions
    }
    
}
