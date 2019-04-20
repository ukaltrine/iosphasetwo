//
//  HomeScrollViewController.swift
//  Saucepan
//
//  Created by Kaltrina UKA on 4/15/19.
//  Copyright © 2019 Kaltrina UKA. All rights reserved.
//

import UIKit

class HomeScrollViewController: UIViewController, UIScrollViewDelegate,  UITableViewDelegate, UITableViewDataSource {
    
    var menuVisibility: Bool = false
    var controllersNames : [String] = ["Places", "Details", "Socials", "Locations"]
    
    @IBOutlet weak var tableMenuView: UITableView!
    @IBOutlet var menuView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var backView: UIView!
    
    @IBAction func mennuButton(_ sender: Any) {
        
        if(menuVisibility){
            closeMenu()
        }
        else{
            openMenu()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableMenuView.delegate = self
        tableMenuView.dataSource = self
        scrollView.delegate = self
        setUpHorizontalScrollView()
        setUpMenuView()

    }
    
    func setUpMenuView(){
        
         self.menuView.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: self.backView.frame.height)
        self.view.addSubview(menuView)
        menuView.alpha = 0
        
        tableMenuView.separatorColor = UIColor.randomFlat()
    }
    
    func closeMenu(){
        
        UIView.animate(withDuration: 0.3) {
            self.menuView.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: self.backView.frame.height)
            self.menuView.alpha = 0
        }
        menuVisibility = false
    }
    
    func openMenu(){
        
        UIView.animate(withDuration: 0.3) {
            self.menuView.frame = CGRect(x: 0, y: self.view.frame.height - CGFloat(self.controllersNames.count + 1) * 50.0 , width: self.view.frame.width, height: CGFloat(self.controllersNames.count) * 50.0)
            self.menuView.alpha = 1
        }
        menuVisibility = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controllersNames.count
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = controllersNames[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        scrollView.setContentOffset(CGPoint(x: CGFloat(indexPath.row) * CGFloat(self.view.frame.size.width), y: 0), animated: true)
        
        closeMenu()
        
    }
    
    func setUpHorizontalScrollView(){

        let restaurantsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "restaurantsVC") as! RestaurantsViewController
        
        let restaurantDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "productDetailsViewController") as! ProductDetailsViewController
        
        let webviewVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "webviewVC") as! WebViewController
        
        let mapviewVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mapviewVC") as! LocationsViewController
        
        
        let viewControllers = [restaurantsVC, restaurantDetailsVC, webviewVC, mapviewVC]

        scrollView.contentSize = CGSize(width: CGFloat(viewControllers.count) * self.view.frame.width, height: self.view.frame.height - 50)

        for index in 0...viewControllers.count - 1{
            
            self.addChild(viewControllers[index])
            viewControllers[index].view.frame = CGRect(x: CGFloat(index) * self.view.frame.width, y: 0, width: self.view.frame.width, height: self.backView.frame.height)
            scrollView.addSubview(viewControllers[index].view)
            
        }
        
    }
    
    


}
