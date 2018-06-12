//
//  ViewController.swift
//  CacheImage
//
//  Created by tham gia huy on 6/12/18.
//  Copyright © 2018 tham gia huy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!

    var dispatchWorkItem: DispatchWorkItem?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let url = "http://s1.picswalls.com/wallpapers/2016/06/10/4k-high-definition-wallpaper_065229159_309.jpg"
        spinner.startAnimating()
        downloadImage(from: url) { (image) in
            self.photoImage.image = image
            self.spinner.stopAnimating()
            self.spinner.isHidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        dispatchWorkItem?.cancel()
    }
    func downloadImage(from urlString: String, completedHandler: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else { return  }
        var image: UIImage?
        dispatchWorkItem = DispatchWorkItem(block: {
            if let cache = CacheImage.images.object(forKey: url.absoluteString as NSString) as? UIImage {
                image = cache
            } else {
                if let data = try? Data(contentsOf: url) {
                    image = UIImage(data: data)
                    CacheImage.images.setObject(image!, forKey: url.absoluteString as NSString, cost: data.count)
                }
            }
        })
        DispatchQueue.global().async {
            self.dispatchWorkItem?.perform()
            DispatchQueue.main.async {
                completedHandler(image)
            }
        }
    }
}

