//
//  OrderStatusView.swift
//  floriaConsumer
//
//  Created by Symsym on 8/1/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit

@IBDesignable class OrderStatusView: UIStackView {
    
    //MARK: Properties
    
    private var statusButtons = [UIButton]()
    
    var status = 0 {
        didSet {
            updateButtonSelectionStates()
        }
    }
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupButtons()
        }
    }
    
    let cellCount: Int = 7 /*{
        didSet {
            setupButtons()
        }
    }*/
    
    //MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    //MARK: Button Action
    
    @objc func ratingButtonTapped(button: UIButton) {
        guard let index = statusButtons.firstIndex(of: button) else {
            fatalError("The button, \(button), is not in the ratingButtons array: \(statusButtons)")
        }
        
        // Calculate the rating of the selected button
        let selectedStatus = index + 1
        
        if selectedStatus == status {
            // If the selected star represents the current rating, reset the rating to 0.
            //status = 0
        } else {
            // Otherwise set the rating to the selected star
            status = selectedStatus
        }
    }
    
    
    //MARK: Private Methods
    
    private func setupButtons() {
        // Clear any existing buttons
        for button in statusButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        
        statusButtons.removeAll()
        
        // Load Button Images
        let bundle = Bundle(for: type(of: self))
        let lineChecked = UIImage(named: "ic_horizontal_line_checked", in: bundle, compatibleWith: self.traitCollection),
        lineUnchecked = UIImage(named: "ic_horizontal_line_unchecked", in: bundle, compatibleWith: self.traitCollection)
        let bgSelected = UIImage(named: "bg_checked", in: bundle, compatibleWith: self.traitCollection),
        bgUnselected = UIImage(named: "bg_unchecked", in: bundle, compatibleWith: self.traitCollection)
        let placed = UIImage(named: "ic_order_status_placed", in: bundle, compatibleWith: self.traitCollection),
        processing = UIImage(named: "ic_order_status_processing", in: bundle, compatibleWith: self.traitCollection),
        shipped = UIImage(named: "ic_order_status_shipped", in: bundle, compatibleWith: self.traitCollection),
        delivered = UIImage(named: "ic_order_status_delivered", in: bundle, compatibleWith: self.traitCollection)
        let fgSelected = [placed, lineChecked, processing, lineChecked, shipped, lineChecked, delivered]
        let fgUnselected = [placed, lineUnchecked, processing, lineUnchecked, shipped, lineUnchecked, delivered]
        
        //let filledStar = UIImage(named: "bg_checked", in: bundle, compatibleWith: self.traitCollection)
        //let emptyStar = UIImage(named:"bg_unchecked", in: bundle, compatibleWith: self.traitCollection)
        //let highlightedStar = UIImage(named:"bg_checked", in: bundle, compatibleWith: self.traitCollection)
        
        for index in 0..<cellCount {
            // Create the button
            let button = UIButton()
            
            // Set the button images
            button.setImage(fgUnselected[index], for: .normal)
            button.setImage(fgSelected[index], for: .selected)
            button.setImage(fgSelected[index], for: .highlighted)
            button.setImage(fgSelected[index], for: [.highlighted, .selected])
            
            if index%2 == 0 {
                button.setBackgroundImage(bgUnselected, for: .normal)
                button.setBackgroundImage(bgSelected, for: .selected)
                button.setBackgroundImage(bgSelected, for: .highlighted)
                button.setBackgroundImage(bgSelected, for: [.highlighted, .selected])
            }
            
            // Add constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            // Set the accessibility label
            //button.accessibilityLabel = "Set \(index + 1) star rating"
            
            // Setup the button action
            button.addTarget(self, action: #selector(OrderStatusView.ratingButtonTapped(button:)), for: .touchUpInside)
            
            // Add the button to the stack
            addArrangedSubview(button)
            
            // Add the new button to the rating button array
            statusButtons.append(button)
        }
        
        updateButtonSelectionStates()
    }
    
    private func updateButtonSelectionStates() {
        for (index, button) in statusButtons.enumerated() {
            // If the index of a button is less than the rating, that button should be selected.
            button.isSelected = index < status
            
            // Set accessibility hint and value
            let hintString: String?
            
            if status == index + 1 {
                hintString = "Tap to reset the rating to zero."
            } else {
                hintString = nil
            }
            
            let valueString: String
            
            switch (status) {
            case 0:
                valueString = "No rating set."
            case 1:
                valueString = "1 star set."
            default:
                valueString = "\(status) stars set."
            }
            
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
        }
    }
}
