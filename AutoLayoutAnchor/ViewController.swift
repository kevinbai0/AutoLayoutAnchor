//
//  ViewController.swift
//  Lib
//
//  Created by Kevin Bai on 2018-01-05.
//  Copyright © 2018 Kevin Bai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let view2 = UIView()
    let button1 = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        // view1 takes up the quadrant in the top left corner
        let view1 = UIView()
        view1.backgroundColor = .orange
        view1.addToView(self.view, .left(10.pad), .right(.centerX), .height(30.constant), .bottom(10.pad))
        //view2 takes up quadrant in the top right corner
        view2.backgroundColor = .red
        view2.addToView(self.view, .left(view1.right, 10.pad), .right(10.pad), .top(.centerY), .bottom(10.pad))
        
        button1.addToView(self.view, .bottom(5.pad), .centerX, .width(5.ratio), .height(30.constant))
        button1.setTitle("Animate me", for: [])
        button1.addTarget(self, action: #selector(animateCoolStuff), for: .touchUpInside)
    }
    @objc func animateCoolStuff() {
        UIView.animateKeyframes(withDuration: 2.0, delay: 0, options: UIViewKeyframeAnimationOptions.layoutSubviews, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.2, animations: {
                self.view2.y1Anchor = .top(10.pad)
                self.view.layoutIfNeeded()
            })
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.8, animations: {
                self.view2.x2Anchor = .right(10.pad)
                self.view.layoutIfNeeded()
            })
        }) { (Bool) in
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view2.x1Anchor = .left(10.pad)
        view2.x2Anchor = .right(.centerX)
        
        UIView.animate(withDuration: 1.0) {
            self.view.layoutIfNeeded()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

