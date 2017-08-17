//
//  ViewController.swift
//  CEMainRunLoopMonitor
//
//  Created by Mr.LuDashi on 2017/8/17.
//  Copyright © 2017年 ZeluLi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func tapTestButton(_ sender: Any) {
        print("\n------begin------")
        usleep(5000*1000)
        print("------end--------\n")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

