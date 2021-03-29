//
//  ZodiacCharacteristicsViewController.swift
//  Horoscopes
//
//  Created by Nguyen Duc Minh on 1/15/21.
//

import UIKit
import SideMenu
class YearlyZodiacViewController: UIViewController {
    
    var pic = ["Aries", "Taurus", "Gemini", "Cancer", "Leo", "Virgo", "Libra", "Scorpio","Sagittarius", "Capricorn", "Aquarius", "Pisces"]
    
    var date = String()
    
    @IBOutlet weak var leftButton: UIButton!
    
    @IBOutlet weak var buttonBackground: UIImageView!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var whatIsMySignButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var secondView: UIView!
    
    @IBOutlet weak var datePickerView: UIView!
    @IBOutlet weak var donePickDateBtn: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var screenName: UILabel!
    var menu:SideMenuNavigationController?
    
    @IBAction func whaIsMySignBtn(_ sender: Any) {
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
    @IBAction func doneDatePickBtn(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController")
        
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true, completion: nil)
        secondView.layer.isHidden=true
        
        NotificationCenter.default.post(name: Notification.Name("dateYearlyZodiac"), object: nil, userInfo:["info": date])
        print(date)
    }
    @IBAction func previousButton(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ZodiacCharacteristics")
        
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true, completion: nil)
        
        print("previous")
    }
    @IBAction func nextButton(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ViewControllerCompability")
        
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true, completion: nil)
        print("next")
        
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
        screenName.textColor = .white
        screenName.text = "Yearly Zodiac"
        menu = SideMenuNavigationController(rootViewController:MenuList())
        menu?.setNavigationBarHidden(true, animated: false)
        
        menu?.leftSide = true
        menu?.title = "Setting"
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        SideMenuManager.default.leftMenuNavigationController?.statusBarEndAlpha = 0
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 200 , height: 200)
        
        let name = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView.register(name, forCellWithReuseIdentifier: "CollectionViewCell")
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background3")!
            )}
        else{
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundPhone3")!)
        }
        
        
        
        
    }
    @IBAction func didTapMenu(){
        present(menu!, animated: true)
    }
    
    
    
}
extension YearlyZodiacViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController")
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        print(indexPath.row)
        NotificationCenter.default.post(name: Notification.Name("YearlyZodiac"), object: nil, userInfo:["info": pic[indexPath.row]])
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pic.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        cell.starImage.image = UIImage(named:pic[indexPath.row])
        
        cell.smallView.backgroundColor = UIColor.clear
        cell.backgroundColor = UIColor.clear
        cell.backgroundView?.backgroundColor?.withAlphaComponent(0.1)
        collectionView.backgroundColor = UIColor.clear
        cell.label.text = pic[indexPath.row]
        cell.label.textColor = .white
        return cell
    }
    
    
}
extension YearlyZodiacViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:(collectionView.frame.width) / 3.7, height: (collectionView.frame.height) / 4.3)
        
    }
    
}










