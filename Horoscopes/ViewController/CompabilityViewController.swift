//
//  CompabilityViewController.swift
//  Horoscopes
//
//  Created by Nguyen Duc Minh on 1/14/21.
//

import UIKit

class CompabilityViewController: UIViewController {
    var pic = ["aries", "taurus", "gemini", "cancer", "leo", "virgo", "libra", "scorpio","sagittarius", "capricorn", "aquarius", "pisces"]
    func getZodiacSign(_ date:Date) -> String{
        
        let calendar = Calendar.current
        let d = calendar.component(.day, from: date)
        let m = calendar.component(.month, from: date)
        
        switch (d,m) {
        case (21...31,1),(1...19,2):
            return "Aquarius"
        case (20...29,2),(1...20,3):
            return "Pisces"
        case (21...31,3),(1...20,4):
            return "Aries"
        case (21...30,4),(1...21,5):
            return "Taurus"
        case (22...31,5),(1...21,6):
            return "Gemini"
        case (22...30,6),(1...22,7):
            return "Cancer"
        case (23...31,7),(1...22,8):
            return "Leo"
        case (23...31,8),(1...23,9):
            return "Virgo"
        case (24...30,9),(1...23,10):
            return "Libra"
        case (24...31,10),(1...22,11):
            return "Scorpio"
        case (23...30,11),(1...21,12):
            return "Sagittarius"
        default:
            return "Capricorn"
        }
        
    }
    
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var CompabilityView: UIView!
    
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var leftImage: UIImageView!
    @IBOutlet weak var rightImage: UIImageView!
    @IBOutlet weak var leftbutton: UIButton!
    @objc func onNotification(_ notification:Notification)
    {
        let text = notification.userInfo
        
        let date1 = text!["date1"] as! String
        let date2 = text!["date2"] as! String
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/YY"
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        let now = Date()
        let stringNow = formatter.string(from: now)
        
        let datePick1 = (formatter.date(from: date1) ?? formatter.date(from: stringNow))!
        let datePick2 = (formatter.date(from: date2) ?? formatter.date(from: stringNow))!
        let name1 = getZodiacSign(datePick1)
        print("----\(name1)")
        let name2 = getZodiacSign(datePick2)
        print("----\(name2)")
        leftImage.image = UIImage(named: name1)
        rightImage.image = UIImage(named: name2)
        
        if let path = Bundle.main.path(forResource: "assets/compatibility/\(name1.lowercased())/\(name2.lowercased())", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let compatibility = jsonResult["compatibility"] as? String {
                    
                    descriptionTextView.text = compatibility
                }
            } catch {
                print(error)
            }
        }
        
    }
    
    
    override func viewDidLoad() {
        descriptionTextView.isEditable = false
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "behindText")!)
        screenName.text = "Compability"
        screenName.textColor = .white
        CompabilityView.layer.cornerRadius = 30
        NotificationCenter.default.addObserver(self, selector: #selector(onNotification(_:)), name: Notification.Name("dateCompability"), object: nil)
    }
    @IBAction func leftButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
