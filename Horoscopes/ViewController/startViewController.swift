//
//  startViewController.swift
//  Horoscopes
//
//  Created by Nguyễn Minh on 1/27/21.
//

import UIKit
import SideMenu
class startViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    var menu:SideMenuNavigationController?
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var palmButton: UIButton!
    @IBOutlet weak var ageButton: UIButton!
    @IBOutlet weak var horoscopeButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Home")!)
        menu = SideMenuNavigationController(rootViewController:MenuList())
        menu?.setNavigationBarHidden(true, animated: false)
        
        menu?.leftSide = true
        menu?.title = "Setting"
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        SideMenuManager.default.leftMenuNavigationController?.statusBarEndAlpha = 0
        // Do any additional setup after loading the view.
    }
    

    @IBAction func settingButton(_ sender: Any) {
        present(menu!, animated: true, completion: nil)
    }
    @IBAction func horoscopeButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "sceen1")

            vc.modalPresentationStyle = .fullScreen
        
            present(vc, animated: true, completion: nil)
       
    }
    @IBAction func ageButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CameraViewController")

            vc.modalPresentationStyle = .fullScreen
        
            present(vc, animated: true, completion: nil)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "typeScreen"), object: nil, userInfo:["info": "Face"])
        
    }
    
    @IBAction func palmButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TakePhotoViewController")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        NotificationCenter.default.post(name: Notification.Name("typeScreen"), object: nil, userInfo:["info": "Palm"])
    }
 
    
}
