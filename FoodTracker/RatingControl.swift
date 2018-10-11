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

    var rating = 0 {
        didSet {
            updateButtonSelectionStates()
        }
    }

    private var ratingButtons = [UIButton]()

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

        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection)

        for index in 0..<starts {
        let button = UIButton()
        button.setImage(emptyStar, for: .normal)
        button.setImage(filledStar, for: .selected)
        button.setImage(highlightedStar, for: .highlighted)
        button.setImage(highlightedStar, for: [.highlighted, .selected])
        button.accessibilityLabel = "Set \(index + 1) star rating"
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
        button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
        button.addTarget(self ,
                         action: #selector(RatingControl.ratingButtonTapped(button: )),
                         for: .touchUpInside)

        addArrangedSubview(button)

        ratingButtons.append(button)
        }

        updateButtonSelectionStates()
    }

    @objc
    func ratingButtonTapped(button: UIButton) {
        guard let index = ratingButtons.index(of: button) else {
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")}

        let selectedRating = index + 1

        if selectedRating == rating {
            rating = 0
        } else {
            rating = selectedRating
        }
    }

    func clearButtons() {
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
    }

    private func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
        }
    }
}
