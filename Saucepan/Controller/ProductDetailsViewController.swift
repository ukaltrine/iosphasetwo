//
//  ProductDetailsViewController.swift
//  Saucepan
//
//  Created by Kaltrina UKA on 3/15/19.
//  Copyright © 2019 Kaltrina UKA. All rights reserved.
//

import UIKit
import ChameleonFramework

class ProductDetailsViewController: UIViewController  {

    var productName : String!
    var productImageName : String!
    var productAddress : String!
    
    var productNameLabel: UILabel = UILabel()
    var productAddressLabel: UILabel = UILabel()
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var productImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productName = "Restaurant Name"
        productImageName = "photo"
        productAddress = "St. Agim Ramadani, Nr.8"
        
        setupLabels()
        setProductInformation()
        addNotificationObserver()
    }
    
    
    //MARK: __________________________________________________Labels
    func setupLabels(){
        
        productAddressLabel.frame = CGRect(x: 20, y: self.mainView.frame.size.height - 115.0 , width: self.mainView.frame.size.width - 40 , height: 45)
        productAddressLabel.backgroundColor = UIColor.flatYellow()
        productAddressLabel.textColor = UIColor.flatWhite()
        productAddressLabel.textAlignment = .center
        mainView.addSubview(productAddressLabel)
        
        productNameLabel.frame = CGRect(x: 20, y: self.mainView.frame.size.height - 50.0 - (productAddressLabel.frame.size.height + 20) * 2 , width: self.mainView.frame.size.width - 40 , height: 45)
        productNameLabel.backgroundColor = UIColor.flatGreen()
        productNameLabel.textColor = UIColor.flatWhite()
        productNameLabel.textAlignment = .center
        mainView.addSubview(productNameLabel)
        
    }

    func setProductInformation(){
        
        productNameLabel.text = productName
        productImageView.image = UIImage(named: productImageName)
        productAddressLabel.text = productAddress
        
        addGestureRecognizer()
    }
    
    //MARK: __________________________________________________Notifications WON'T WORK
    func addNotificationObserver(){

        NotificationCenter.default.addObserver(self, selector: #selector(productDetailsHandler(notification:)), name: Notification.Name("productSelected"), object: nil)
        
        print("notification added")
    }
    @objc func productDetailsHandler(notification: Notification){
        
        print("notified")
        
        if let product = notification.object as? Restaurant{
            productName = product.restaurantName
            productImageName = product.restaurantLogo
            productAddress = product.restaurantStreetAddress
            setupLabels()
            setProductInformation()
        }
        
    }
    
    
    //MARK: __________________________________________________Gesture Recognizer
    func addGestureRecognizer(){
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.view.addGestureRecognizer(tap)
        
    }
    
    @objc func handleTap(){
        let msg = "\(productNameLabel.text!.description) and \(productAddressLabel.text!.description)"
        setupAlert(msg)
    }
    
    //MARK: __________________________________________________Alert Function
    func setupAlert(_ msg: String){
        
        let alertViewController = UIAlertController(title: "Labels' data", message: msg, preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "Yep", style: .default, handler: nil))
        self.present(alertViewController, animated: true)
        
    }
    
}
