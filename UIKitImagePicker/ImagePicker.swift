//
//  ImagePicker.swift
//  UIKitImagePicker
//
//  Created by Development on 2025/05/22.
//

import PhotosUI
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        let picker = PHPickerViewController(configuration: configuration)
        // PHPickerViewControllerの処理の一部をcoordinatorで実施（クラスや構造体の一部を他のクラスでできるようにする）
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

    func makeCordinator() -> Cordinator {
        return Cordinator(parent: self) // selfで構造体を指定
    }

    // Delegate: クラスや構造体の一部を他のクラスでできるようにする
    class Cordinator: PHPickerViewControllerDelegate {
        let parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            for image in results {
                image.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: { image, _ in
                    if let image = image as? UIImage {
                        self.parent.selectedImage = image
                    }
                })
            }
        }
    }
}
