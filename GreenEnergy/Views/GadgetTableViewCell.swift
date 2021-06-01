//
//  GadgetTableViewCell.swift
//  GreenEnergy
//
//  Created by  mac on 21.03.2021.
//

import UIKit

protocol GadgetTableViewCellDelegate {
    func updateAmmount()
}

class GadgetTableViewCell: UITableViewCell {
    
    var delegate: GadgetTableViewCellDelegate?
    
    private let padding = UIEdgeInsets(top: 0, left: 65, bottom: 0, right: 5)
    var gadgetImage: UIImage?
    let contanierView = UIView()
    var gadgetImageView = UIImageView()
    let grayLeftView = UIView()
    
    let gadgetCount = UIPickerView()
    let gadgetUsageTime = UIPickerView()
    let gadgetUsagePower = UIPickerView()
    
    let gadgetCountLabel = UILabel()
    let gadgetUsageTimeLabel = UILabel()
    let gadgetUsagePowerLabel = UILabel()
    
    var defaultCount: Int!
    var defaultUsageTime: Int!
    var defaultUsagePower: Int!
    
    var spacingLine: UIView = UIView()
    
    var top = false
    var bottom = false
    var showSpacingLine: Bool = false
    
    var isInstatntGadget: Bool = false
    
    var gadget: Gadget?
    
