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
        let line1 = OMLineLayer([14, 5, 6, 10, 5, 7, 9], 0.5).isSolid(true)
        let line2 = OMLineLayer([20, 25, 16, 28, 19, 23, 17], 1)
        line2.lineWidth = 4
        
        let chartView = OMChartView(frame: CGRect(x: 0, y: 40, width: self.view.bounds.width, height: 300)).appendChartLayers([line1, line2])
        chartView.backgroundColor = UIColor.blueColor()
        chartView.rectInset = UIEdgeInsetsMake(180, 20, 20, 20)
        chartView.withInteractiveView(ExampleInteractiveView(frame: chartView.bounds))
        chartView.commit()
        self.view.addSubview(chartView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

