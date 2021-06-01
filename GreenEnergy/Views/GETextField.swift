//
//  GETextField.swift
//  GreenEnergy
//
//  Created by  mac on 12.04.2021.
//

import UIKit

class GETextFiled: UITextField {
    
    private let padding = UIEdgeInsets(top: 0, left: 65, bottom: 0, right: 5)
    var image: UIImage?
    var imageView = UIImageView()
    let grayLeftView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureImageView() {
        self.addSubview(imageView)
        
        imageView.image = image
        imageView.tintColor = .systemBlue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = self.layer.cornerRadius
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant:  15),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            imageView.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    init(keyboardType: UIKeyboardType?, placeholder: String?, image: UIImage?) {
        super.init(frame: .zero)
        self.keyboardType = keyboardType ?? .default
        self.placeholder = placeholder ?? ""
        self.image = image ?? nil
        configure()
    }

    override func selectionRects(for range: UITextRange) -> [UITextSelectionRect] {
        []
    }

    override func caretRect(for position: UITextPosition) -> CGRect {
        .null
    }
    
    private func configureGrayLeftView() {
        self.addSubview(grayLeftView)
        grayLeftView.backgroundColor = .systemGray4
        grayLeftView.translatesAutoresizingMaskIntoConstraints = false
        grayLeftView.layer.cornerRadius = self.layer.cornerRadius
        
        NSLayoutConstraint.activate([
            grayLeftView.topAnchor.constraint(equalTo: self.topAnchor, constant:  5),
            grayLeftView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            grayLeftView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            grayLeftView.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func update(with image: UIImage) {
        self.image = image
        self.imageView.image = image
    }
    
    
    private func configure() {
        
        translatesAutoresizingMaskIntoConstraints = false
        leftViewMode = .always
        layer.cornerRadius = 10

        textColor = .label
        tintColor = .label
        textAlignment = .left
        font = UIFont.preferredFont(forTextStyle: .body)
        minimumFontSize = 12
        backgroundColor = .systemGray6
        
        configureGrayLeftView()
        configureImageView()
    }
}
