//
//  DynamicImageView.swift
//  news
//
//  Created by Kaustubh on 06/03/18.
//  Copyright © 2018 KaustubhtestApp. All rights reserved.
//

import Foundation
import UIKit

class  DynamicImageView: UIImageView {
    
    private var imagePath: String?
    {
        get {
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileURL = documentsDirectory.appendingPathComponent(self.imageName!)
            if FileManager.default.fileExists(atPath: fileURL.path)
            {
                return fileURL.path
            }
            
            return ""
        }
    }
    
    private var imageName: String?
    
    func downloadFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileURL = documentsDirectory.appendingPathComponent((self?.imageName)!)
            if let data = UIImageJPEGRepresentation(image, 1.0),
                !FileManager.default.fileExists(atPath: fileURL.path) {
                do {
                    // writes the image data to disk
                    try data.write(to: fileURL)
                    print("file saved")
                } catch {
                    print("error saving file:", error)
                }
            }
            DispatchQueue.main.async() {
                self?.image = image
            }
            }.resume()
    }
    func downloadFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        self.image = nil
        self.imageName = url.absoluteURL.lastPathComponent
        if self.imagePath?.characters.count != 0
        {
            self.image = UIImage.init(contentsOfFile: self.imagePath!)
        }
        else
        {
            downloadFrom(url: url, contentMode: mode)
        }
    }
}
