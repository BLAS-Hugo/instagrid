//
//  ImageStorageManager.swift
//  InstaGrid
//
//  Created by Hugo Blas on 12/01/2024.
//

import Foundation
import UIKit

class ImageStorageManager: ObservableObject {

    init() {
        self.images = ["1000": nil, "1001": nil, "1002": nil, "1003": nil]
    }

    @Published var images = [String: UIImage?]()

    var imagesPublisher: Published<[String: UIImage?]>.Publisher {
        return $images
    }

    func updateList(at id: String, with image: UIImage) {
        var updatedImages = self.images
        updatedImages.updateValue(image, forKey: id)
        self.images = updatedImages
    }

    func getImage(at id: String) -> UIImage? {
        return images[id]!
    }
}
