//
//  AppPopupView.swift
//  eBike
//
//  Created by Can Kurtur on 23.04.2023.
//

import UIKit

// MARK: - Constant

private enum Constant {
    static let backgroundColor: UIColor = .clear
    
    enum ContainerView {
        static let backgroundColor: UIColor = .white
        static let cornerRadius: CGFloat = 30
    }
    
    enum TitleLabel {
        static let textColor: UIColor = Colors.appBlack.color
        static let font: UIFont = .bold16
        static let numberOfLines: Int = 0
        static let textAlignment: NSTextAlignment = .center
    }
    
    enum Description {
        static let textColor: UIColor = Colors.appBlack.color
        static let font: UIFont = .medium14
        static let numberOfLines: Int = 0
        static let textAlignment: NSTextAlignment = .center
    }
    
    enum ActionButton {
        static let titleColor: UIColor = .white
        static let font: UIFont = .bold20
        static let backgroundColor: UIColor = Colors.appGreen.color
        static let cornerRadius: CGFloat = 25
    }
}

// MARK: - AppPopupView

final class AppPopupView: NibView {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var actionButton: UIButton!
    private var actionButtonHandler: (() -> Void)?
    
    override func commonInit() {
        prepareUI()
    }
    
    func configure(with model: AppPopupViewModel) {
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        actionButton.setTitle(model.buttonTitle, for: .normal)
        actionButtonHandler = model.buttonAction
    }
}

// MARK: - Prepares

private extension AppPopupView {
    func prepareUI() {
        view.backgroundColor = Constant.backgroundColor
        
        prepareViews()
        prepareLabels()
        prepareButtons()
    }
    
    func prepareViews() {
        containerView.backgroundColor = Constant.ContainerView.backgroundColor
        containerView.layer.cornerRadius = Constant.ContainerView.cornerRadius
    }
    
    func prepareLabels() {
        titleLabel.font = Constant.TitleLabel.font
        titleLabel.textColor = Constant.TitleLabel.textColor
        titleLabel.numberOfLines = Constant.TitleLabel.numberOfLines
        titleLabel.textAlignment = Constant.TitleLabel.textAlignment
        
        descriptionLabel.font = Constant.Description.font
        descriptionLabel.textColor = Constant.Description.textColor
        descriptionLabel.numberOfLines = Constant.Description.numberOfLines
        descriptionLabel.textAlignment = Constant.Description.textAlignment
    }
    
    func prepareButtons() {
        actionButton.setTitleColor(Constant.ActionButton.titleColor, for: .normal)
        actionButton.titleLabel?.font = Constant.ActionButton.font
        actionButton.backgroundColor = Constant.ActionButton.backgroundColor
        actionButton.layer.cornerRadius = Constant.ActionButton.cornerRadius
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
}

// MARK: - Actions

@objc
private extension AppPopupView {
    func actionButtonTapped() {
        actionButtonHandler?()
    }
}
