//
//  ViewController.swift
//  013.实验十三.多线程和网络程序设计
//
//  Created by student on 2018/12/17.
//  Copyright © 2018年 013.实验十三.多线程和网络程序设计. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var sumLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    var count = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //计时
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            self.count += 1
            self.timeLabel.text = "time:\(self.count)"
            //            print("timer thread:\(Thread.current)")
            }.fire()
    }
    //   从1 加到 999 9999
    @IBAction func beginSum(_ sender: Any) {
        DispatchQueue.global().async {
            var sum = 0
            for i in 1...9999999 {
                sum += i
                usleep(10000)
                DispatchQueue.main.async {
                    self.sumLabel.text = "sum:\(sum)"
                }
                
            }
        }
    }
}

