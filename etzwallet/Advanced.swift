//
//  Advanced.swift
//  etzwallet
//
//  Created by etz on 2018/7/20.
//  Copyright © 2018年 etzwallet LLC. All rights reserved.
//

import UIKit

class AdvancedBtn : UIView {
    
//    private let container = UIView()
    private var titles:String = ""
    public let label = UIButton(type: .system)
    init(title: String) {
        titles = title
        super.init(frame:.zero)
        setup()
    }
    
    private func setup() {
        addSubviews()
        addConstraints()
        setupStyle()
    }
    
    private func addSubviews() {
//        container.isUserInteractionEnabled = false
//        label.isUserInteractionEnabled = false
//        addSubview(container)
        addSubview(label)
    }
    
    private func addConstraints() {
        label.constrain([
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -C.padding[2]),
            label.centerYAnchor.constraint(equalTo: centerYAnchor, constant: C.padding[2])
            ])
        
        label.setTitle(titles, for: .normal)
    }
    
    private func setupStyle() {
//        container.layer.cornerRadius = C.Sizes.roundedCornerRadius
//        container.clipsToBounds = true
    }
    
//    override var isHighlighted: Bool {
//        didSet {
//            if isHighlighted {
//                container.backgroundColor = .lightGray
//            } else {
//                container.backgroundColor = .grayBackground
//            }
//        }
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

