//
//  AdvancedCell.swift
//  etzwallet
//
//  Created by etz on 2018/7/21.
//  Copyright © 2018年 etzwallet LLC. All rights reserved.
//

import UIKit

class AdvancedCell : UIView {
    
    static let defaultHeight: CGFloat = 10.0
    
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    let accessoryView = UIView()
    
    private func setupViews() {
        addSubview(accessoryView)
        accessoryView.constrain([
            accessoryView.constraint(.top, toView: self),
            accessoryView.constraint(.trailing, toView: self),
            accessoryView.heightAnchor.constraint(equalToConstant: AdvancedCell.defaultHeight) ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


