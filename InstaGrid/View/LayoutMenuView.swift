//
//  LayoutView.swift
//  InstaGrid
//
//  Created by Hugo Blas on 09/11/2023.
//

import UIKit

class LayoutMenuView: UIStackView {
    var layout: LayoutType = .twoUp
}

enum LayoutType: CaseIterable {
    case twoUp,
         twoDown,
         square

    var image: UIImage {
        switch self {
        case .twoUp:
            return UIImage(named: "Layout 2")!
        case .twoDown:
            return UIImage(named: "Layout 1")!
        case .square:
            return UIImage(named: "Layout 3")!
        }
    }
}
