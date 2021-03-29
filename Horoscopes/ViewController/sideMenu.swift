//
//  sideMenu.swift
//  Horoscopes
//
//  Created by Nguyen Duc Minh on 1/21/21.
//

import Foundation
import SideMenu
import StoreKit
var switchOn = false
class MenuList:UITableViewController{
  
   
    var menuList = ["Push Notification","Rate this app"]
    let name = UINib(nibName: "TableViewCell", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
       
        if UIDevice.current.userInterfaceIdiom == .pad {
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "sideMenuIpad")!
            )}
        else{
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "menuside")!)
        }
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(UIScreen.main.bounds.height/10)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:TableViewCell = tableView.dequeueReusableCell(withIdentifier:"TableViewCell", for: indexPath) as! TableViewCell
        cell.`switch`.isHidden = true
        if (indexPath.row == 0) {
            cell.`switch`.isHidden = false
        }
        cell.label.text = menuList[indexPath.row]
        cell.label.textColor = .white
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        

        cell.backgroundColor = UIColor.clear
        cell.smallView.backgroundColor = UIColor.clear
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        if(indexPath.row==1){
            if #available(iOS 13.0, *) {
                
                if let scene = UIApplication.shared.currentScene {
                    if #available(iOS 14.0, *) {
                        SKStoreReviewController.requestReview(in: scene)
                    } else {
                        SKStoreReviewController.requestReview()
                    }
                }
            }
            else{
                SKStoreReviewController.requestReview()
                AppStoreReviewManager.requestReviewIfAppropriate()

            }
        }
     
        
        
    }
}
@available(iOS 13.0, *)
extension UIApplication {
    var currentScene: UIWindowScene? {
        connectedScenes
            .first { $0.activationState == .foregroundActive } as? UIWindowScene
    }
}
