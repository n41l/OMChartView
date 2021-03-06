//
//  ViewController.swift
//  OMChartView
//
//  Created by HuangKun on 06/01/2016.
//  Copyright (c) 2016 HuangKun. All rights reserved.
//

import UIKit
import OMChartView

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let characterCount: [CGFloat] = [18, 16, 25, 20, 28, 17, 23, 17, 20]
        let gridCount: [CGFloat] = [5, 8, 6, 12, 5, 11, 8, 10, 7]
        
        let contentView = StatisticContentView(withAllGridsAndCharacters: [gridCount, characterCount])
        let delegates = ExampleInteractiveDelegateCenter(withDelegates: contentView)
        
        let line1 = OMLineLayer(characterCount, 1).withGradient(CGPoint(x: 0.5, y: 0.1), ep: CGPoint(x: 0.5, y: 0.95), colors: [UIColor(white: 1, alpha: 0.5), UIColor(white: 1, alpha: 0)])
        let line2 = OMLineLayer(gridCount, 0.5)
        line2.strokeColor = UIColor(white: 1, alpha: 0.4)
        line2.lineWidth = 2
        
        let gradientBGLayer = CAGradientLayer()
        gradientBGLayer.colors = [UIColor(red:0.478, green:0.886, blue:0.788, alpha:1).CGColor, UIColor(red:0.325, green:0.717, blue:0.745, alpha:1).CGColor]
        gradientBGLayer.endPoint = CGPoint(x: 0.1, y: 0.9)
        gradientBGLayer.startPoint = CGPoint(x: 0.75, y: 0.45)
        
        let chartView = OMChartView(frame: CGRect(x: 0, y: 40, width: self.view.bounds.width, height: 300)).appendChartLayers([line1, line2])
        gradientBGLayer.frame = chartView.bounds
        chartView.layer.addSublayer(gradientBGLayer)
        
        let xView = StatisticXView(frame: CGRect(x: 0, y: chartView.bounds.height - 40, width: chartView.bounds.width, height: 40), andTitles: ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"])
        delegates.append(xView)
        

    
        chartView.rectInset = UIEdgeInsetsMake(140, 0, 40, 0)
        let interactiveView = ExampleInteractiveView(frame: chartView.bounds)
        interactiveView.delegate = delegates
        interactiveView.statisticPopover.setup(contentView, interactiveView, CGPointZero)
        interactiveView.addSubview(xView)
        chartView.withInteractiveView(interactiveView)
        chartView.commit()
        

        self.view.addSubview(chartView)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleTap(sender: UITapGestureRecognizer) {
        let popoverView = OMSimplePopoverView()
        let contentView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        popoverView.setup(contentView, self.view, sender.locationInView(self.view)).showWithAnimation()
    }
    
    func handlePan(sender: UIPanGestureRecognizer) {
//        let delta = sender.locationInView(self.view).x / self.view.bounds.width
//        interactivePopover.showWithInterativeParameter(delta)
    }

}

