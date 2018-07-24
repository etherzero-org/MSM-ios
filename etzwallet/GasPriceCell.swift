//
//  GasPriceCell.swift
//  etzwallet
//
//  Created by etz on 2018/7/24.
//  Copyright © 2018年 etzwallet LLC. All rights reserved.
//

import UIKit

class GasPriceCell : SendCell {
    
    init(placeholder: String,label: String) {
        super.init()
        textView.delegate = self
        textView.textColor = .darkText
        textView.font = .customBody(size: 20.0)
        textView.returnKeyType = .done
        self.placeholder.text = placeholder
        self.labelView.text = label
        setupViews()
    }
    
    var labeltext = String.self
    var didBeginEditing: (() -> Void)?
    var didReturn: ((UITextView) -> Void)?
    var didChange: ((String) -> Void)?
    var content: String? {
        didSet {
            textView.text = content
            textViewDidChange(textView)
        }
    }
    
    let textView = UITextView()
    let labelView = UILabel(font: .customBody(size: 16.0), color: .grayTextTint)
    fileprivate let placeholder = UILabel(font: .customBody(size: 16.0), color: .grayTextTint)
    private func setupViews() {
        textView.isScrollEnabled = false
        addSubview(textView)
        textView.constrain([
            textView.constraint(.leading, toView: self, constant: 11.0),
            textView.topAnchor.constraint(equalTo: topAnchor, constant: C.padding[2]),
            textView.heightAnchor.constraint(greaterThanOrEqualToConstant: 30.0),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -C.padding[2]) ])
        
        textView.addSubview(placeholder)
        textView.addSubview(labelView)
        placeholder.constrain([
            placeholder.centerYAnchor.constraint(equalTo: textView.centerYAnchor),
            placeholder.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: 5.0) ])
        labelView.constrain([
            labelView.centerYAnchor.constraint(equalTo: placeholder.centerYAnchor),
            labelView.trailingAnchor.constraint(equalTo: placeholder.trailingAnchor, constant: C.padding[36]),
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GasPriceCell : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        didBeginEditing?()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        placeholder.isHidden = textView.text.utf8.count > 0
        if let text = textView.text {
            didChange?(text)
        }
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        guard text.rangeOfCharacter(from: CharacterSet.newlines) == nil else {
            textView.resignFirstResponder()
            return false
        }
        
        let count = (textView.text ?? "").utf8.count + text.utf8.count
        if count > C.maxMemoLength {
            return false
        } else {
            return true
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        didReturn?(textView)
    }
}

