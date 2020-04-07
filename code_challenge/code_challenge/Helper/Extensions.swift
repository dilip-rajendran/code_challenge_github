//
//  Extensions.swift
//  code-challenge
//
//  Created by Dilip on 3/25/20.
//  Copyright © 2020 Dilip. All rights reserved.
//
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

// MARK: - UIImageView extension
extension UIImageView {
    
    func loadImage(imageString: String?, completion: @escaping (UIImage?) -> Void) {
        guard let urlSting = imageString else { return }
        completion(nil)
        
        if let imageFromCache = imageCache.object(forKey: urlSting as AnyObject), let setImage = imageFromCache as? UIImage  {
            completion(setImage)
            return
        }
        NetworkLayer().getImageDataForURL(urlString: urlSting) { (data, error) in
            if let responseData = data {
                guard let imageToCache = UIImage(data: responseData) else { return }
                imageCache.setObject(imageToCache, forKey: urlSting as AnyObject)
                DispatchQueue.main.async {
                    completion(imageToCache)
                }
                
            } else {
                completion(nil)
            }

        }
    }
}

// MARK: - Date extension
extension Date {
    func dateAndTimetoString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
}

extension String {
    func convertDateToReadableString() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let dateFromString: Date? = dateFormatter.date(from: self)
        return dateFromString?.dateAndTimetoString()
    }
}
extension UILabel{
    var defaultFont: UIFont? {
        get { return self.font }
        set { self.font = newValue }
    }
}
