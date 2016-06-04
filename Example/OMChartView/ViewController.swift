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
        let line1 = OMLineLayer([16, 25, 20, 28, 17, 23, 17], 1).withGradient(CGPoint(x: 0.5, y: 0.1), ep: CGPoint(x: 0.5, y: 0.95), colors: [UIColor(white: 1, alpha: 0.5), UIColor(white: 1, alpha: 0)])
        let line2 = OMLineLayer([8, 6, 12, 5, 11, 8, 10], 0.5)
        line2.strokeColor = UIColor(white: 1, alpha: 0.4)
        line2.lineWidth = 2
        
        let gradientBGLayer = CAGradientLayer()
        gradientBGLayer.colors = [UIColor(red:0.478, green:0.886, blue:0.788, alpha:1).CGColor, UIColor(red:0.325, green:0.717, blue:0.745, alpha:1).CGColor]
        gradientBGLayer.endPoint = CGPoint(x: 0.1, y: 0.9)
        gradientBGLayer.startPoint = CGPoint(x: 0.75, y: 0.45)
        
        let chartView = OMChartView(frame: CGRect(x: 0, y: 40, width: self.view.bounds.width, height: 300)).appendChartLayers([line1, line2])
        gradientBGLayer.frame = chartView.bounds
        chartView.layer.addSublayer(gradientBGLayer)
    
        chartView.rectInset = UIEdgeInsetsMake(140, 0, 40, 0)
        chartView.withInteractiveView(ExampleInteractiveView(frame: chartView.bounds))
        chartView.commit()
        self.view.addSubview(chartView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

