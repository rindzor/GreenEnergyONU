//
//  DayPowerTableViewCell.swift
//  GreenEnergy
//
//  Created by  mac on 21.03.2021.
//

import UIKit


class DayPowerTableViewCell: UITableViewCell {
    
    static let reuseID: String = "DetailTableViewCell"
    
    let contanierView: UIView = UIView()
    var amountLabel: UILabel = UILabel()
    var dateLabel: UILabel = UILabel()
    
    var amountLabelText: String = String()
    var dateLabelText: String = String()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
        configureContanierView()
        configureAmontLabel()
        configureDateLabel()
    }
    
    func set(amount: Double, date: String) {
        contentView.removeFromSuperview()
        superview?.addSubview(contentView)
        
        self.amountLabel.text = "\(Int(amount))"
//        print(self.amountLabel.text, amount)
        
        self.dateLabel.text = date
    }
    
    private func configureCell() {
        contentView.backgroundColor = .systemGray6
    }
    
    private func configureContanierView() {
        contentView.addSubview(contanierView)
        contanierView.translatesAutoresizingMaskIntoConstraints = false
        contanierView.backgroundColor = .systemGray6
        
        NSLayoutConstraint.activate([
            contanierView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contanierView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contanierView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contanierView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func configureAmontLabel() {
        contanierView.addSubview(amountLabel)
        
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.textAlignment = .center
        //        amountLabel.text = amountLabelText
        amountLabel.backgroundColor = .clear
        amountLabel.font = UIFont.systemFont(ofSize: 55, weight: .medium)
        
        
        NSLayoutConstraint.activate([
            amountLabel.topAnchor.constraint(equalTo: contanierView.topAnchor),
            amountLabel.leadingAnchor.constraint(equalTo: contanierView.leadingAnchor),
            amountLabel.trailingAnchor.constraint(equalTo: contanierView.trailingAnchor),
            amountLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func configureDateLabel() {
        contanierView.addSubview(dateLabel)
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.textAlignment = .center
        //        dateLabel.text = dateLabelText
        dateLabel.backgroundColor = .clear
        dateLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: contanierView.leadingAnchor, constant: 70),
            dateLabel.trailingAnchor.constraint(equalTo: contanierView.trailingAnchor, constant: -70),
            dateLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

