//
//  LayoutImageView.swift
//  InstaGrid
//
//  Created by Hugo Blas on 09/11/2023.
//

import UIKit
import Foundation

class LayoutImageView: UIStackView {

    var onTapButton: ((String) -> Void)?

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    init(selectedLayout: LayoutType) {
        super.init(frame: .zero)
        self.selectedLayout = selectedLayout
        setupUI()
    }

    var storageManager: ImageStorageManager?

    var selectedLayout: LayoutType = .twoUp {
        didSet {
            removeAllSubviews()

            applyLayout()
        }
    }

    func setupUI() {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(lessThanOrEqualToConstant: 300),
            self.heightAnchor.constraint(greaterThanOrEqualToConstant: 250)
        ])
        selectedLayout = .twoUp
        removeAllSubviews()
        applyLayout()
    }

    private func setupStackView() -> UIStackView {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }

    private func applyLayout() {
        let topStackView = setupStackView()
        let bottomStackView = setupStackView()

        var i = 0
        while i < 4 {
            let id = "\(1000 + i)"
            if i >= 2 {
                let view = LayoutImageButton(image: nil, id: id, storageManager: self.storageManager!)
                view.translatesAutoresizingMaskIntoConstraints = false
                view.backgroundColor = UIColor.white
                bottomStackView.addArrangedSubview(view)
                NSLayoutConstraint.activate([
                    view.topAnchor.constraint(equalTo: bottomStackView.topAnchor, constant: 0),
                    view.bottomAnchor.constraint(equalTo: bottomStackView.bottomAnchor, constant: 0)
                ])
                view.onTapButton = {
                    self.onTapButton?(view.id)
                }
            } else {
                let view = LayoutImageButton(image: nil, id: id, storageManager: self.storageManager!)
                view.translatesAutoresizingMaskIntoConstraints = false
                view.backgroundColor = UIColor.white
                topStackView.addArrangedSubview(view)
                NSLayoutConstraint.activate([
                    view.topAnchor.constraint(equalTo: topStackView.topAnchor, constant: 0),
                    view.bottomAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 0)
                ])
                view.onTapButton = {
                    self.onTapButton?(view.id)
                }
            }
            i += 1
        }

        switch selectedLayout {
        case .twoUp:
            topStackView.arrangedSubviews.first?.isHidden = true
        case .twoDown:
            bottomStackView.arrangedSubviews.last?.isHidden = true
        case.square:
            break
        }

        self.addArrangedSubview(bottomStackView)
        self.addArrangedSubview(topStackView)
    }

    private func removeAllSubviews() {
        self.arrangedSubviews.forEach {
            self.removeArrangedSubview($0)
            NSLayoutConstraint.deactivate($0.constraints)
            $0.removeFromSuperview()
        }
    }
}
