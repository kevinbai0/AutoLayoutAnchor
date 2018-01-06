//
//  ViewController.swift
//  Lib
//
//  Created by Kevin Bai on 2018-01-05.
//  Copyright © 2018 Kevin Bai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let rectangleView = UIView()
        rectangleView.backgroundColor = .orange
        self.view.addSubview(rectangleView)
        rectangleView.setConstraints(to: self.view, .left([5]), .right([-5, Anchor.centerX]), .top([Anchor.centerY]), .height([300]))
        
        let view2 = UIView()
        view2.backgroundColor = .red
        view2.addToView(self.view, .left([Anchor.right, rectangleView, 10]), .right([-10]), .top([rectangleView]), .height([rectangleView]))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

