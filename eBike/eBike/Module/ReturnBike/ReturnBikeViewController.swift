//
//  ReturnBikeViewController.swift
//  eBike
//
//  Created by Can Kurtur on 24.04.2023.
//

import UIKit

// MARK: - Constant

private enum Constant {
    static let backgroundColor: UIColor = .white
    
    enum EmptyView {
        static let backgroundColor: UIColor = .clear
    }
    
    enum EmptyTitleLabel {
        static let text: String = L10n.ReturnBike.dontHaveRentalBike
        static let font: UIFont = .bold16
        static let textColor: UIColor = Colors.appBlack.color
        static let numberOfLines: Int = 2
    }
    
    enum EmptyImageView {
        static let image: UIImage = Images.cryingEmoji.image
    }
    
    enum AddNewBikeButton {
        static let title: String = L10n.ReturnBike.rentOneNow
        static let titleFont: UIFont = .bold20
        static let titleColor: UIColor = .white
        static let backgroundColor: UIColor = Colors.appGreen.color
        static let cornerRadius: CGFloat = 25
    }
    
    enum ReturnBikeView {
        static let backgroundColor: UIColor = .clear
    }
    
    enum InfoLabel {
        static let text: String = L10n.ReturnBike.yourBikesInfo
        static let font: UIFont = .bold20
        static let textColor: UIColor = Colors.appBlack.color
        static let numberOfLines: Int = 1
    }
    
    enum InfoImageView {
        static let image: UIImage = UIImage(systemName: "bicycle.circle")!
    }
    
    enum PinTitleLabel {
        static let text: String = L10n.ReturnBike.pin
        static let font: UIFont = .bold16
        static let textColor: UIColor = Colors.appBlack.color
        static let numberOfLines: Int = 1
    }
    
    enum PinLabel {
        static let font: UIFont = .bold80
        static let textColor: UIColor = Colors.appBlack.color
        static let numberOfLines: Int = 1
    }
    
    enum ReturnBikeButton {
        static let title: String = L10n.ReturnBike.returnBike
        static let titleFont: UIFont = .bold20
        static let titleColor: UIColor = .white
        static let backgroundColor: UIColor = Colors.appGreen.color
        static let cornerRadius: CGFloat = 25
    }
}

// MARK: - ViewInterface

protocol ReturnBikeViewInterface: ViewInterface {
    func prepareUI(isOnTrip: Bool, pinText: String, bikeColorHex: String)
    func updateUIAfterReturnBike()
}

// MARK: - ReturnBikeViewController

final class ReturnBikeViewController: BaseViewController, Storyboarded {
    
    @IBOutlet private weak var emptyView: UIView!
    @IBOutlet private weak var emptyTitleLabel: UILabel!
    @IBOutlet private weak var emptyImageView: UIImageView!
    @IBOutlet private weak var addNewBikeButton: UIButton!
    @IBOutlet private weak var returnBikeView: UIView!
    @IBOutlet private weak var infoLabel: UILabel!
    @IBOutlet private weak var infoImageView: UIImageView!
    @IBOutlet private weak var pinTitleLabel: UILabel!
    @IBOutlet private weak var pinLabel: UILabel!
    @IBOutlet private weak var returnBikeButton: UIButton!
    
    static var storyboardName: StoryboardNames {
        return .returnBike
    }
    
    var presenter: ReturnBikePresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
}

// MARK: - ReturnBikeViewInterface

extension ReturnBikeViewController: ReturnBikeViewInterface {
    func prepareUI(isOnTrip: Bool, pinText: String, bikeColorHex: String) {
        view.backgroundColor = Constant.backgroundColor
        
        prepareViews(isOnTrip)
        prepareLabels(pinText)
        prepareImageViews(bikeColorHex)
        prepareButtons()
    }
    
    func updateUIAfterReturnBike() {
        UIView.animate(withDuration: 0.8) { [weak self] in
            guard let self = self else { return }
            
            self.emptyView.isHidden = false
            self.returnBikeView.isHidden = true
        }
    }
}

// MARK: - Prepares

private extension ReturnBikeViewController {
    
    func prepareViews(_ isOnTrip: Bool) {
        emptyView.isHidden = isOnTrip
        returnBikeView.isHidden = !isOnTrip
    }
    
    func prepareLabels(_ pinText: String) {
        emptyTitleLabel.text = Constant.EmptyTitleLabel.text
        emptyTitleLabel.textColor = Constant.EmptyTitleLabel.textColor
        emptyTitleLabel.font = Constant.EmptyTitleLabel.font
        emptyTitleLabel.numberOfLines = Constant.EmptyTitleLabel.numberOfLines
        emptyTitleLabel.textAlignment = .center
        
        infoLabel.text = Constant.InfoLabel.text
        infoLabel.textColor = Constant.InfoLabel.textColor
        infoLabel.font = Constant.InfoLabel.font
        infoLabel.numberOfLines = Constant.InfoLabel.numberOfLines
        infoLabel.textAlignment = .center
        
        pinTitleLabel.text = Constant.PinTitleLabel.text
        pinTitleLabel.textColor = Constant.PinTitleLabel.textColor
        pinTitleLabel.font = Constant.PinTitleLabel.font
        pinTitleLabel.numberOfLines = Constant.PinTitleLabel.numberOfLines
        pinTitleLabel.textAlignment = .center
        
        pinLabel.text = pinText
        pinLabel.textColor = Constant.PinLabel.textColor
        pinLabel.font = Constant.PinLabel.font
        pinLabel.numberOfLines = Constant.PinLabel.numberOfLines
        pinLabel.textAlignment = .center
    }
    
    private func prepareImageViews(_ bikeColorHex: String) {
        emptyImageView.image = Constant.EmptyImageView.image
        emptyImageView.contentMode = .scaleAspectFill
        
        infoImageView.image = Constant.InfoImageView.image
        infoImageView.tintColor = UIColor(hexString: bikeColorHex)
        infoImageView.contentMode = .scaleAspectFill
    }
    
    private func prepareButtons() {
        addNewBikeButton.setTitle(Constant.AddNewBikeButton.title, for: .normal)
        addNewBikeButton.setTitleColor(Constant.AddNewBikeButton.titleColor, for: .normal)
        addNewBikeButton.titleLabel?.font = Constant.AddNewBikeButton.titleFont
        addNewBikeButton.backgroundColor = Constant.AddNewBikeButton.backgroundColor
        addNewBikeButton.layer.cornerRadius = Constant.AddNewBikeButton.cornerRadius
        addNewBikeButton.addTarget(self, action: #selector(addNewBikeButtonTapped), for: .touchUpInside)
        
        returnBikeButton.setTitle(Constant.ReturnBikeButton.title, for: .normal)
        returnBikeButton.setTitleColor(Constant.ReturnBikeButton.titleColor, for: .normal)
        returnBikeButton.titleLabel?.font = Constant.ReturnBikeButton.titleFont
        returnBikeButton.backgroundColor = Constant.ReturnBikeButton.backgroundColor
        returnBikeButton.layer.cornerRadius = Constant.ReturnBikeButton.cornerRadius
        returnBikeButton.addTarget(self, action: #selector(returnBikeButtonTapped), for: .touchUpInside)
    }
}

// MARK: - Actions

@objc
private extension ReturnBikeViewController {
    func addNewBikeButtonTapped() {
        presenter.addNewBikeButtonTapped()
    }
    
    func returnBikeButtonTapped() {
        presenter.returnBikeButtonTapped()
    }
}
