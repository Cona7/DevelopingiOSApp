//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Josip Glasovac on 10/10/2018.
//  Copyright © 2018 Josip Glasovac. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {

    @IBInspectable var starts: Int = 5 {
        didSet {
            setupButtons()
        }
    }

    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupButtons()
        }
    }

    private var ratingButtons = [UIButton]()

    var rating = 0

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupButtons()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)

        setupButtons()
    }

    private func setupButtons() {

        clearButtons()

        for _ in 0..<starts {
        let button = UIButton()
        button.backgroundColor = UIColor.red
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
        button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true

        addArrangedSubview(button)

        button.addTarget(self ,
                         action: #selector(RatingControl.ratingButtonTapped(button: )),
                         for: .touchUpInside)

        ratingButtons.append(button)
        }
    }

    @objc
    func ratingButtonTapped(button: UIButton) {
        print("Button pressed 👍")
    }

    func clearButtons() {
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
    }
}
