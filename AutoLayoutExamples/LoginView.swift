//
//  LoginView.swift
//  AutoLayoutAnchor
//
//  Created by Kevin Bai on 2018-01-06.
//  Copyright © 2018 Kevin Bai. All rights reserved.
//

import Foundation
import UIKit

class LoginView: UIView {
    //ui elements
    let userTextField = UITextField()
    let passTextField = UITextField()
    let loginBtn = UIButton()
    let forgotPasswordButton = UIButton()
    let createAccountButton = UIButton()
    override init(frame: CGRect) {
        super.init(frame: frame)
        //add to subview and set constraints from bottom up
        userTextField.addToView(self, .centerX([]), .width([0,0.8]), .top([Anchor.centerY]), .height([0, 0.08]))
        passTextField.addToView(self, .centerX([]), .width([0,0.8]), .top([userTextField, Anchor.bottom, 10]), .height([0, 0.08]))
        loginBtn.addToView(self, .centerX([]), .width([0,0.8]), .top([passTextField, Anchor.bottom, 10]), .height([0, 0.08]))
        forgotPasswordButton.addToView(self, .top([30, loginBtn, Anchor.bottom]), .centerX([]), .width([0, 0.6]), .height([30]))
        createAccountButton.addToView(self, .bottom([-20]), .centerX([]), .height([30]), .width([0, 0.6]))
        //all constraints are done! Only thing needed is to style the view
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //style view
        
        let textColor = UIColor.white
        self.backgroundColor = UIColor(red: 53/255, green: 171/255, blue: 255/255, alpha: 1.0) //background color
        loginBtn.backgroundColor = UIColor(red: 49/255, green: 46/255, blue: 63/255, alpha: 1.0) //loginBtn background color
        
        //textField background colors
        userTextField.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        passTextField.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        
        loginBtn.setTitleColor(textColor, for: [])
        loginBtn.setTitle("Log In", for: [])
        
        forgotPasswordButton.setTitle("Forgot Password?", for: [])
        forgotPasswordButton.setTitleColor(textColor, for: [])
        createAccountButton.setTitle("Create an Account", for: [])
        createAccountButton.setTitleColor(textColor, for: [])
        
        //placeholder text
        userTextField.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedStringKey.strokeColor: textColor])
        passTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedStringKey.strokeColor: textColor])
        //padding
        let paddingView1 = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        userTextField.leftView = paddingView1
        userTextField.leftViewMode = .always
        let paddingView2 = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        passTextField.leftView = paddingView2
        passTextField.leftViewMode = .always
    }
}
