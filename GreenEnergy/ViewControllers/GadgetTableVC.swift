//
//  GadgetTableVC.swift
//  GreenEnergy
//
//  Created by  mac on 21.03.2021.
//

import UIKit

class GadgetTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource, GadgetTableViewCellDelegate {
    
    func updateAmmount() {
        totalWattPerDay = 0
        instantPowerUsage = 0
        for gadget in gadgetArray {
            if gadget.defaultUsageTime < 9 {
                gadget.defaultUsageTimeAsDouble = (Double(gadget.defaultUsageTime + 1)/10)
            } else {
                gadget.defaultUsageTimeAsDouble = Double((gadget.defaultUsageTime + 2) - 10)
            }
            gadget.defaultUsagePowerAsInt = (gadget.defaultUsagePower + 1) * 10

            let sum = (Double(gadget.defaultCount) * gadget.defaultUsageTimeAsDouble! * Double(gadget.defaultUsagePowerAsInt!))
            
            totalWattPerDay += sum
            
            if gadget.isInstantEnergyUsage {
                instantPowerUsage += Double(gadget.defaultCount * gadget.defaultUsagePowerAsInt!)
            }
        }
        tableView.reloadData()
    }
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    var totalWattPerDay: Double = 0.0
    var instantPowerUsage: Double = 0.0
    let actionButton = GEButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureInfoViewController()
        configureTableView()
        initTotalValue()
    }
    
    func initTotalValue() {
        totalWattPerDay = 0
        for gadget in gadgetArray {
            if gadget.defaultUsageTime < 9 {
                gadget.defaultUsageTimeAsDouble = (Double(gadget.defaultUsageTime + 1)/10)
            } else {
                gadget.defaultUsageTimeAsDouble = Double((gadget.defaultUsageTime + 2) - 10)
            }
            gadget.defaultUsagePowerAsInt = (gadget.defaultUsagePower + 1) * 10
            
            let sum = (Double(gadget.defaultCount) * gadget.defaultUsageTimeAsDouble! * Double(gadget.defaultUsagePowerAsInt!))
            totalWattPerDay += sum
        }
    }
    
    private func configureInfoViewController() {
        view.backgroundColor = .systemGray6
        title = "Gadgets"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGray6
        tableView.separatorStyle = .none
        
        tableView.delegate = self
        tableView.dataSource = self
                
        tableView.register(GadgetTableViewCell.self, forCellReuseIdentifier: GadgetTableViewCell.reuseID)
        tableView.register(DayPowerTableViewCell.self, forCellReuseIdentifier: DayPowerTableViewCell.reuseID)
        tableView.register(CalculateSystemTableViewCell.self, forCellReuseIdentifier:
                            CalculateSystemTableViewCell.reuseID)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 || section == 1 {
            return 1
        } else {
            return gadgetArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 150
        } else if indexPath.section == 1 {
            return 40
        } else {
            return 80
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: DayPowerTableViewCell.reuseID, for: indexPath) as! DayPowerTableViewCell
            cell.set(amount: totalWattPerDay, date: "Your dailly power usage in Watt")
            print(instantPowerUsage)
            return cell
        }
         if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CalculateSystemTableViewCell.reuseID, for: indexPath)
            return cell
        }
         if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: GadgetTableViewCell.reuseID, for: indexPath) as! GadgetTableViewCell
            cell.delegate = self
            if indexPath.row == 0 {
                cell.set(gadget: gadgetArray[indexPath.row], tag: 1)
            } else if indexPath.row == tableView.numberOfRows(inSection: 2) - 1 {
                cell.set(gadget: gadgetArray[indexPath.row], tag: 2)
            } else {
                cell.set(gadget: gadgetArray[indexPath.row], tag: 3)
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(indexPath.section)
        if indexPath.section == 1 {
            let vc = SolarEnergyUsageVC()
            vc.watts = totalWattPerDay
            vc.invertorEnegry = instantPowerUsage
            present(vc, animated: true, completion: nil)
            //self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.section == 2 {
            guard let cell = tableView.cellForRow(at: indexPath) as? GadgetTableViewCell else { return }
            cell.gadget?.isInstantEnergyUsage.toggle()

            if cell.gadget!.isInstantEnergyUsage {
                instantPowerUsage += Double(gadgetArray[indexPath.row].defaultCount * gadgetArray[indexPath.row].defaultUsagePowerAsInt!)
            } else {
                instantPowerUsage -= Double(gadgetArray[indexPath.row].defaultCount * gadgetArray[indexPath.row].defaultUsagePowerAsInt!)
            }
            tableView.reloadData()
        }
    }
}






