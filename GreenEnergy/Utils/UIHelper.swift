//
//  UIHelper.swift
//  GreenEnergy
//
//  Created by  mac on 12.04.2021.
//

import UIKit

func configureToolbar(barButtonItems: [UIBarButtonItem]) -> UIToolbar {
    let toolBar = UIToolbar()
    toolBar.barStyle = UIBarStyle.default

    toolBar.tintColor = UIColor.systemBlue
    toolBar.sizeToFit()

    toolBar.setItems(barButtonItems, animated: true)
    
    toolBar.isUserInteractionEnabled = true
    
    return toolBar
}
