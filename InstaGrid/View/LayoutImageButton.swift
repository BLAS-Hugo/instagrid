//
//  LayoutImageButton.swift
//  InstaGrid
//
//  Created by Hugo Blas on 05/01/2024.
//

import Foundation
import UIKit
import Combine

class LayoutImageButton: UIView {

    var onTapButton: (() -> Void)?

    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }

    init(image: UIImage?, id: String, storageManager: ImageStorageManager) {
        super.init(frame: .zero)
        self.image = image
        self.storageManager = storageManager
        self.id = id
        setupUI(with: image)
        subscribe()
    }

    var id = ""

    private var image: UIImage? {
        didSet {
            setupUI(with: image)
        }
    }

    private var icon: UIImageView!

    func setupUI(with image: UIImage?) {
        if image == nil {
            icon = UIImageView(frame: .zero)
            icon.translatesAutoresizingMaskIntoConstraints = false
            icon.image = UIImage(named: "Plus")
            addSubview(icon)
            NSLayoutConstraint.activate([
                icon.widthAnchor.constraint(equalToConstant: 40),
                icon.heightAnchor.constraint(equalToConstant: 40),
                icon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                icon.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            ])
        } else {
            icon = UIImageView(frame: .zero)
            icon.translatesAutoresizingMaskIntoConstraints = false
            icon.image = image!
            addSubview(icon)
            NSLayoutConstraint.activate([
                icon.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
                icon.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
                icon.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
                icon.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0)
            ])
        }

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
        addGestureRecognizer(tapGesture)
    }

    @objc private func didTap() {
        onTapButton?()
    }

    var subscriptions = Set<AnyCancellable>()
    private var storageManager: ImageStorageManager?

    func subscribe() {
        storageManager!.imagesPublisher.sink { images in
            images.forEach {
                if $0.key == self.id {
                    self.setupUI(with: $0.value)
                }
            }
        }.store(in: &subscriptions)
    }
}
