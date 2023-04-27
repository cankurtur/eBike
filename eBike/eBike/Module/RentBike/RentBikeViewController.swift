//
//  RentBikeViewController.swift
//  eBike
//
//  Created by Can Kurtur on 23.04.2023.
//

import UIKit

// MARK: - Constant

private enum Constant {
    
    static let backgroundColor: UIColor = .white
    
    enum BikeOwnerLabel {
        static let textColor: UIColor = Colors.appBlack.color
        static let font: UIFont = .bold16
        static let text: String = L10n.RentBikeView.bikeOwner
    }
    
    enum NameLabel {
        static let textColor: UIColor = Colors.appBlack.color
        static let font: UIFont = .bold14
    }
    
    enum BikeImageView {
        static let image: UIImage = UIImage(systemName: "bicycle")!
    }
    
    enum PinTitleLabel {
        static let textColor: UIColor = Colors.appBlack.color
        static let font: UIFont = .bold20
        static let text: String = L10n.RentBikeView.useThisPin
        static let numberOfLines: Int = 2
    }
    
    enum PinLabel {
        static let textColor: UIColor = Colors.appBlack.color
        static let font: UIFont = .bold100
    }
    
    enum RentButton {
        static let title: String = L10n.RentBikeView.rent
        static let titleColor: UIColor = .white
        static let font: UIFont = .bold20
        static let backgroundColor: UIColor = Colors.appGreen.color
        static let cornerRadius: CGFloat = 25
    }
    
    enum IGotItButton {
        static let title: String = L10n.RentBikeView.iGotIt
        static let titleColor: UIColor = .white
        static let font: UIFont = .bold20
        static let backgroundColor: UIColor = Colors.appGreen.color
        static let cornerRadius: CGFloat = 25
    }
}

// MARK: - ViewInterface

protocol RentBikeViewInterface: ViewInterface {
    func prepareUI(nameText: String, bikeHexString: String, pinText: String)
    func updateUIAfterRentBike()
}

// MARK: - RentBikeViewController

final class RentBikeViewController: BaseViewController, Storyboarded {
    
    @IBOutlet private weak var rentView: UIView!
    @IBOutlet private weak var pinView: UIView!
    @IBOutlet private weak var bikeOwnerLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var bikeImageView: UIImageView!
    @IBOutlet private weak var rentButton: UIButton!
    @IBOutlet private weak var pinTitleLabel: UILabel!
    @IBOutlet private weak var pinLabel: UILabel!
    @IBOutlet private weak var iGotItButton: UIButton!
    
    static var storyboardName: StoryboardNames {
        return .rentBike
    }
    
    var presenter: RentBikePresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

// MARK: - RentBikeViewInterface

extension RentBikeViewController: RentBikeViewInterface {
    func prepareUI(nameText: String, bikeHexString: String, pinText: String) {
        view.backgroundColor = Constant.backgroundColor
        
        prepareViews()
        prepareLabels(nameText: nameText, pinText: pinText)
        prepareImageView(with: bikeHexString)
        prepareButtons()
    }
    
    func updateUIAfterRentBike() {
        pinView.isHidden = false
        rentView.isHidden = true
    }
}

// MARK: - Prepares

private extension RentBikeViewController {
   func prepareViews() {
        pinView.isHidden = true
        rentView.isHidden = false
    }
    
    func prepareLabels(nameText: String, pinText: String) {
        bikeOwnerLabel.font = Constant.BikeOwnerLabel.font
        bikeOwnerLabel.textColor = Constant.BikeOwnerLabel.textColor
        bikeOwnerLabel.text = Constant.BikeOwnerLabel.text
        
        nameLabel.font = Constant.NameLabel.font
        nameLabel.textColor = Constant.NameLabel.textColor
        nameLabel.text = nameText
        
        pinTitleLabel.font = Constant.PinTitleLabel.font
        pinTitleLabel.textColor = Constant.PinTitleLabel.textColor
        pinTitleLabel.text = Constant.PinTitleLabel.text
        pinTitleLabel.numberOfLines = Constant.PinTitleLabel.numberOfLines
        
        pinLabel.font = Constant.PinLabel.font
        pinLabel.textColor = Constant.PinLabel.textColor
        pinLabel.text = pinText
    }
    
    func prepareImageView(with hexString: String) {
        bikeImageView.image = Constant.BikeImageView.image
        bikeImageView.contentMode = .scaleAspectFit
        bikeImageView.tintColor = UIColor(hexString: hexString)
    }
    
    func prepareButtons() {
        rentButton.setTitle(Constant.RentButton.title, for: .normal)
        rentButton.setTitleColor( Constant.RentButton.titleColor, for: .normal)
        rentButton.titleLabel?.font = Constant.RentButton.font
        rentButton.backgroundColor = Constant.RentButton.backgroundColor
        rentButton.layer.cornerRadius = Constant.RentButton.cornerRadius
        rentButton.addTarget(self, action: #selector(rentButtonTapped), for: .touchUpInside)
        
        iGotItButton.setTitle(Constant.IGotItButton.title, for: .normal)
        iGotItButton.setTitleColor( Constant.IGotItButton.titleColor, for: .normal)
        iGotItButton.titleLabel?.font = Constant.IGotItButton.font
        iGotItButton.backgroundColor = Constant.IGotItButton.backgroundColor
        iGotItButton.layer.cornerRadius = Constant.IGotItButton.cornerRadius
        iGotItButton.addTarget(self, action: #selector(iGotItButtonTapped), for: .touchUpInside)
    }
}

// MARK: - Actions

@objc
private extension RentBikeViewController {
    func rentButtonTapped() {
        presenter.rentButtonTapped()
    }
    
    func iGotItButtonTapped() {
        presenter.iGotItButtonTapped()
    }
}
