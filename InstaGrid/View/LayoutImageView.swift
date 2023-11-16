//
//  LayoutImageView.swift
//  InstaGrid
//
//  Created by Hugo Blas on 09/11/2023.
//

import UIKit

class LayoutImageView: UIView {

    // Will display image or " + " icon
    @IBOutlet private var image: UIImageView!

    private var imageWidth: Int = 138 {
        didSet {
            frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: 
                            CGFloat(integerLiteral: imageWidth), height: frame.height)
        }
    }
}
