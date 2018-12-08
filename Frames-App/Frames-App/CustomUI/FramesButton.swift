//
//  FramesButton.swift
//  Frames-App
//
//  Created by Tyler Zhao on 12/7/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import UIKit

public class FramesButton: UIButton {
    
    public var titleText: String = "" {
        didSet {
            self.titleLabel?.attributedText = NSAttributedString(string: titleText,
                                                                 attributes: [NSAttributedString.Key.font: Constants.Fonts.buttonFont,
                                                                              NSAttributedString.Key.foregroundColor: Constants.framesButtonTextColor])
        }
    }
    
    init(titleText: String) {
        self.init()
        self.titleText = titleText
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    private func configure() {
        self.cornerRadius = Constants.buttonCornerRadius
        self.backgroundColor = Constants.framesButtonBackgroundColor
        
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 30),
                                     self.heightAnchor.constraint(equalToConstant: Constants.framesButtonHeight)])
        
    }
    
}