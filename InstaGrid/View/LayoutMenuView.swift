//
//  LayoutView.swift
//  InstaGrid
//
//  Created by Hugo Blas on 09/11/2023.
//

import UIKit

class LayoutView: UIView {

    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }

    init() {
        super.init(frame: CGRect())
        for layout in LayoutType.allCases {
            self.addSubview(LayoutButton(with: layout))
        }
    }

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

enum LayoutType: CaseIterable {
    case twoUp, twoDown, square
}
