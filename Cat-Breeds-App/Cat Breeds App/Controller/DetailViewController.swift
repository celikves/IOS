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
    @IBOutlet weak var wikipedaURl: UILabel!
    @IBOutlet weak var breedDetailImage: UIImageView!
    
    var name : String = ""
    var origin : String = ""
    var wikipediaURL : String = ""
    var dogFriendly : String = ""
    var lifeSpan : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        //breedName.text = name
        breedDetail.text=name
        breedLifeSpan.text="Life Span : \(lifeSpan)"
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
