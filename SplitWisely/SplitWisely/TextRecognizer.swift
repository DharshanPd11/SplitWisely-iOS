//
//  TextRecognizer.swift
//  SplitWisely
//
//  Created by Priyadharshan Raja on 15/11/25.
//

import Vision
import SwiftUI

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