    static let reuseID = "GadgetTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func set(gadget: Gadget, tag: Int?) {
        self.gadget = gadget
        self.defaultCount = gadget.defaultCount
        self.defaultUsageTime = gadget.defaultUsageTime
        self.defaultUsagePower = gadget.defaultUsagePower
        self.gadgetImage = gadget.image
        if tag == 1 {
            self.top = true
            self.bottom = false
            self.showSpacingLine = true
        } else if tag == 2 {
            self.bottom = true
            self.top = false
            self.showSpacingLine = false
        }  else {
            self.bottom = false
            self.top = false
            self.showSpacingLine = true
        }
        configure()
        setDefaultValues()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        configureCell()
        configureContanierView()
        configureGrayLeftView()
        configuregadgetImageView()
        configureGadgetCountLabel()
        configureGadgetCount()
        configureGadgetUsageTimeLabel()
        configureGadgetUsageTime()
        configureGadgetUsagePowerLabel()
        configureGadgetUsagePower()
        configureSpaceingLine()
    }
    
    private func configureCell() {
        contentView.backgroundColor = .systemGray6
    }
    
    private func configureContanierView() {
        contentView.addSubview(contanierView)
        
        contanierView.backgroundColor = gadget!.isInstantEnergyUsage ? .lightGreen() : .white
        contanierView.clipsToBounds = false
        contanierView.translatesAutoresizingMaskIntoConstraints = false
        contanierView.layer.masksToBounds = true
        
        NSLayoutConstraint.activate([
            contanierView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            contanierView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            contanierView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            contanierView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
    }
    
    private func configureSpaceingLine() {
        contanierView.addSubview(spacingLine)
        
        if showSpacingLine {
            spacingLine.alpha = 1
        } else {
            spacingLine.alpha = 0
        }
        
        spacingLine.translatesAutoresizingMaskIntoConstraints = false
        spacingLine.backgroundColor = .systemGray5
        
        NSLayoutConstraint.activate([
            spacingLine.bottomAnchor.constraint(equalTo: contanierView.bottomAnchor, constant: -1),
            spacingLine.leadingAnchor.constraint(equalTo: contanierView.leadingAnchor, constant: 10),
            spacingLine.trailingAnchor.constraint(equalTo: contanierView.trailingAnchor),
            spacingLine.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func setDefaultValues() {
        self.gadgetCount.selectRow(defaultCount, inComponent: 0, animated: false)
        self.gadgetUsageTime.selectRow(defaultUsageTime, inComponent: 0, animated: false)
        self.gadgetUsagePower.selectRow(defaultUsagePower, inComponent: 0, animated: false)
    }
    
    private func configureGrayLeftView() {
        contanierView.addSubview(grayLeftView)
        grayLeftView.backgroundColor = .systemGray4
        grayLeftView.translatesAutoresizingMaskIntoConstraints = false
        grayLeftView.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
//            grayLeftView.topAnchor.constraint(equalTo: contanierView.topAnchor, constant:  5),
            grayLeftView.leadingAnchor.constraint(equalTo: contanierView.leadingAnchor, constant: 5),
            grayLeftView.centerYAnchor.constraint(equalTo: contanierView.centerYAnchor),
//            grayLeftView.bottomAnchor.constraint(equalTo: contanierView.bottomAnchor, constant: -5),
            grayLeftView.widthAnchor.constraint(equalToConstant: 40),
            grayLeftView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func configuregadgetImageView() {
        contanierView.addSubview(gadgetImageView)
        
        gadgetImageView.image = gadgetImage
        gadgetImageView.tintColor = .systemBlue
        gadgetImageView.translatesAutoresizingMaskIntoConstraints = false
        gadgetImageView.layer.cornerRadius = self.layer.cornerRadius
        
        NSLayoutConstraint.activate([
            gadgetImageView.topAnchor.constraint(equalTo: grayLeftView.topAnchor, constant:  7),
            gadgetImageView.leadingAnchor.constraint(equalTo: grayLeftView.leadingAnchor, constant: 7),
            gadgetImageView.bottomAnchor.constraint(equalTo: grayLeftView.bottomAnchor, constant: -7),
            gadgetImageView.trailingAnchor.constraint(equalTo: grayLeftView.trailingAnchor, constant: -7)
//            gadgetImageView.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func configureGadgetCountLabel() {
        contanierView.addSubview(gadgetCountLabel)
        gadgetCountLabel.text = "Count"
        gadgetCountLabel.font = UIFont.systemFont(ofSize: 14)
        gadgetCountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gadgetCountLabel.topAnchor.constraint(equalTo: contanierView.topAnchor, constant:  15),
            gadgetCountLabel.leadingAnchor.constraint(equalTo: grayLeftView.trailingAnchor, constant: 10),
            gadgetCountLabel.bottomAnchor.constraint(equalTo: contanierView.bottomAnchor, constant: -15)
//            gadgetCountLabel.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func configureGadgetCount() {
        contanierView.addSubview(gadgetCount)
        gadgetCount.tag = 0
        gadgetCount.delegate = self
        gadgetCount.dataSource = self
        
        
        gadgetCount.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gadgetCount.topAnchor.constraint(equalTo: contanierView.topAnchor, constant:  15),
            gadgetCount.leadingAnchor.constraint(equalTo: gadgetCountLabel.trailingAnchor, constant: 2),
            gadgetCount.bottomAnchor.constraint(equalTo: contanierView.bottomAnchor, constant: -15),
            gadgetCount.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureGadgetUsageTimeLabel() {
        contanierView.addSubview(gadgetUsageTimeLabel)
        gadgetUsageTimeLabel.text = "Hr/day"
        gadgetUsageTimeLabel.font = UIFont.systemFont(ofSize: 14)
        gadgetUsageTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gadgetUsageTimeLabel.topAnchor.constraint(equalTo: contanierView.topAnchor, constant:  15),
            gadgetUsageTimeLabel.leadingAnchor.constraint(equalTo: gadgetCount.trailingAnchor, constant: 2),
            gadgetUsageTimeLabel.bottomAnchor.constraint(equalTo: contanierView.bottomAnchor, constant: -15)
//            gadgetCountLabel.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func configureGadgetUsageTime() {
        contanierView.addSubview(gadgetUsageTime)
        gadgetUsageTime.tag = 1
        gadgetUsageTime.delegate = self
        gadgetUsageTime.dataSource = self
        
        
        gadgetUsageTime.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gadgetUsageTime.topAnchor.constraint(equalTo: contanierView.topAnchor, constant:  15),
            gadgetUsageTime.leadingAnchor.constraint(equalTo: gadgetUsageTimeLabel.trailingAnchor, constant: 2),
            gadgetUsageTime.bottomAnchor.constraint(equalTo: contanierView.bottomAnchor, constant: -15),
            gadgetUsageTime.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureGadgetUsagePowerLabel() {
        contanierView.addSubview(gadgetUsagePowerLabel)
        gadgetUsagePowerLabel.text = "W/hr"
        gadgetUsagePowerLabel.font = UIFont.systemFont(ofSize: 14)
        
        gadgetUsagePowerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gadgetUsagePowerLabel.topAnchor.constraint(equalTo: contanierView.topAnchor, constant:  15),
            gadgetUsagePowerLabel.leadingAnchor.constraint(equalTo: gadgetUsageTime.trailingAnchor, constant: 5),
            gadgetUsagePowerLabel.bottomAnchor.constraint(equalTo: contanierView.bottomAnchor, constant: -15)
        ])
    }
    
    func configureGadgetUsagePower() {
        contanierView.addSubview(gadgetUsagePower)
        gadgetUsagePower.tag = 2
        gadgetUsagePower.delegate = self
        gadgetUsagePower.dataSource = self
        
        gadgetUsagePower.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gadgetUsagePower.topAnchor.constraint(equalTo: contanierView.topAnchor, constant:  15),
            gadgetUsagePower.leadingAnchor.constraint(equalTo: gadgetUsagePowerLabel.trailingAnchor, constant: 2),
            gadgetUsagePower.bottomAnchor.constraint(equalTo: contanierView.bottomAnchor, constant: -15),
            gadgetUsagePower.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
}

extension GadgetTableViewCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return 20
        } else if pickerView.tag == 1 {
            return 33
        } else {
            return 200
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            gadget?.defaultCount = row
        } else if pickerView.tag == 1 {
            gadget?.defaultUsageTime = row
        } else {
            gadget?.defaultUsagePower = row
        }
        delegate?.updateAmmount()
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel = view as? UILabel;
        
        if (pickerLabel == nil) {
            pickerLabel = UILabel()
            
            pickerLabel?.font = UIFont.systemFont(ofSize: 16)
            pickerLabel?.textAlignment = .center
        }
        
        if pickerView.tag == 0 {
            pickerLabel?.text = "\(row)"
            return pickerLabel!
        } else if pickerView.tag == 1 {
            if row < 9 {
                
                pickerLabel?.text = "\(Double(row + 1)/10)"
            } else {
                pickerLabel?.text = "\((row + 2) - 10)"
            }
            
            return pickerLabel!
//            return "\(row)"
        } else {
            pickerLabel?.text = "\((row+1) * 10)"
            return pickerLabel!
//            return "\(row * 50)W"
        }
        
    }
    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        if pickerView.tag == 0 {
//            return "\(row)"
//        } else if pickerView.tag == 1 {
//            return "\(row)"
//        } else {
//            return "\(row * 10)"
//        }
//    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var corners: UIRectCorner = UIRectCorner()
        
        let shape = CAShapeLayer()
        let rect = CGRect(x: 0, y: 0, width: bounds.size.width - 30, height: bounds.size.height)
        
        if self.top && !self.bottom {
            corners = [.topLeft, .topRight]
        } else if self.bottom && !self.top {
            corners = [.bottomRight, .bottomLeft]
        } else if self.bottom && self.top {
            corners = [.topLeft, .topRight, .bottomRight, .bottomLeft]
        }
        
        shape.path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: 10, height: 10)).cgPath
        contanierView.layer.mask = shape
        contanierView.layer.masksToBounds = true
    }
}
