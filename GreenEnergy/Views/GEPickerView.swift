//
//  GEPickerView.swift
//  GreenEnergy
//
//  Created by  mac on 12.04.2021.
//

import UIKit

class GEPickerView: UIPickerView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(tag: Int) {
        super.init(frame: .zero)
        self.tag = tag
        configure()
    }
    
    private func configure() {
        backgroundColor = .systemGray4
    }
}
