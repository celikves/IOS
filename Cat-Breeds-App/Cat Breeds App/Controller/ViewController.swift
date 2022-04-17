//
//  ViewController.swift
//  Cat Breeds App
//
//  Created by vesile çelik on 11.04.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapButton(){
        let viewcontrol = UIViewController()
        viewcontrol.view.backgroundColor = .orange
        
        navigationController?.pushViewController(viewcontrol, animated: true)
    }
}

