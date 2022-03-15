//
//  EntryViewController.swift
//  Tasks
//
//  Created by vesile çelik on 17.11.2021.
//

import UIKit

class EntryViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet var field : UITextField!
    
    var update: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        field.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTask))
    }
    
    func textFieldShouldReturn(_ textField : UITextField) -> Bool {
        saveTask()
        
        return true
    }
    
    @objc func saveTask(){
        guard let text = field.text, !text.isEmpty else{
            return
        }
        
        guard let  count = UserDefaults().value(forKey: "count") as? Int else{
            return
        }
        let newCount = count + 1
        
        UserDefaults().set(newCount, forKey: "count")
        UserDefaults().set(text, forKey: "task_\(newCount)")
        
        update?() //If update exists let's call it
        
        navigationController?.popViewController(animated: true  )

    }
    

    

}
