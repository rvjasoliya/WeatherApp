//
//  UIImageView+Extension.swift
//  Expire
//
//  Created by iMac on 02/02/23.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
    
    func storeImage(urlString: String, img: UIImage){
        let path = NSTemporaryDirectory().appending(UUID().uuidString)
        let url = URL(fileURLWithPath: path)
        let data = img.pngData()
        try? data?.write(to: url)
        var dict = UserDefaults.standard.object(forKey: "ImageCache") as? [String: String]
        if dict == nil {
            dict = [String:String]()
        }
        dict![urlString] = path
        UserDefaults.standard.set(dict, forKey: "ImageCache")
    }
    
    func loadImageUsingCache(with urlString: String) {
        self.image = #imageLiteral(resourceName: "userPlaceHolder")
        //check cache for image first
        if let dict = UserDefaults.standard.object(forKey: "ImageCache") as? [String: String] {
            if let path = dict[urlString] {
                if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                    let img = UIImage(data: data)
                    self.image = img
                    return
                }
            }
        }
        //otherwise fire off a new download
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            //download hit an error so lets return out
            if let error = error {
                print(error)
                return
            }
            DispatchQueue.main.async(execute: {
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                    self.storeImage(urlString: urlString, img: downloadedImage)
                    self.image = downloadedImage
                }
            })
        }).resume()
    }
    
}
