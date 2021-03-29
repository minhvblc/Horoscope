//
//  ViewController.swift
//  Horoscopes
//
//  Created by Nguyen Duc Minh on 1/13/21.
//

import UIKit
import SideMenu


class ViewController: UIViewController {
    var date = String()
    
    var callApi = ["3c59dc048e8850243be8079a5c74d079", "b6d767d2f8ed5d21a44b0e5886680cb9", "37693cfc748049e45d87b8c7d8b9aacd","1ff1de774005f8da13f42943881c655f", "8e296a067a37563370ded05f5a3bf3ec", "4e732ced3463d06de0ca9a15b6153677", "02e74f10e0327ad868d138f2b4fdd6f0", "33e75ff09dd601bbe69f351039152189", "6ea9ab1baa0efb9e19094440c317e21b", "6f3ef77ac0e3619e98159e9b6febf557", "eb163727917cbba1eea208541a643e74", "1534b76d325a8f591b52d302e7181331"]
    
    
    @IBOutlet var datePickerView: UIView!
    
    @IBOutlet weak var doneDatePickerBtn: UIButton!
    
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var whatIsMySign: UIImageView!
    @IBOutlet weak var surfaceWhatIsMySIgn: UIImageView!
    
    @IBOutlet weak var whatIsMySignButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    var pic = ["Aries", "Taurus", "Gemini", "Cancer", "Leo", "Virgo", "Libra", "Scorpio","Sagittarius", "Capricorn", "Aquarius", "Pisces"]
    
    
    
    @IBOutlet weak var dailyCollectionView: UICollectionView!
    var menu:SideMenuNavigationController?
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var buttonBackground: UIImageView!
    @IBAction func rightButton(_ sender: Any) {
        
        //        let vc = storyboard?.instantiateViewController(identifier: "ZodiacCharacteristics") as! ZodiacCharacteristicsViewController
        //        vc.modalPresentationStyle = .fullScreen
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ZodiacCharacteristics")
        vc.modalPresentationStyle = .fullScreen
        //        self.navigationController!.pushViewController(vc, animated: true)
        present(vc, animated: true, completion: nil)
        
        
    }
    
    @IBAction func doneDatePickerBtn(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController")
        
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true, completion: nil)
        secondView.layer.isHidden=true
        
        NotificationCenter.default.post(name: Notification.Name("dateDaily"), object: nil, userInfo:["info": date])
        print(date)
        
    }
    @IBAction func settingButton(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "startViewController")
        
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true, completion: nil)
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
    
    
    override func viewDidLoad() {
        
        buttonBackground.image = UIImage(named: "whatIsMySign")
        whatIsMySignButton.backgroundColor = UIColor.clear
        whatIsMySignButton.setTitle("          What is my sign?", for: .normal)
        whatIsMySignButton.setTitleColor(.white, for: .normal)
        buttonView.backgroundColor = UIColor.clear
        
        secondView.layer.isHidden=true
        
        secondView.layer.cornerRadius = 20
        
        datePicker.layer.backgroundColor = UIColor.white.cgColor
        
        super.viewDidLoad()
        screenName.text = "Daily Horoscope"
        screenName.textColor = .white
        
        menu = SideMenuNavigationController(rootViewController:MenuList())
        menu?.setNavigationBarHidden(true, animated: false)
        
        menu?.leftSide = true
        menu?.title = "Setting"
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        SideMenuManager.default.leftMenuNavigationController?.statusBarEndAlpha = 0
        
        dailyCollectionView.delegate = self
        dailyCollectionView.dataSource = self
        let name = UINib(nibName: "CollectionViewCell", bundle: nil)
        dailyCollectionView?.register(name, forCellWithReuseIdentifier: "CollectionViewCell")
        if UIDevice.current.userInterfaceIdiom == .pad {
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background1")!
            )}
        else{
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundPhone1")!)
        }
        
    }
    @IBAction func didTapMenu(){
        present(menu!, animated: true)
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController")
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true, completion: nil)
        NotificationCenter.default.post(name: Notification.Name("dailyHoroscope"), object: nil, userInfo:["info": pic[indexPath.row]])
        print("tap")
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pic.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(indexPath.row)
        let cell = dailyCollectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        cell.isHidden = false
        cell.starImage.image = UIImage(named:pic[indexPath.row])
        cell.label.text = pic[indexPath.row]
        cell.label.textColor = .white
        cell.backgroundColor = UIColor.clear
        cell.smallView.backgroundColor = UIColor.clear
        collectionView.backgroundColor = UIColor.clear
        print("cell")
        return cell
    }
    
    
}
extension ViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:(collectionView.frame.width) / 3.7, height: (collectionView.frame.height) / 4.3)
    }
}
extension UIButton {
    
    func setDynamicFontSize() {
        NotificationCenter.default.addObserver(self, selector: #selector(setButtonDynamicFontSize),
                                               name: UIContentSizeCategory.didChangeNotification,
                                               object: nil)
    }
    
    @objc func setButtonDynamicFontSize() {
        Common.setButtonTextSizeDynamic(button: self, textStyle: .callout)
    }
    
}
