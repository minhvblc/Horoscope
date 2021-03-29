//
//  ViewControllerDruidHoroscope.swift
//  Horoscopes
//
//  Created by Nguyen Duc Minh on 1/14/21.
//

import UIKit
import SideMenu

class ViewControllerDruidHoroscope: UIViewController {
    var date = String()
    let druid:[String] = ["Apple", "Ash", "Beech", "Birch", "Cedar", "Chestnut", "Cypress", "Elm", "Fig", "Fir", "Hazel", "Hornbeam", "Jashmine", "Linden", "Maple", "Mountain", "Nutwood", "Oak", "Olive", "Pine", "Poplar", "Willow"]
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var secondView: UIView!
    
    @IBOutlet weak var whatIsMySignButton: UIButton!
    
    @IBOutlet weak var datePickerView: UIView!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var donePickDateBtn: UIButton!
    @IBOutlet weak var druidCollection: UICollectionView!
    
    @IBOutlet weak var screenName: UILabel!
    
    @IBOutlet weak var buttonView: UIView!
    
    @IBOutlet weak var buttonBackground: UIImageView!
    
    
    
    
    @IBAction func backButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "YearlyViewController")
        
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true, completion: nil)
        print("next")
        
    }
    var menu:SideMenuNavigationController?
    @IBAction func doneDatePickBtn(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DruidDetailViewController")
        
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true, completion: nil)
        secondView.layer.isHidden=true
        
        NotificationCenter.default.post(name: Notification.Name("dateDruid"), object: nil, userInfo:["info": date])
    }
    
    
    override func viewDidLoad() {
        secondView.layer.isHidden=true
        buttonBackground.image = UIImage(named: "whatIsMySign")
        whatIsMySignButton.backgroundColor = UIColor.clear
        whatIsMySignButton.setTitle("          What is my sign?", for: .normal)
        whatIsMySignButton.setTitleColor(.white, for: .normal)
        buttonView.backgroundColor = UIColor.clear
        secondView.layer.isHidden=true
        
        datePicker.layer.backgroundColor = UIColor.white.cgColor
        secondView.layer.cornerRadius = 20
        
        super.viewDidLoad()
        menu = SideMenuNavigationController(rootViewController:MenuList())
        menu?.setNavigationBarHidden(true, animated: false)
        
        menu?.leftSide = true
        menu?.title = "Setting"
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        SideMenuManager.default.leftMenuNavigationController?.statusBarEndAlpha = 0
        screenName.text = "Druid Horoscope"
        
        screenName.textColor = .white
        druidCollection?.delegate = self
        druidCollection?.dataSource = self
        let name = UINib(nibName: "DruidCellCollectionViewCell", bundle: nil)
        druidCollection?.register(name, forCellWithReuseIdentifier: "DruidCellCollectionViewCell")
        if UIDevice.current.userInterfaceIdiom == .pad {
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background6")!
            )}
        else{
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundPhone6")!)
        }
        
        
        
        
    }
    @IBAction func whatIsMySignButton(_ sender: Any) {
        
        if secondView.layer.isHidden==true{
            secondView.layer.isHidden=false
            
        }
        else{
            secondView.layer.isHidden=true
            
        }
        datePicker.addTarget(self, action:#selector(handler(sender:)), for: UIControl.Event.valueChanged)
    }
    @objc func handler(sender:UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        date = dateFormatter.string(from: datePicker.date)
        print(date)
        
    }
    @IBAction func leftButton(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ViewControllerCompability")
        
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true, completion: nil)
        print("next")
    }
    
    @IBAction func didTapMenu(){
        present(menu!, animated: true)
    }
}


extension ViewControllerDruidHoroscope: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return druid.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = druidCollection.dequeueReusableCell(withReuseIdentifier: "DruidCellCollectionViewCell", for: indexPath) as! DruidCellCollectionViewCell
        cell.label.text = druid[indexPath.row]
        cell.contentView.layer.cornerRadius = 20.0
        cell.contentView.backgroundColor = .cyan
        druidCollection.backgroundColor = UIColor.clear
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DruidDetailViewController")
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        print(indexPath.row)
        NotificationCenter.default.post(name: Notification.Name("druidName"), object: nil, userInfo:["info": druid[indexPath.row]])
        
    }
    
    
}

extension ViewControllerDruidHoroscope: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:(collectionView.frame.width) , height: (collectionView.frame.height) / 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(20)
    }
}






















