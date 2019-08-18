//
//  TextField.swift
//  FindTheBook
//
//  Created by Giselle Tavares on 2019-08-18.
//  Copyright © 2019 Giselle Tavares. All rights reserved.
//

import UIKit

@IBDesignable
class TextField: UITextField {
    
    override func prepareForInterfaceBuilder() {
        customizeView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customizeView()
    }

    func customizeView(){
        backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
        layer.cornerRadius = 5.0
        textAlignment = .left
        
        clipsToBounds = true
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 5))
        leftView = paddingView
        rightView = paddingView
        leftViewMode = .always
        rightViewMode = .always
    }

}
