//
//  DetailViewController.swift
//  Cat Breeds App
//
//  Created by vesile çelik on 19.04.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var breedDetail: UILabel!
    @IBOutlet weak var breedOrigin: UILabel!
    @IBOutlet weak var breedDogFriendly: UILabel!
    @IBOutlet weak var breedLifeSpan: UILabel!
    @IBOutlet weak var breedWikipediaURL: UILabel!
    @IBOutlet weak var breedDetailImage: UIImageView!
    
    @IBOutlet weak var breedWikipediaButton: UIButton!
    
    
    var detail : String = ""
    var origin : String = ""
    var wikipediaURL : String = ""
    var dogFriendly : String = ""
    var lifeSpan : String = ""
    var breedImageUrl : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = downloadImage(with:breedImageUrl ?? "") { image in
            self.breedDetailImage.image = image
       }
        breedOrigin.text="Origin : \(origin)"
        breedLifeSpan.text="Life Span : \(lifeSpan)"
        breedDetail.text="\(detail)"
        breedWikipediaButton.setTitle("Wikipedia URL : \(wikipediaURL)", for: .normal)
      
        
        
        
    }
 
    @IBAction func wikipediaAction(_ sender: UIButton) {
        
        guard let url = URL(string: wikipediaURL) else {
          return //be safe
        }

        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
}
