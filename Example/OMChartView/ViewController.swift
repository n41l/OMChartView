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
        let chartView = OMChartView(frame: CGRect(x: 0, y: 40, width: self.view.bounds.width, height: 200), withStatisticData: [10, 2, 5, 6, 7, 1, 12, 4, 2,])
        chartView.backgroundColor = UIColor.blueColor()
        self.view.addSubview(chartView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

