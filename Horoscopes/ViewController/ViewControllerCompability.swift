//
//  ViewController.swift
//  Horoscopes
//
//  Created by Nguyen Duc Minh on 1/13/21.
//

import UIKit
import SideMenu

class ViewControllerCompability: UIViewController {
    @IBOutlet weak var buttonBigView: UIView!
    
    @IBOutlet weak var otherBackground: UIImageView!
    @IBOutlet weak var otherButtonView: UIView!
    @IBOutlet weak var whatIsMySignbackGround: UIImageView!
    @IBOutlet weak var whatIsMySignView: UIView!
    @IBOutlet weak var otherPersonButton: UIButton!
    var date1 = ""
    var checkBtn = Int()
    var date2 = ""
    var date = String()
    @IBOutlet weak var screenName: UILabel!
    
    @IBOutlet weak var whatIsMySignButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    var pic = ["Aries", "Taurus", "Gemini", "Cancer", "Leo", "Virgo", "Libra", "Scorpio","Sagittarius", "Capricorn", "Aquarius", "Pisces"]
    @IBOutlet weak var collectionView: UICollectionView!
    var menu:SideMenuNavigationController?
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var datePickerView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var donePickDateBtn: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var otherSignButton: UIButton!
    @IBAction func previousButton(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "YearlyZodiac")
        
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true, completion: nil)
        //
        //        }
        //
        //
        print("previous")
    }
    @IBAction func otherSignBtn(_ sender: Any) {
        if secondView.layer.isHidden==true{
            secondView.layer.isHidden=false
            
        }
        else{
            secondView.layer.isHidden=true
            
        }
        datePicker.addTarget(self, action:#selector(handler(sender:)), for: UIControl.Event.valueChanged)
        
        checkBtn = 2
        
    }
    @IBAction func nextButton(_ sender: Any) {
        //        let vc = storyboard?.instantiateViewController(identifier: "YearlyViewController") as!YearlyViewController
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "YearlyViewController")
        //        self.navigationController!.pushViewController(vc, animated: true)
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true, completion: nil)
        print("next")
        
    }
    @IBAction func doneDatePickBtn(_ sender: Any) {  _ = DateFormatter()
        
        
        
        if((date2) != "" && (date1) == ""){
            date1 = date
            //            let vc = storyboard?.instantiateViewController(identifier: "CompabilityViewController") as! CompabilityViewController
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "CompabilityViewController")
            //            self.navigationController!.pushViewController(vc, animated: true)
            vc.modalPresentationStyle = .fullScreen
            
            present(vc, animated: true, completion: nil)
            NotificationCenter.default.post(name: Notification.Name("dateCompability"), object: nil, userInfo:["date1": date1, "date2": date2])
            print("---date1 \(date1)")
            date1 = ""
            date2 = ""
            
        }
        else if((date1) != "" && (date2) == ""){
            date2=date
            //            let vc = storyboard?.instantiateViewController(identifier: "CompabilityViewController") as! CompabilityViewController
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "CompabilityViewController")
            //            self.navigationController!.pushViewController(vc, animated: true)
            vc.modalPresentationStyle = .fullScreen
            
            present(vc, animated: true, completion: nil)
            NotificationCenter.default.post(name: Notification.Name("dateCompability"), object: nil, userInfo:["date1": date1, "date2": date2])
            print("---date2 \(date2)")
            date1 = ""
            date2 = ""
        }
        else{
            if(checkBtn==1){
                date1=date
                secondView.layer.isHidden=true
                
                print("---date1 \(date1)")
            }
            else if(checkBtn==2){
                date2=date
                secondView.layer.isHidden=true
                
                print("---date2 \(date2)")
            }
        }
        secondView.layer.isHidden=true
        
        
    }
    @IBAction func whatIsMySignButton(_ sender: Any) {
        
        if secondView.layer.isHidden==true{
            secondView.layer.isHidden=false
            
        }
        else{
            secondView.layer.isHidden=true
            
        }
        datePicker.addTarget(self, action:#selector(handler(sender:)), for: UIControl.Event.valueChanged)
        
        checkBtn = 1
        
        
    }
    @objc func handler(sender:UIDatePicker){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        
        date = dateFormatter.string(from: datePicker.date )
        print(date2)
        
    }
    
    override func viewDidLoad() {
        buttonBigView.backgroundColor = UIColor.clear
        secondView.layer.isHidden=true
        whatIsMySignbackGround.image = UIImage(named: "whatIsMySign")
        whatIsMySignButton.backgroundColor = UIColor.clear
        whatIsMySignButton.setTitle("          What is my sign?", for: .normal)
        whatIsMySignButton.setTitleColor(.white, for: .normal)
        whatIsMySignView.backgroundColor = UIColor.clear
        secondView.layer.isHidden=true
        otherBackground.image = UIImage(named: "whatIsMySign")
        otherPersonButton.backgroundColor = UIColor.clear
        otherPersonButton.setTitle("        Other sign?", for: .normal)
        otherPersonButton.setTitleColor(.white, for: .normal)
        otherButtonView.backgroundColor = UIColor.clear
        secondView.layer.cornerRadius = 20
        
        datePicker.layer.backgroundColor = UIColor.white.cgColor
        
        screenName.textColor = .white
        super.viewDidLoad()
        menu = SideMenuNavigationController(rootViewController:MenuList())
        menu?.setNavigationBarHidden(true, animated: false)	
        
        menu?.leftSide = true
        menu?.title = "Setting"
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        SideMenuManager.default.leftMenuNavigationController?.statusBarEndAlpha = 0
        screenName.text = "Compability"
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        let name = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView?.register(name, forCellWithReuseIdentifier: "CollectionViewCell")
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background4")!
            )}
        else{
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundPhone4")!)
        }
        
        
        
        
        
    }
    @IBAction func didTapMenu(){
        present(menu!, animated: true)
    }
    
}
extension ViewControllerCompability: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pic.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        cell.starImage.image = UIImage(named:pic[indexPath.row])
        
        cell.smallView.backgroundColor = UIColor.clear
        cell.backgroundColor = UIColor.clear
        cell.label.text = pic[indexPath.row]
        cell.label.textColor = .white
        collectionView.backgroundColor = UIColor.clear
        
        return cell
    }
    
    
}
extension ViewControllerCompability:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:(collectionView.frame.width) / 3.7, height: (collectionView.frame.height) / 4.3)
    }
}




















