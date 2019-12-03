//
//  BaseCollectionViewCell.swift
//  Audiable
//
//  Created by sanaboina  prasad on 02/12/19.
//  Copyright © 2019 sanaboina  prasad. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews(){
        
    }
}
