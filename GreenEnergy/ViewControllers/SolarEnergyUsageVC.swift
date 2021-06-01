//
//  SolarEnergyUsageVC.swift
//  GreenEnergy
//
//  Created by  mac on 12.04.2021.
//

import UIKit

class SolarEnergyUsageVC: UIViewController, UITextFieldDelegate {

    let scrollView = UIScrollView()
    let contentView = UIView()
    let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
    let toolbarCategoryDoneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneCategoryBarButtonPressed))
    
    let locationTextField = GETextFiled(keyboardType: nil, placeholder: "Select your region", image: UIImage(named: "region"))
    let locationPicker = GEPickerView(tag: 0)
    
    let powerTextField = GETextFiled(keyboardType: .decimalPad, placeholder: "Choose power", image: UIImage(named: "power"))
    let toolbarPowerDoneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneAmountBarButtonPressed))
    
    let materialTypeTextField = GETextFiled(keyboardType: nil, placeholder: "Select material", image: UIImage(named: "material"))
    let materialTypePicker = GEPickerView(tag: 1)
    let toolbarMaterialDoneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneMaterialBarButtonPressed))
    
    let angleTextField = GETextFiled(keyboardType: nil, placeholder: "Select angle", image: UIImage(named: "angle"))
    let anglePicker = GEPickerView(tag: 2)
    let toolbarAnglelDoneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneAngleBarButtonPressed))
    
    let azimuthTextField = GETextFiled(keyboardType: nil, placeholder: "Select azimut", image: UIImage(named: "azimuth"))
    let azimuthPicker = GEPickerView(tag: 3)
    let toolbarAzimuthDoneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneAzimuthBarButtonPressed))
    
    let batteryPlaceTextField = GETextFiled(keyboardType: nil, placeholder: "Select battery place", image: UIImage(named: "place"))
    let batteryPlacePicker = GEPickerView(tag: 4)
    let toolbarBatteryPlaceDoneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneBatteryPlaceBarButtonPressed))
    
    var watts: Double?
    var invertorEnegry: Double?
    var area: Double?
    
    var lineView = LineView()
    
    var location: Location?
    var material: MaterialType?
    var angle: Int?
    var angleString: String?
    var azimut: Int?
    var azimuthString: String?
    var batteryPlace : BatteryPlace?
    var power: Double?
    
    let actionButton = GEButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAllUIPicker()
        setupScrollView()
        setupLocationTextField()
        setupPowerTextField()
        setupMaterialTypeTextField()
        setupAngleTextField()
        setupAzimuthTextField()
        setupBatteryPlaceTextField()
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
    
    private func configureAllUIPicker() {
        locationPicker.dataSource = self
        locationPicker.delegate = self
        
        materialTypePicker.dataSource = self
        materialTypePicker.delegate = self
        
        anglePicker.dataSource = self
        anglePicker.delegate = self
        
        azimuthPicker.dataSource = self
        azimuthPicker.delegate = self
        
        batteryPlacePicker.dataSource = self
        batteryPlacePicker.delegate = self
    }

    private func setupLocationTextField(){
        view.addSubview(locationTextField)
        locationTextField.delegate = self
        locationTextField.inputView = locationPicker
        locationTextField.inputAccessoryView = configureToolbar(barButtonItems: [flexibleSpace, toolbarCategoryDoneButton])
        
        NSLayoutConstraint.activate([
            locationTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            locationTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            locationTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            locationTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func doneCategoryBarButtonPressed() {
        location = Location.allCases[locationPicker.selectedRow(inComponent: 0)]
        locationTextField.text = Location.allCases[locationPicker.selectedRow(inComponent: 0)].rawValue
        isTextFieldsOK()
        view.endEditing(true)
    }
    
    
    private func setupPowerTextField() {
        view.addSubview(powerTextField)
        powerTextField.delegate = self
//        powerTextField.inputView = materialTypePicker
        powerTextField.inputAccessoryView = configureToolbar(barButtonItems: [flexibleSpace, toolbarPowerDoneButton])
        
        NSLayoutConstraint.activate([
            powerTextField.topAnchor.constraint(equalTo: locationTextField.bottomAnchor, constant: 15),
            powerTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            powerTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            powerTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func doneAmountBarButtonPressed() {
        view.endEditing(true)
        guard let inputText = powerTextField.text else {
            power = nil
            isTextFieldsOK()
            return
        }
        
        let doubleAmount = Double(inputText.replacingOccurrences(of: ",", with: "."))
        if !inputText.isEmpty && doubleAmount != nil && doubleAmount != 0 {
            power = doubleAmount
        }
//        power = nil
        isTextFieldsOK()
//        checkIfDoneButtonIsActive()
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
    
    @objc private func actionButtonPressed() {
        let vc = PriceVC()
        vc.watts = watts
        vc.invertorEnegry = invertorEnegry
        vc.area = area
        self.present(vc, animated: true, completion: nil)
    }
    
    private func setupMaterialTypeTextField() {
        view.addSubview(materialTypeTextField)
        materialTypeTextField.delegate = self
        materialTypeTextField.inputView = materialTypePicker
        materialTypeTextField.inputAccessoryView = configureToolbar(barButtonItems: [flexibleSpace, toolbarMaterialDoneButton])
        materialTypePicker.selectRow(0, inComponent: 0, animated: false)
        NSLayoutConstraint.activate([
            materialTypeTextField.topAnchor.constraint(equalTo: powerTextField.bottomAnchor, constant: 15),
            materialTypeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            materialTypeTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            materialTypeTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func doneMaterialBarButtonPressed() {
        material = MaterialType.allCases[materialTypePicker.selectedRow(inComponent: 0)]
        materialTypeTextField.text = MaterialType.allCases[materialTypePicker.selectedRow(inComponent: 0)].rawValue
        isTextFieldsOK()
        view.endEditing(true)
    }
    
    private func setupAngleTextField() {
        view.addSubview(angleTextField)
        angleTextField.delegate = self
        angleTextField.inputView = anglePicker
        angleTextField.inputAccessoryView = configureToolbar(barButtonItems: [flexibleSpace, toolbarAnglelDoneButton])
        
        NSLayoutConstraint.activate([
            angleTextField.topAnchor.constraint(equalTo: materialTypeTextField.bottomAnchor, constant: 15),
            angleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            angleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            angleTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func doneAngleBarButtonPressed() {
        guard let angle = angleString else { return }
        angleTextField.text = angle
        isTextFieldsOK()
        view.endEditing(true)
    }
    
    
    private func setupAzimuthTextField() {
        view.addSubview(azimuthTextField)
        azimuthTextField.delegate = self
        azimuthTextField.inputView = azimuthPicker
        azimuthTextField.inputAccessoryView = configureToolbar(barButtonItems: [flexibleSpace, toolbarAzimuthDoneButton])
        
        NSLayoutConstraint.activate([
            azimuthTextField.topAnchor.constraint(equalTo: angleTextField.bottomAnchor, constant: 15),
            azimuthTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            azimuthTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            azimuthTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func doneAzimuthBarButtonPressed() {
        
        guard let azimut = azimuthString else { return }
        azimuthTextField.text = azimut
        isTextFieldsOK()
        view.endEditing(true)
    }
    
    private func setupBatteryPlaceTextField() {
        view.addSubview(batteryPlaceTextField)
        batteryPlaceTextField.delegate = self
        batteryPlaceTextField.inputView = batteryPlacePicker
        batteryPlaceTextField.inputAccessoryView = configureToolbar(barButtonItems: [flexibleSpace, toolbarBatteryPlaceDoneButton])
        
        NSLayoutConstraint.activate([
            batteryPlaceTextField.topAnchor.constraint(equalTo: azimuthTextField.bottomAnchor, constant: 15),
            batteryPlaceTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            batteryPlaceTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            batteryPlaceTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func doneBatteryPlaceBarButtonPressed() {
        batteryPlace = BatteryPlace.allCases[batteryPlacePicker.selectedRow(inComponent: 0)]
        batteryPlaceTextField.text = BatteryPlace.allCases[batteryPlacePicker.selectedRow(inComponent: 0)].rawValue
        isTextFieldsOK()
        view.endEditing(true)
    }
    
    private func isTextFieldsOK() {
        if let location = location,
           let material = material,
           let angle = angle,
           let azimut = azimut,
           let place = batteryPlace,
           let power = power {
           let batteriesData = SolarSolution.shared.doCalc(region: location.rawValue, module: material.rawValue, power: power, angel: angle, azimuth: azimut, place: place.rawValue)
            lineView = LineView(batteriesData: batteriesData.0, limit: watts!/1000)
            area = batteriesData.1
            setupLineChartView()
        }
    }
    
    private func setupLineChartView() {
        view.addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lineView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lineView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            lineView.topAnchor.constraint(equalTo: batteryPlaceTextField.bottomAnchor, constant: 10),
            lineView.heightAnchor.constraint(equalToConstant: 250)
        ])
        configureActionButton()
    }
}

//MARK: - UIPickerViewDataSource, UIPickerViewDelegate

extension SolarEnergyUsageVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return Location.allCases.count
        } else if pickerView.tag == 1 {
            return MaterialType.allCases.count
        } else if pickerView.tag == 2 {
            return 19
        } else if pickerView.tag == 3 {
            return 19
        } else if pickerView.tag == 4 {
            return 3
        } else { return 0 }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            return Location.allCases[row].rawValue
        } else if pickerView.tag == 1 {
            return MaterialType.allCases[row].rawValue
        } else if pickerView.tag == 2 {
            return "\(row * 5)°"
        } else if pickerView.tag == 3 {
            return "\( -90 + row * 5)°"
        } else if pickerView.tag == 4 {
            return BatteryPlace.allCases[row].rawValue
        } else { return nil }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            location = Location.allCases[row]
        } else if pickerView.tag == 1 {
            material = MaterialType.allCases[row]
        } else if pickerView.tag == 2 {
            angleString = "\(row * 5)°"
            angle = row
        } else if pickerView.tag == 3 {
            azimuthString = "\( -90 + row * 5)°"
            azimut = row
        } else if pickerView.tag == 4 {
            batteryPlace = BatteryPlace.allCases[row]
        }
    }
}
