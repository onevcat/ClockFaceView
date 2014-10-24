//
//  ViewController.swift
//  ClockFaceViewDemo
//
//  Created by 王 巍 on 14/10/19.
//  Copyright (c) 2014年 OneV's Den. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var clockFaceView: ClockFaceView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        clockFaceView.time = NSDate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

