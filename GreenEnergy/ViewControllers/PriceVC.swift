//
//  PriceVC.swift
//  GreenEnergy
//
//  Created by  mac on 29.05.2021.
//

import UIKit

class PriceVC: UIViewController, UITextFieldDelegate {

    let scrollView = UIScrollView()
    let contentView = UIView()
    let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
    
    let powerTextField = GETextFiled(keyboardType: .decimalPad, placeholder: "Choose light tarif price", image: UIImage(named: "Lightning"))
    let toolbarPowerDoneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneAmountBarButtonPressed))
    
    let meterTextField = GETextFiled(keyboardType: .decimalPad, placeholder: "Choose battery square meter price", image: UIImage(named: "Battery"))
    let toolbarMeterDoneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneMeterBarButtonPressed))
    
    let tipsButton = GEButton()
    let actionButton = GEButton()
    var priceLabel = UILabel()
    var timeLabel = UILabel()
    var subPriceLabel = UILabel()
    var subTimeLabel = UILabel()
    
    var lightPrice: Double?
    var meterPrice: Double?
    var invertorPrice: Double = 0
    
    var watts: Double?
    var invertorEnegry: Double?
    var area: Double?
    
    
    override func viewDidLoad() {
        view.backgroundColor = .systemGray6
        print("Watts: ", watts, "\nInstant: ", invertorEnegry, "\nArea: ", area)
        setupPowerTextField()
        setupMeterTextField()
        configurePriceLabel()
        configureSubPriceLabel()
        configureTimeLabel()
        configureSubTimeLabel()
        checkInvertorPrice()
        configureActionButton()
        configureTipsButton()
        tipsButton.isHidden = true
        actionButton.isHidden = true
//        configureActionButton()
    }
    
    private func checkInvertorPrice() {
        if var invertorEnegryInKW = invertorEnegry {
            invertorEnegryInKW /= 1000
            if invertorEnegryInKW <= 3 {
                invertorPrice = 75600
            } else if invertorEnegryInKW >= 3 && invertorEnegryInKW <= 5 {
                invertorPrice = 107800
            } else if invertorEnegryInKW >= 5 && invertorEnegryInKW <= 7 {
                invertorPrice = 140000
            } else if invertorEnegryInKW >= 7 && invertorEnegryInKW <= 10 {
                invertorPrice = 190000
            }
        }
    }
    
    private func configureActionButton() {
        view.addSubview(actionButton)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)
        NSLayoutConstraint.activate([
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            actionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureTipsButton() {
        view.addSubview(tipsButton)
        tipsButton.translatesAutoresizingMaskIntoConstraints = false
        tipsButton.setTitle("Show Tips", for: .normal)
        tipsButton.backgroundColor = UIColor(red: 173/255, green: 216/255, blue: 230/255, alpha: 1)
        tipsButton.addTarget(self, action: #selector(tipsButtonPressed), for: .touchUpInside)
        NSLayoutConstraint.activate([
            tipsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tipsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tipsButton.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -15),
            tipsButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func tipsButtonPressed() {
        let vc = TipsVC()
        vc.area = area
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    private func configurePriceLabel() {
        view.addSubview(priceLabel)
        priceLabel.font = .systemFont(ofSize: 20)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: meterTextField.bottomAnchor, constant: 10),
            priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            priceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            priceLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func configureSubPriceLabel() {
        view.addSubview(subPriceLabel)
        subPriceLabel.font = .boldSystemFont(ofSize: 50)
        subPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subPriceLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10),
            subPriceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subPriceLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func configureTimeLabel() {
        view.addSubview(timeLabel)
        timeLabel.font = .systemFont(ofSize: 20)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: subPriceLabel.bottomAnchor, constant: 10),
            timeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            timeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            timeLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func configureSubTimeLabel() {
        view.addSubview(subTimeLabel)
        subTimeLabel.font = .boldSystemFont(ofSize: 50)
        subTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subTimeLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 10),
            subTimeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subTimeLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc private func actionButtonPressed() {
        print("Meter price: ", meterPrice)
        let price = meterPrice! * area! + invertorPrice + 5000
        priceLabel.text = "Installation cost:"
        subPriceLabel.text = "\(Int(price)) UAH"
        let savingInYear = watts!/1000 * lightPrice! * 360
        let time = price / (savingInYear)
        timeLabel.text = "Payback period:"
        subTimeLabel.text = "\(String(format: "%.1f", time)) years"
    }
    
    private func setupPowerTextField() {
        view.addSubview(powerTextField)
        powerTextField.delegate = self
        powerTextField.inputAccessoryView = configureToolbar(barButtonItems: [flexibleSpace, toolbarPowerDoneButton])
        NSLayoutConstraint.activate([
            powerTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
            powerTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            powerTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            powerTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func doneAmountBarButtonPressed() {
        view.endEditing(true)
        guard let inputText = powerTextField.text else {
            lightPrice = nil
            isTextFieldsOK()
            return
        }
        
        let doubleAmount = Double(inputText.replacingOccurrences(of: ",", with: "."))
        if !inputText.isEmpty && doubleAmount != nil && doubleAmount != 0 {
            lightPrice = doubleAmount
        }
        isTextFieldsOK()
    }
    
    private func setupMeterTextField() {
        view.addSubview(meterTextField)
        meterTextField.delegate = self
        meterTextField.inputAccessoryView = configureToolbar(barButtonItems: [flexibleSpace, toolbarMeterDoneButton])
        NSLayoutConstraint.activate([
            meterTextField.topAnchor.constraint(equalTo: powerTextField.bottomAnchor, constant: 15),
            meterTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            meterTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            meterTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func doneMeterBarButtonPressed() {
        view.endEditing(true)
        guard let inputText = meterTextField.text else {
            meterPrice = nil
            isTextFieldsOK()
            return
        }
        
        let doubleAmount = Double(inputText.replacingOccurrences(of: ",", with: "."))
        if !inputText.isEmpty && doubleAmount != nil && doubleAmount != 0 {
            meterPrice = doubleAmount
        }
        isTextFieldsOK()
    }
    
    
    
    private func isTextFieldsOK() {
    
        if let meterPrice = meterPrice,
           let lightPrice = lightPrice {
            actionButton.isHidden = false
            tipsButton.isHidden = false
        }
    }
    
    func setupScrollView(){
        scrollView.backgroundColor = .systemGray6
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        contentView.backgroundColor = .systemGray6
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
}

extension PriceVC: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}

extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
