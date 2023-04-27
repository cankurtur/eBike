//
//  RegisterBikeViewController.swift
//  eBike
//
//  Created by Can Kurtur on 23.04.2023.
//

import UIKit

// MARK: - Constant

private enum Constant {
    static let backgroundColor: UIColor = .white
    
    enum TextFields {
        static let emptyText: String = L10n.Register.empty
        static let font: UIFont = .medium14
        static let borderColor: CGColor = Colors.appBlack.color.cgColor
        static let borderWidth: CGFloat = 1
        static let cornerRadius: CGFloat = 8
        static let textAlignment: NSTextAlignment = .center
        static let namePlaceHolder: String = L10n.Register.Placeholder.name
        static let passwordPlaceHolder: String = L10n.Register.Placeholder.pin
        static let colorPlaceHolder: String = L10n.Register.Placeholder.color
        static let pinTextMaxLength: Int = 4
        static let colorTextMaxLength: Int = 0
        static let colorTextTintColor: UIColor = .clear
    }
    
    enum RegisterButton {
        static let title: String = L10n.Register.register
        static let titleColor: UIColor = .white
        static let font: UIFont = .bold20
        static let backgroundColor: UIColor = Colors.appGreen.color
        static let cornerRadius: CGFloat = 25
    }
    
    enum LocationInfoLabel {
        static let text: String = L10n.Register.locationInfo
        static let font: UIFont = .blackItalic14
        static let textColor: UIColor = Colors.appBlack.color
        static let numberOfLines: Int = 2
    }
}

// MARK: - ViewInterface

protocol RegisterBikeViewInterface: ViewInterface {
    func prepareUI()
    func updateUIAfterRegister()
}

// MARK: - RegisterBikeViewController

final class RegisterBikeViewController: BaseViewController, Storyboarded {
    
    @IBOutlet private weak var bikeImageView: UIImageView!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var pinTextField: UITextField!
    @IBOutlet private weak var colorTextField: UITextField!
    @IBOutlet private weak var registerButton: UIButton!
    @IBOutlet private weak var locationInfoLabel: UILabel!
    
    private lazy var pickerView: UIPickerView = {
        let picverView = UIPickerView()
        return picverView
    }()
    
    static var storyboardName: StoryboardNames {
        return .registerBike
    }
    
    var presenter: RegisterBikePresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

// MARK: - RegisterBikeViewInterface

extension RegisterBikeViewController: RegisterBikeViewInterface {
    func prepareUI() {
        view.backgroundColor = Constant.backgroundColor
        
        preparePickerView()
        prepareTextFields()
        prepareButtons()
        prepareLabels()
    }
    
    func updateUIAfterRegister() {
        nameTextField.text = Constant.TextFields.emptyText
        pinTextField.text = Constant.TextFields.emptyText
        colorTextField.text = Constant.TextFields.emptyText
        locationInfoLabel.isHidden = true
    }
}

// MARK: - Prepares

private extension RegisterBikeViewController {
    
    func preparePickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    func prepareTextFields() {
        nameTextField.delegate = self
        pinTextField.delegate = self
        colorTextField.delegate = self
        
        nameTextField.font = Constant.TextFields.font
        nameTextField.textAlignment = Constant.TextFields.textAlignment
        nameTextField.layer.borderColor = Constant.TextFields.borderColor
        nameTextField.layer.borderWidth = Constant.TextFields.borderWidth
        nameTextField.layer.cornerRadius = Constant.TextFields.cornerRadius
        nameTextField.placeholder = Constant.TextFields.namePlaceHolder
        
        pinTextField.font = Constant.TextFields.font
        pinTextField.textAlignment = Constant.TextFields.textAlignment
        pinTextField.layer.borderColor = Constant.TextFields.borderColor
        pinTextField.layer.borderWidth = Constant.TextFields.borderWidth
        pinTextField.layer.cornerRadius = Constant.TextFields.cornerRadius
        pinTextField.placeholder = Constant.TextFields.passwordPlaceHolder
        pinTextField.isSecureTextEntry = true
        pinTextField.keyboardType = .numberPad
        
        colorTextField.font = Constant.TextFields.font
        colorTextField.textAlignment = Constant.TextFields.textAlignment
        colorTextField.layer.borderColor = Constant.TextFields.borderColor
        colorTextField.layer.borderWidth = Constant.TextFields.borderWidth
        colorTextField.layer.cornerRadius = Constant.TextFields.cornerRadius
        colorTextField.placeholder = Constant.TextFields.colorPlaceHolder
        colorTextField.inputView = pickerView
        colorTextField.tintColor = Constant.TextFields.colorTextTintColor
    }
    
    func prepareButtons() {
        registerButton.setTitle(Constant.RegisterButton.title, for: .normal)
        registerButton.setTitleColor(Constant.RegisterButton.titleColor, for: .normal)
        registerButton.titleLabel?.font = Constant.RegisterButton.font
        registerButton.backgroundColor = Constant.RegisterButton.backgroundColor
        registerButton.layer.cornerRadius = Constant.RegisterButton.cornerRadius
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    func prepareLabels() {
        locationInfoLabel.text = Constant.LocationInfoLabel.text
        locationInfoLabel.textColor = Constant.LocationInfoLabel.textColor
        locationInfoLabel.font = Constant.LocationInfoLabel.font
        locationInfoLabel.isHidden = true
        locationInfoLabel.numberOfLines = Constant.LocationInfoLabel.numberOfLines
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource

extension RegisterBikeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return presenter.numberOfComponents()
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return presenter.numberOfRowsInComponent(component)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return presenter.titleForRow(at: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        colorTextField.text = presenter.didSelectRow(at: row)
    }
}

// MARK: - UITextFieldDelegate

extension RegisterBikeViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if pinTextField == textField {
            return (textField.text?.count ?? 0) < Constant.TextFields.pinTextMaxLength || string.isEmpty
        }
        
        if colorTextField == textField {
            return (textField.text?.count ?? 0) < Constant.TextFields.colorTextMaxLength || string.isEmpty
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        locationInfoLabel.isHidden = presenter.textFieldDidEndEditing(name: nameTextField.text, pin: pinTextField.text, color: colorTextField.text)
    }
}

// MARK: - Actions

@objc
private extension RegisterBikeViewController {
    func registerButtonTapped() {
        presenter.registerButtonTapped(name: nameTextField.text,
                                       pin: pinTextField.text,
                                       color: colorTextField.text)
    }
}
