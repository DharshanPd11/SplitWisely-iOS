//
//  PhotoCaptureController.swift
//  SplitWisely
//
//  Created by Priyadharshan Raja on 02/11/25.
//

import SwiftUI
import AVFoundation
import UIKit

struct CameraPicker: UIViewControllerRepresentable {
    @Environment(\.dismiss) private var dismiss
    var onImagePicked: (UIImage) -> Void
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: CameraPicker
        init(parent: CameraPicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.onImagePicked(image)
            }
            parent.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.dismiss()
        }
    }
}

import Vision

final class TextRecognizer {
    func extractText(from image: UIImage, completion: @escaping (String) -> Void) {
        guard let cgImage = image.cgImage else {
            completion("No CGImage found")
            return
        }

        let request = VNRecognizeTextRequest { request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation] else {
                completion("No text found")
                return
            }

            let text = observations.compactMap {
                $0.topCandidates(1).first?.string
            }.joined(separator: "\n")

            completion(text)
        }

        request.recognitionLanguages = ["en-US"]
        request.recognitionLevel = .accurate

        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        DispatchQueue.global(qos: .userInitiated).async {
            try? handler.perform([request])
        }
    }
}

struct PhotoCaptureView: View {
    @ObservedObject var viewModel: AddExpenseViewModel
//    @State private var showCamera = true
//    @State private var recognizedText = ""
//    private let recognizer = TextRecognizer()
    
    var isAuthorized: Bool {
        get async {
            let status = AVCaptureDevice.authorizationStatus(for: .video)
            var isAuthorized = status == .authorized
            
            // If the system hasn't determined the user's authorization status,
            // explicitly prompt them for approval.
            if status == .notDetermined {
                isAuthorized = await AVCaptureDevice.requestAccess(for: .video)
            }
            
            return isAuthorized
        }
    }

    @State private var showCamera = true
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
//            Text("Extracted Text:")
//                .font(.headline)
//
//            ScrollView {
//                Text(recognizedText.isEmpty ? "No text yet" : recognizedText)
//                    .padding()
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .background(Color.gray.opacity(0.1))
//                    .cornerRadius(8)
//            }
//            .frame(height: 300)
//
//            Button {
//                showCamera = true
//            } label: {
//                Label("Capture Photo", systemImage: "camera")
//                    .font(.headline)
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
        }
        .padding()
        .fullScreenCover(isPresented: $showCamera, onDismiss: {}){
    
            CameraPicker { capturedImage in
                viewModel.selectedImage = capturedImage
                dismiss()
            }
        }
//        .sheet(isPresented: $showCamera) {
//            CameraPicker { image in
//                recognizer.extractText(from: image) { text in
//                    DispatchQueue.main.async {
//                        recognizedText = text
//                    }
//                }
//            }
//        }
    }
}

#Preview {
//    let x = PhotoCaptureController()
}
