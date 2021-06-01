//
//  TipsVC.swift
//  GreenEnergy
//
//  Created by  mac on 29.05.2021.
//

import UIKit

class TipsVC: UIViewController {
    
    let firsView = UIView()
    let firstTipLabel = UILabel()
    let secondView = UIView()
    let secondTipLabel = UILabel()
    let thirdView = UIView()
    let thirdTipLabel = UILabel()
    
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    
    var area: Double?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureFirstView()
        configureFirstTipLabel()
        configureSecondView()
        configureSecondTipLabel()
        configureThirdView()
        configureThirdTipLabel()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
    }
    
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        guard translation.y >= 0 else { return }
 
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 700 {
                self.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 700)
                }
            }
        }
    }
    
    private func configureFirstView() {
        view.addSubview(firsView)
        firsView.backgroundColor = .systemGray5
        firsView.layer.cornerRadius = 16
        firsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            firsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            firsView.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            firsView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func configureFirstTipLabel() {
        firsView.addSubview(firstTipLabel)
        firstTipLabel.textColor = .gray
        firstTipLabel.text = "Keep in mind that the tariff may change, more often it will grow, then solar installations will be even more effective"
        firstTipLabel.numberOfLines = 0
        firstTipLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstTipLabel.leadingAnchor.constraint(equalTo: firsView.leadingAnchor, constant: 10),
            firstTipLabel.trailingAnchor.constraint(equalTo: firsView.trailingAnchor, constant: -10),
            firstTipLabel.topAnchor.constraint(equalTo: firsView.topAnchor, constant: 10),
            firstTipLabel.bottomAnchor.constraint(equalTo: firsView.bottomAnchor, constant: -10)
        ])
    }
    
    private func configureSecondView() {
        view.addSubview(secondView)
        secondView.backgroundColor = .systemGray5
        secondView.layer.cornerRadius = 16
        secondView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            secondView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            secondView.topAnchor.constraint(equalTo: firsView.bottomAnchor, constant: 10),
            secondView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func configureSecondTipLabel() {
        secondView.addSubview(secondTipLabel)
        secondTipLabel.textColor = .gray
        secondTipLabel.text = "The area of your station will be \(String(format: "%.1f", area!)) square meters. Make sure you have enough space to place it. You can change the battery place and material parameters to decrease or increase the area"
        secondTipLabel.numberOfLines = 0
        secondTipLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondTipLabel.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: 10),
            secondTipLabel.trailingAnchor.constraint(equalTo: secondView.trailingAnchor, constant: -10),
            secondTipLabel.topAnchor.constraint(equalTo: secondView.topAnchor, constant: 10),
            secondTipLabel.bottomAnchor.constraint(equalTo: secondView.bottomAnchor, constant: -10)
        ])
    }
    
    private func configureThirdView() {
        view.addSubview(thirdView)
        thirdView.backgroundColor = .systemGray5
        thirdView.layer.cornerRadius = 16
        thirdView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            thirdView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            thirdView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            thirdView.topAnchor.constraint(equalTo: secondView.bottomAnchor, constant: 10),
            thirdView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func configureThirdTipLabel() {
        thirdView.addSubview(thirdTipLabel)
        thirdTipLabel.textColor = .gray
        thirdTipLabel.text = "The cost of the work on the installation of the station itself is accounted for as 5,000 UAH"
        thirdTipLabel.numberOfLines = 0
        thirdTipLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            thirdTipLabel.leadingAnchor.constraint(equalTo: thirdView.leadingAnchor, constant: 10),
            thirdTipLabel.trailingAnchor.constraint(equalTo: thirdView.trailingAnchor, constant: -10),
            thirdTipLabel.topAnchor.constraint(equalTo: thirdView.topAnchor, constant: 10),
            thirdTipLabel.bottomAnchor.constraint(equalTo: thirdView.bottomAnchor, constant: -10)
        ])
    }


}
