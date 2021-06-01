//
//  GEButton.swift
//  GreenEnergy
//
//  Created by  mac on 29.05.2021.
//

import UIKit

class GEButton: UIButton {
    
    private var shadowLayer: CAShapeLayer!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        setTitle("Calculate", for: .normal)
        titleLabel?.font = .systemFont(ofSize: 16)
        setTitleColor(.white, for: .normal)
        backgroundColor = UIColor.lightGreen()
        layer.cornerRadius = 14
        clipsToBounds = true
        layer.masksToBounds = false
        layer.shadowRadius = 15
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowColor = UIColor.lightGray.cgColor
    }
}

extension UIColor {
    class func lightGreen() -> UIColor {
        return UIColor(red: 144/255, green: 238/255, blue: 144/255, alpha: 1)
    }
}
