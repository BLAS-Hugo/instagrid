//
//  ViewController.swift
//  InstaGrid
//
//  Created by Hugo Blas on 06/11/2023.
//

import UIKit
import Combine

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var layoutMenu: LayoutMenuView!
    @IBOutlet weak var layoutView: LayoutImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutView.storageManager = self.storageManager
        layoutView.onTapButton = onImageSelectionTap
        initView()

        layoutView.setupUI()

        initSwipeRecognizers()
    }

    private var gestureRecognizer: UISwipeGestureRecognizer?

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if gestureRecognizer != nil {
            if UIDevice.current.orientation.isPortrait {
                view.removeGestureRecognizer(gestureRecognizer!)
                gestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeUp))
                gestureRecognizer!.numberOfTouchesRequired = 1
                gestureRecognizer!.direction = .up
                view.addGestureRecognizer(gestureRecognizer!)
            } else {
                view.removeGestureRecognizer(gestureRecognizer!)
                gestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeLeft))
                gestureRecognizer!.numberOfTouchesRequired = 1
                gestureRecognizer!.direction = .left
                view.addGestureRecognizer(gestureRecognizer!)
            }
        }
    }

    // Initializes the layout menu buttons
    private func initView() {
        for layout in LayoutType.allCases {
            let layoutButton = LayoutButton(with: layout, isSelected: layout == selectedLayout)
            layoutButton.translatesAutoresizingMaskIntoConstraints = false
            layoutMenu.addArrangedSubview(layoutButton)
            layoutButton.onTapButton = {
                self.unselectLayouts()
                layoutButton.isLayoutSelected = true
                self.adjustCentralView(layout: layout)
            }
            NSLayoutConstraint.activate([
                layoutButton.widthAnchor.constraint(equalToConstant: 70),
                layoutButton.heightAnchor.constraint(equalToConstant: 70)
            ])
        }
    }

    // Swipe detection functions
    private func initSwipeRecognizers() {
        gestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeUp))
        gestureRecognizer!.numberOfTouchesRequired = 1
        gestureRecognizer!.direction = .up
        view.addGestureRecognizer(gestureRecognizer!)
    }

    @objc private func didSwipeUp() {
        onSwipeUp()
    }

    private func onSwipeUp() {
        UIView.animate(withDuration: 0.5, delay: 0.0, animations: {
            self.layoutView.transform = CGAffineTransformMakeTranslation(0, -500)
        }, completion: nil)
        onSwipe()
    }

    @objc private func didSwipeLeft() {
        onSwipeLeft()
    }

    private func onSwipeLeft() {
        UIView.animate(withDuration: 0.5, delay: 0.0, animations: {
            self.layoutView.transform = CGAffineTransformMakeTranslation(-500, 0)
        }, completion: nil)
        onSwipe()
    }

    // Opens the Share bottom sheet with the screenshotted view
    private func onSwipe() {
        var imagesToShare = [UIImage]()
        imagesToShare.append(screenshot()!)

        let activityViewController = UIActivityViewController(
            activityItems: imagesToShare as [UIImage],
            applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.completionWithItemsHandler = { _, _, _, _ in
            if UIDevice.current.orientation.isPortrait {
                UIView.animate(withDuration: 1.0, delay: 0.0, animations: {
                    self.layoutView.transform = CGAffineTransformMakeTranslation(0, 0)
                }, completion: nil)
            } else {
                UIView.animate(withDuration: 1.0, delay: 0.0, animations: {
                    self.layoutView.transform = CGAffineTransformMakeTranslation(0, 0)
                }, completion: nil)
            }
        }
        present(activityViewController, animated: true, completion: nil)
    }

    // Image picker functions
    private var buttonId: String?
    private let storageManager = ImageStorageManager()

    // Delegate function reacting to image selection
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let image = info[.originalImage] as? UIImage
        storageManager.updateList(at: buttonId!, with: image!)
        self.dismiss(animated: true, completion: nil)
    }

    // Opens image picker sheet
    private func onImageSelectionTap(id: String) {
        buttonId = id
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }

    // Takes a screenshot of the central view
    private func screenshot() -> UIImage? {
            UIGraphicsBeginImageContext(layoutView.frame.size)
            guard let context = UIGraphicsGetCurrentContext() else { return nil }
            layoutView.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
        }

    // Layout selection functions
    var selectedLayout: LayoutType = .twoUp

    // Unselects all layouts on layout selection
    private func unselectLayouts() {
        layoutMenu.arrangedSubviews.forEach {
            ($0 as? LayoutButton)?.isLayoutSelected = false
        }
    }

    // Selects the tapped layout and updates the central view
    private func adjustCentralView(layout: LayoutType) {
        selectedLayout = layout
        layoutView.selectedLayout = layout
    }
}
