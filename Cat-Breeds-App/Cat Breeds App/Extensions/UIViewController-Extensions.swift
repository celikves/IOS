//
//  UIViewController-Extensions.swift
//  Cat Breeds App
//
//  Created by vesile çelik on 5.05.2022.
//


import UIKit
extension UIViewController {

    func presentAlertWithTitle(title: String, message: String, options: String..., completion: @escaping (String) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, option) in options.enumerated() {
            alertController.addAction(UIAlertAction.init(title: option, style: .default, handler: { (action) in
                completion(options[index])
            }))
        }
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}


extension UIView{
    
    func startLoader() {
        let overlayView = UIView()
        overlayView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        overlayView.tag = 1368
        
        let activityIndicator = UIActivityIndicatorView(style: .large)

//        let activityIndicator = NVActivityIndicatorView(frame: .zero, type: .ballPulseSync, color: UIColor().genericBlueKnektuColor(), padding: 0)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        overlayView.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.widthAnchor.constraint(equalToConstant: 60),
            activityIndicator.heightAnchor.constraint(equalToConstant: 60),
            activityIndicator.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor)
        ])
        overlayView.addSubview(activityIndicator)
        self.addSubview(overlayView)
        activityIndicator.startAnimating()
    }
    
    func stopLoader() {
        if let background = viewWithTag(1368){
            background.removeFromSuperview()
        }
        self.isUserInteractionEnabled = true
    }
}
