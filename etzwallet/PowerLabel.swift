//
//  PowerLabel.swift
//  etzwallet
//
//  Created by etz on 2018/7/25.
//  Copyright © 2018年 etzwallet LLC. All rights reserved.
//

import UIKit

private let largeFontSize: CGFloat = 28.0
class PowerLabel : UILabel {
    
    var formatter: NumberFormatter {
        didSet {
            setFormattedText(forValue: value,forCurrency: currency)
        }
    }
    
    var currency: String
    
    init(formatter: NumberFormatter,currency: String) {
        self.formatter = formatter
        self.currency = currency
        super.init(frame: .zero)
        font = UIFont.customBold(size: largeFontSize)
        textColor = .white
        text = self.formatter.string(from: 0 as NSNumber)
    }
    
    var completion: (() -> Void)?
    private var value: Decimal = 0.0
    
    func setValue(_ value: Decimal,_ currency: String) {
        self.value = value
        self.currency = currency
        setFormattedText(forValue: value,forCurrency: currency)
    }
    
    func setValueAnimated(_ endingValue: Decimal,_ currency: String, completion: @escaping () -> Void) {
        self.completion = completion
        guard let currentText = text else { return }
        guard let startingValue = formatter.number(from: currentText)?.decimalValue else { return }
        self.startingValue = startingValue
        self.endingValue = endingValue
        self.currency = currency
        
        timer?.invalidate()
        lastUpdate = CACurrentMediaTime()
        progress = 0.0
        
        startTimer()
    }
    
    private let duration = 0.6
    private var easingRate: Double = 3.0
    private var timer: CADisplayLink?
    private var startingValue: Decimal = 0.0
    private var endingValue: Decimal = 0.0
    private var progress: Double = 0.0
    private var lastUpdate: CFTimeInterval = 0.0
    
    private func startTimer() {
        timer = CADisplayLink(target: self, selector: #selector(PowerLabel.update))
        timer?.frameInterval = 2
        timer?.add(to: .main, forMode: .defaultRunLoopMode)
        timer?.add(to: .main, forMode: .UITrackingRunLoopMode)
    }
    
    @objc private func update() {
        let now = CACurrentMediaTime()
        progress = progress + (now - lastUpdate)
        lastUpdate = now
        if progress >= duration {
            timer?.invalidate()
            timer = nil
            setFormattedText(forValue: endingValue,forCurrency: currency)
            completion?()
        } else {
            let percentProgress = progress/duration
            let easedVal = 1.0-pow((1.0-percentProgress), easingRate)
            setFormattedText(forValue: startingValue + (Decimal(easedVal) * (endingValue - startingValue)),forCurrency: currency)
        }
    }
    
    private func setFormattedText(forValue: Decimal,forCurrency: String) {
        value = forValue
        if forCurrency == "Max"{
            text = formatter.string(from: value as NSDecimalNumber)
        }else{
            formatter.minimumFractionDigits = 2
            formatter.minimumIntegerDigits = 1
            text = formatter.string(from: value as NSDecimalNumber)
        }
        sizeToFit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

