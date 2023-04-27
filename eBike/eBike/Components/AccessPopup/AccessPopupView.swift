//
//  AccessPopupView.swift
//  eBike
//
//  Created by Can Kurtur on 26.04.2023.
//

import UIKit

// MARK: - Constant

private enum Constant {
    static let backgroundColor: UIColor = .clear
    
    enum ContainerView {
        static let backgroundColor: UIColor = .white
        static let cornerRadius: CGFloat = 30
    }
    
    enum InformationLabel {
        static let text: String = L10n.AppPopupView.locationSevicesUnavailable
        static let font: UIFont = .bold16
        static let textColor: UIColor = Colors.appBlack.color
        static let numberOfLines: Int = 0
    }
    
    enum TitleLabel {
        static let firstText: String = L10n.AppPopupView.settings
        static let secondText: String = L10n.AppPopupView.eBike
        static let thirdText: String = L10n.AppPopupView.giveAccess
        static let font: UIFont = .medium13
        static let textColor: UIColor = Colors.appGray.color
    }
    
    enum TitleImage {
        static let firstImage: UIImage = Images.setting.image
        static let secondImage: UIImage = Images.eBike.image
        static let thirdImage: UIImage = Images.locationService.image
        static let cornerRadis: CGFloat = 8
    }
    
    enum CloseButton {
        static let image: UIImage = Images.close.image.withRenderingMode(.alwaysOriginal)
        static let cornerRadius: CGFloat = 15
        static let backgroundColor: UIColor = Colors.appWhite.color
    }
    
    enum OpenSettingsButton {
        static let backgroundColor: UIColor = Colors.appGreen.color
        static let title: String = L10n.AppPopupView.openAppSettings
        static let titleColor: UIColor = .white
        static let titleFont: UIFont = .bold16
        static let cornerRadius: CGFloat = 25
    }
}

// MARK: - AccessPopupView

final class AccessPopupView: NibView {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var informationLabel: UILabel!
    @IBOutlet private weak var firstImageView: UIImageView!
    @IBOutlet private weak var firstTitleLabel: UILabel!
    @IBOutlet private weak var secondImageView: UIImageView!
    @IBOutlet private weak var secondTitleLabel: UILabel!
    @IBOutlet private weak var thirdImageView: UIImageView!
    @IBOutlet private weak var thirdTitleLabel: UILabel!
    @IBOutlet private weak var closeButton: UIButton!
    @IBOutlet private weak var openSettingsButton: UIButton!
    
    override func commonInit() {
        prepareUI()
    }
}

// MARK: - Prepares

private extension AccessPopupView {
    func prepareUI() {
        view.backgroundColor = Constant.backgroundColor
        
        prepareViews()
        prepareLabels()
        prepareImageViews()
        prepareButtons()
    }
    
    func prepareViews() {
        containerView.backgroundColor = Constant.ContainerView.backgroundColor
        containerView.layer.cornerRadius = Constant.ContainerView.cornerRadius
    }
    
    func prepareLabels() {
        informationLabel.text = Constant.InformationLabel.text
        informationLabel.font = Constant.InformationLabel.font
        informationLabel.textColor = Constant.InformationLabel.textColor
        informationLabel.numberOfLines = Constant.InformationLabel.numberOfLines
        informationLabel.textAlignment = .center
        
        firstTitleLabel.text = Constant.TitleLabel.firstText
        firstTitleLabel.font = Constant.TitleLabel.font
        firstTitleLabel.textColor = Constant.TitleLabel.textColor
        
        secondTitleLabel.text = Constant.TitleLabel.secondText
        secondTitleLabel.font = Constant.TitleLabel.font
        secondTitleLabel.textColor = Constant.TitleLabel.textColor
        
        thirdTitleLabel.text = Constant.TitleLabel.thirdText
        thirdTitleLabel.font = Constant.TitleLabel.font
        thirdTitleLabel.textColor = Constant.TitleLabel.textColor
    }
    
    func prepareImageViews() {
        firstImageView.image = Constant.TitleImage.firstImage
        firstImageView.layer.cornerRadius = Constant.TitleImage.cornerRadis
        
        secondImageView.image = Constant.TitleImage.secondImage
        secondImageView.layer.cornerRadius = Constant.TitleImage.cornerRadis
        
        thirdImageView.image = Constant.TitleImage.thirdImage
        thirdImageView.layer.cornerRadius = Constant.TitleImage.cornerRadis
    }
    
    func prepareButtons() {
        closeButton.setImage(Constant.CloseButton.image, for: .normal)
        closeButton.layer.cornerRadius = Constant.CloseButton.cornerRadius
        closeButton.backgroundColor = Constant.CloseButton.backgroundColor
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        
        openSettingsButton.setTitle(Constant.OpenSettingsButton.title, for: .normal)
        openSettingsButton.setTitleColor(Constant.OpenSettingsButton.titleColor, for: .normal)
        openSettingsButton.titleLabel?.font = Constant.OpenSettingsButton.titleFont
        openSettingsButton.backgroundColor = Constant.OpenSettingsButton.backgroundColor
        openSettingsButton.layer.cornerRadius = Constant.OpenSettingsButton.cornerRadius
        openSettingsButton.addTarget(self, action: #selector(openSettingsButtonTapped), for: .touchUpInside)
    }
}

// MARK: - Actions

@objc
private extension AccessPopupView {
    func openSettingsButtonTapped() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString),
              UIApplication.shared.canOpenURL(settingsUrl) else {
            return
        }
        SwiftMessagesManager.shared.hide()
        UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
    }
    
    func closeButtonTapped() {
        SwiftMessagesManager.shared.hide()
    }
}
