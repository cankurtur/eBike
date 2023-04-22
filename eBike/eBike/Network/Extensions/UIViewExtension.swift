//
//  UIViewExtension.swift
//  eBike
//
//  Created by Can Kurtur on 21.04.2023.
//

import UIKit

extension UIView {
    
    enum Margin {
        case top(_ constant: CGFloat)
        case bottom(_ constant: CGFloat)
        case leading(_ constant: CGFloat)
        case trailing(_ constant: CGFloat)
        case all(_ constant: CGFloat = 0.0)
    }
    
    enum Dimension {
        case height(_ constant: CGFloat)
        case width(_ constant: CGFloat)
    }
    
    func edgesToSuperview(_ constant: CGFloat = 0.0) {
        guard let superview = self.superview else {
            return
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: constant).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: constant).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: constant * -1).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: constant * -1).isActive = true
    }
    
    func edgesTo(_ view: UIView, to margin: [Margin]) {
        self.translatesAutoresizingMaskIntoConstraints = false
        margin.forEach {
            switch $0 {
            case .top(let constant):
                self.topAnchor.constraint(equalTo: view.topAnchor, constant: constant).isActive = true
            case .leading(let constant):
                self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant).isActive = true
            case .trailing(let constant):
                self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: constant * -1).isActive = true
            case .bottom(let constant):
                self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: constant * -1).isActive = true
            case .all(let constant):
                edgesToSuperview(constant)
                return
            }
        }
    }
    
    
    func edgesToItself(to size: [Dimension]) {
        self.translatesAutoresizingMaskIntoConstraints = false
        size.forEach {
            switch $0 {
            case .height(let constant):
                self.heightAnchor.constraint(equalToConstant: constant).isActive = true
            case .width(let constant):
                self.widthAnchor.constraint(equalToConstant: constant).isActive = true
            }
        }
    }
}
