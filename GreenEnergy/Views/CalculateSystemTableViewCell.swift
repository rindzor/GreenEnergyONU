//
//  CalculateSystemTableViewCell.swift
//  GreenEnergy
//
//  Created by  mac on 28.03.2021.
//

import UIKit

protocol CalculateSystemTableViewCellDelegate {
    func hideDetailVC()
}

class CalculateSystemTableViewCell: UITableViewCell {
    
    static let reuseID: String = "CalculateSystemTableViewCell"
    
    let contanierView: UIView = UIView()
    var goNextButton = UILabel()
    var titleForDeleteButton: String = String()
    
    var delegate: CalculateSystemTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
        configureContanierView()
        configureDeleteButton()
    }
    
    private func configureCell() {
        contentView.backgroundColor = .systemGray6
    }
    
    private func configureContanierView() {
        contentView.addSubview(contanierView)
        
        contanierView.backgroundColor = .white
        contanierView.layer.cornerRadius = 10
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
    
    private func configureDeleteButton() {
        contentView.addSubview(goNextButton)
        
        goNextButton.translatesAutoresizingMaskIntoConstraints = false
        goNextButton.backgroundColor = .white
        goNextButton.text = "See your green energy needs"
//        goNextButton.setTitle("See your green energy needs", for: .normal)
//        goNextButton.setTitleColor(UIColor.black, for: .normal)
//        goNextButton.contentHorizontalAlignment = .center
        
//        goNextButton.addTarget(self, action: #selector(deleteButtonPressed), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            goNextButton.topAnchor.constraint(equalTo: contanierView.topAnchor),
            goNextButton.centerXAnchor.constraint(equalTo: contanierView.centerXAnchor),
            goNextButton.bottomAnchor.constraint(equalTo: contanierView.bottomAnchor)
        ])
    }
    
    @objc private func deleteButtonPressed() {
        delegate?.hideDetailVC()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

