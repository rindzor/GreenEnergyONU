//
//  LineChartVC.swift
//  GreenEnergy
//
//  Created by  mac on 14.03.2021.
//

import UIKit

class LineChartVC: UIViewController {
    
    let lineView: LineView = LineView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        lineView.animate(xAxisDuration: 0.0, yAxisDuration: 2.0)
    }
    
    func configure() {
        view.backgroundColor = .systemTeal
        view.addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        
//        let addButton: UIBarButtonItem = UIBarButtonItem(title: "test", style: .done, target: self, action: #selector(addTapped))
//        navigationItem.rightBarButtonItem = addButton
        
        NSLayoutConstraint.activate([
            lineView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            lineView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 400),
            lineView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
    }
    
//    @objc func addTapped() {
//        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
//        let expenceButton = UIAlertAction(title: "Add Expence", style: .default) { (_) in
////            let expenceVC = AddEpenceVC()
//            let navigationExpenceVC = UINavigationController(rootViewController: expenceVC)
//            self.present(navigationExpenceVC, animated: true)
//        }
//        let incomeButton = UIAlertAction(title: "Add Income", style: .default) { (_) in
////            let incomeVC = AddEpenceVC()
////            let navigationIncomeVC = UINavigationController(rootViewController: incomeVC)
////            self.present(navigationIncomeVC, animated: true)
//        }
//
//        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//
//        optionMenu.addAction(expenceButton)
//        optionMenu.addAction(incomeButton)
//        optionMenu.addAction(cancelButton)
//
//        present(optionMenu, animated: true)
//    }
}

