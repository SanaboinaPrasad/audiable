//
//  LoginCell.swift
//  Audiable
//
//  Created by sanaboina  prasad on 03/12/19.
//  Copyright © 2019 sanaboina  prasad. All rights reserved.
//

import UIKit

class LoginCell: BaseCollectionViewCell {
 
    let imageView: UIImageView = {
        let img = UIImageView()
            img.translatesAutoresizingMaskIntoConstraints = false
            img.backgroundColor = .red
            img.image = UIImage(named: "photo")
            img.layer.cornerRadius = 80
            img.clipsToBounds = true
        return img
        
    }()
    
    let emailTextFiled: LeftPaddingTextFiled = {
        let txtFld = LeftPaddingTextFiled()
            txtFld.placeholder = "Enter email"
            txtFld.translatesAutoresizingMaskIntoConstraints = false
            txtFld.layer.borderColor = UIColor.lightGray.cgColor
            txtFld.layer.borderWidth = 1
            txtFld.keyboardType = UIKeyboardType.emailAddress
            return txtFld
    }()
    
    let passwordTextFiled: LeftPaddingTextFiled = {
        let txtFld = LeftPaddingTextFiled()
        txtFld.placeholder = "Enter password"
        txtFld.translatesAutoresizingMaskIntoConstraints = false
        txtFld.layer.borderColor = UIColor.lightGray.cgColor
        txtFld.layer.borderWidth = 1
        txtFld.isSecureTextEntry = true
        return txtFld
    }()
    
    
  lazy  var loginButton: UIButton = {
        let btn = UIButton(type: .system)
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.setTitle("Login", for: .normal)
            btn.backgroundColor = UIColor.orange
        btn.addTarget(self, action: #selector(handleLogin), for: UIControl.Event.touchUpInside)
            return btn
    }()
   weak var  delegate: LoginControlDelegate?
    @objc fileprivate func handleLogin(){
        delegate?.finishedLogin()
    }
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = .white
        addSubview(imageView)
        addSubview(emailTextFiled)
        addSubview(passwordTextFiled)
        addSubview(loginButton)
        
        imageView.anchor(top: nil, topPadding: 0, bottom: nil, bottomPaading: 0, leading: nil, leadingPadding: 0, trailing: nil, trailingPadding: 0, width: 160, height: 160)
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant:
            -150).isActive = true
        
        emailTextFiled.anchor(top: imageView.bottomAnchor, topPadding: 16, bottom: nil, bottomPaading: 0, leading: leadingAnchor, leadingPadding: 32, trailing: trailingAnchor, trailingPadding: -32, width: 0, height: 50)
        passwordTextFiled.anchor(top: emailTextFiled.bottomAnchor, topPadding: 16, bottom: nil, bottomPaading: 0, leading: leadingAnchor, leadingPadding: 32, trailing: trailingAnchor, trailingPadding: -32, width: 0, height: 50)
        loginButton.anchor(top: passwordTextFiled.bottomAnchor, topPadding: 16, bottom: nil, bottomPaading: 0, leading: leadingAnchor, leadingPadding: 32, trailing: trailingAnchor, trailingPadding: -32, width: 0, height: 50)
    }
}



class LeftPaddingTextFiled: UITextField {
    
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: self.bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }
    
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: self.bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)

    }
}
