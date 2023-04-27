//
//  NibView.swift
//  eBike
//
//  Created by Can Kurtur on 23.04.2023.
//

import UIKit

open class NibView: UIView {
    var view: UIView!

    override public init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        commonInit()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
        commonInit()
    }
    
    func commonInit() {
        
    }
}

private extension NibView {
    func xibSetup() {
        backgroundColor = UIColor.clear
        view = loadNib()
        view.frame = bounds
        addSubview(view)

        view.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[childView]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["childView": view as Any]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[childView]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["childView": view as Any]))
    }
}
