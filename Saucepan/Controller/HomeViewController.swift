//
//  HomeViewController.swift
//  Saucepan
//
//  Created by Kaltrina UKA on 3/14/19.
//  Copyright © 2019 Kaltrina UKA. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let userEmail = Auth.auth().currentUser!.email!.description
    
    let restaurants = ["Anise", "Sonder", "Bukatore", "Rockuzine", "Delish", "Trosha", "Artizan", "Door 74", "Sach", "Proper Pizza", "Chop"]
    
    let images = ["anise", "sonder", "bukatore", "rockuzine", "delish", "trosha", "artizan", "door74", "sach", "properpizza", "chop"]
    
    @IBOutlet weak var productsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegates()
        setupTableHeaderAndFooter()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductTableViewCell
        
        cell.setProductInformation(id: indexPath.row + 1, name: restaurants[indexPath.row], image: images[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productDetails = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "productDetailsViewController" ) as! ProductDetailsViewController
        
        productDetails.productName = restaurants[indexPath.row]
        productDetails.productImageName = images[indexPath.row]
        
        
        self.navigationController?.pushViewController(productDetails, animated: true)
    }
    
    func setDelegates(){
        productsTableView.delegate = self
        productsTableView.dataSource = self
        productsTableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        productsTableView.separatorStyle = .none
    }
    
    
    //MARK: __________________________________________________Header and Footer
    func setupTableHeaderAndFooter(){
        
        productsTableView.register(UINib(nibName: "Header", bundle: nil), forHeaderFooterViewReuseIdentifier: "header")
        let header = Bundle.main.loadNibNamed("Header", owner: self, options: nil)![0] as! Header
        productsTableView.tableHeaderView = header
        productsTableView.tableHeaderView!.frame.size.height = 50.0
        
        header.headerLabel.text = "\(userEmail)"
        
        productsTableView.register(UINib(nibName: "Footer", bundle: nil), forHeaderFooterViewReuseIdentifier: "footer")
        let footer = Bundle.main.loadNibNamed("Footer", owner: self, options: nil)![0] as! Footer
        productsTableView.tableFooterView = footer
        productsTableView.tableFooterView!.frame.size.height = 50.0


    }
    


}
