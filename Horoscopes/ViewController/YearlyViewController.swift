//
//  ViewController.swift
//  Horoscopes
//
//  Created by Nguyen Duc Minh on 1/13/21.
//

import UIKit
import SideMenu

class YearlyViewController: UIViewController {
    var date = String()
    
    
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var doneDatePickerBtn: UIButton!
    
    @IBOutlet weak var datePickerView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var screenName: UILabel!
    
    
    @IBOutlet weak var whatIsMySign: UIImageView!
    @IBOutlet weak var surfaceWhatIsMySIgn: UIImageView!
    
    @IBOutlet weak var buttonBackground: UIImageView!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var whatIsMySignButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    var animal = ["Rat", "Ox" , "Tiger", "Rabbit", "Dragon", "Snake", "Horse", "Ram", "Monkey", "Rooster", "Dog", "Pig"]
    
    
    
    @IBAction func doneDatePickBtn(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController")
        
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true, completion: nil)
        
        NotificationCenter.default.post(name: Notification.Name("dateYearlyChinese"), object: nil, userInfo:["info": date])
        secondView.layer.isHidden=true
        
    }
    @IBOutlet weak var collectionView: UICollectionView!
    var menu:SideMenuNavigationController?
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBAction func rightButton(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ViewControllerDruidHoroscope")
        
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true, completion: nil)
        
        
    }
    
    @IBAction func donePickDateBtn(_ sender: Any) {
    }
    @IBAction func leftButton(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ViewControllerCompability")
        
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
        screenName.text = "Yearly Chinese"
        screenName.textColor = .white
        
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
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background5")!
            )}
        else{
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundPhone5")!)
        }
        
        
        
        
    }
    @IBAction func didTapMenu(){
        present(menu!, animated: true)
    }
    
}

extension YearlyViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController")
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        print(indexPath.row)
        NotificationCenter.default.post(name: Notification.Name("YearlyChinese"), object: nil, userInfo:["info": animal[indexPath.row]])
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return animal.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        cell.starImage.image = UIImage(named:animal[indexPath.row])
        
        
        cell.backgroundColor = UIColor.clear
        cell.backgroundView?.backgroundColor?.withAlphaComponent(0.1)
        collectionView.backgroundColor = UIColor.clear
        cell.label.text = animal[indexPath.row]
        cell.label.textColor = .white
        
        cell.smallView.backgroundColor = UIColor.clear
        return cell
    }
    
    
}
extension YearlyViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:(collectionView.frame.width) / 3.7, height: (collectionView.frame.height) / 4.3)
    }
    
}

