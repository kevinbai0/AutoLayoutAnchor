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
        // view1 takes up the quadrant in the top left corner
        let view1 = UIView()
        view1.backgroundColor = .orange
        view1.addToView(self.view, .left(10), .right(-5, Anchor.centerX), .top(28), .bottom(Anchor.centerY, -10))
        //view2 takes up quadrant in the top right corner
        let view2 = UIView()
        view2.backgroundColor = .red
        view2.addToView(self.view, .left(Anchor.right, view1, 10), .right(-10), .top(view1), .height(view1))
        
         /*Same code to do with only NSLayoutAnchors
         let view1 = UIView()
         view1.backgroundColor = .orange
         view1.translatesAutoresizingMaskIntoConstraints = false
         self.view.addSubview(view1)
         view1.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
         view1.rightAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -5).isActive = true
         view1.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 28).isActive = true
         view1.bottomAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -10).isActive = true
         
         let view2 = UIView()
         view2.backgroundColor = .red
         view2.translatesAutoresizingMaskIntoConstraints = false
         self.view.addSubview(view2)
         view2.leftAnchor.constraint(equalTo: view1.rightAnchor, constant: 10).isActive = true
         view2.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
         view2.topAnchor.constraint(equalTo: view1.topAnchor).isActive = true
         view2.bottomAnchor.constraint(equalTo: view1.bottomAnchor).isActive = true
        */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

