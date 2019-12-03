//
//  PageCell.swift
//  Audiable
//
//  Created by sanaboina  prasad on 02/12/19.
//  Copyright © 2019 sanaboina  prasad. All rights reserved.
//

import UIKit

class PageCell: BaseCollectionViewCell {
  
    var page : Page? {
        didSet {
            guard let page = page else{ return}
            var imageName = page.imageName ?? ""
            if UIDevice.current.orientation.isLandscape {
               imageName += "lll"
            }
            imageView.image = UIImage(named: imageName)
            
            let colour = UIColor(white: 0.2, alpha: 1)
            let attributedText = NSMutableAttributedString(string: page.title ?? "", attributes: [NSAttributedString.Key.font  : UIFont.systemFont(ofSize: 18, weight: .medium),NSAttributedString.Key.foregroundColor: colour])
            attributedText.append(NSAttributedString(string: "\n\n\(page.message ?? "" )", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14),NSAttributedString.Key.foregroundColor: colour]))
            let length = attributedText.string.count
            let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = .center
            attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: length))
            
            textView.attributedText = attributedText

        }
    }
    
    let imageView: UIImageView = {
        let img = UIImageView()
            img.translatesAutoresizingMaskIntoConstraints = false
            img.image = UIImage(named: "nature")
            img.contentMode = UIView.ContentMode.scaleAspectFill
            img.clipsToBounds = true
             return img
    }()
    
    let textView: UITextView = {
        let txtView = UITextView()
            txtView.isEditable = false
            txtView.text = "Dummy text"
            txtView.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
        return txtView
    }()
    let lineSeperatorView: UIView = {
        let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = UIColor(white: 0.9, alpha: 1)
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(imageView)
        addSubview(textView)
        addSubview(lineSeperatorView)
        textView.anchor(top: imageView.bottomAnchor, topPadding: 0, bottom: bottomAnchor, bottomPaading: 0, leading: leadingAnchor, leadingPadding: 16, trailing: trailingAnchor, trailingPadding: -16, width: 0, height: 0)
        textView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
        
        imageView.anchor(top: topAnchor, topPadding: 0, bottom: nil, bottomPaading: 0, leading: leadingAnchor, leadingPadding: 0, trailing: trailingAnchor, trailingPadding: 0, width: 0, height: 0)
        lineSeperatorView.anchor(top: nil, topPadding: 0, bottom: textView.topAnchor, bottomPaading: 0, leading: leadingAnchor, leadingPadding: 0, trailing: trailingAnchor, trailingPadding: 0, width: 0, height: 1)
    }
}
