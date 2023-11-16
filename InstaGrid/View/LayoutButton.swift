//
//  LayoutButton.swift
//  InstaGrid
//
//  Created by Hugo Blas on 10/11/2023.
//

import UIKit

class LayoutButton: UIView {

    @IBOutlet private var icon: UIImageView!
    @IBOutlet private var selectedIcon: UIImageView!

    var isSelected: Bool = false {
        didSet {
            if isSelected {
                // apply selected icon
                selectedIcon.isHidden = false
            } else {
                // remove selected icon
                selectedIcon.isHidden = true
            }
        }
    }

}
