//
//  LayoutView.swift
//  InstaGrid
//
//  Created by Hugo Blas on 09/11/2023.
//

import UIKit

class LayoutView: UIView {

    @IBOutlet private var images : [LayoutImageView]!

    var layout: LayoutType = .twoUp {
        didSet {

        }
    }

    private func didChangeLayout(layout: LayoutType) {
        switch layout {
        case .square :
            break
        case .twoUp :
            break
        case .twoDown :
            break
        }
    }

}

enum LayoutType {
    case twoUp, twoDown, square
}
