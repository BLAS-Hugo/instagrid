//
//  LayoutButton.swift
//  InstaGrid
//
//  Created by Hugo Blas on 10/11/2023.
//

import UIKit

class LayoutButton: UIView {

    var onTapButton: (() -> Void)?

    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }

    init(with buttonLayout: LayoutType, isSelected: Bool) {
        super.init(frame: .zero)
        isLayoutSelected = isSelected
        self.buttonLayout = buttonLayout
        setupUI(with: buttonLayout)
    }

    var buttonLayout: LayoutType = LayoutType.square

    private var icon: UIImageView!
    private var selectedIcon: UIImageView!

    var isLayoutSelected: Bool = false {
        didSet {
            selectedIcon.isHidden = !isLayoutSelected
        }
    }

    @objc private func didTapButton() {
        onTapButton?()
    }

    // UI setup functions
    private func setupUI(with buttonLayout: LayoutType) {
        setupIcon()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapButton))
        addGestureRecognizer(tapGesture)

        setupSelectedLayoutOverlay()
    }

    // Setup layout icon button
    private func setupIcon() {
        icon = UIImageView(frame: .zero)
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.image = buttonLayout.image
        addSubview(icon)
        NSLayoutConstraint.activate([
            icon.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            icon.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            icon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            icon.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0)
        ])
    }

    // Setup selected layout overlay
    private func setupSelectedLayoutOverlay() {
        selectedIcon = UIImageView(frame: .zero)
        selectedIcon.translatesAutoresizingMaskIntoConstraints = false
        selectedIcon.image = UIImage(named: "Selected")
        selectedIcon.isHidden = !isLayoutSelected
        addSubview(selectedIcon)
        NSLayoutConstraint.activate([
            selectedIcon.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            selectedIcon.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            selectedIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            selectedIcon.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0)
        ])
    }
}
