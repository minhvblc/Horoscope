//
//  DruidDetailViewController.swift
//  Horoscopes
//
//  Created by Nguyen Duc Minh on 1/14/21.
//

import UIKit

class DruidDetailViewController: UIViewController {
    func getDruidSign(_ date:Date) -> String{
        
        let calendar = Calendar.current
        let d = calendar.component(.day, from: date)
        let m = calendar.component(.month, from: date)
        
        switch (d,m) {
        case (22...31,12),(1,1),(25...30,6),(1...4,7):
            return "Apple"
        case (2...11,1),(5...14,7):
            return "Fir"
        case (12...24,1),(15...25,7):
            return "Elm"
        case (25...31,1),(1...3,2),(26...31,7),(1...4,8):
            return "Cypress"
        case (4...8,2),(5...13,8):
            return "Poplar"
        case (9...18,2),(14...23,8):
            return "Cedar"
        case (19...29,2),(24...31,8),(1...2,9):
            return "Pine"
        case (1...10,3),(3...12,9):
            return "Willow"
        case (11...20,3),(13...22,9):
            return "Lime"
        case (22...31,3),(24...30,9),(1...3,10):
            return "Nutwood"
        case (1...10,4),(4...13,10):
            return "Rowan"
        case (11...20,4),(14...23,10):
            return "Maple"
        case (21...30,4),(24...31,10), (1...2,11):
            return "Nut"
        case (1...14,5),(3...11,11):
            return "Jasmine"
        case (15...24,5),(12...21,11):
            return "Chestnut"
        case (25...31,5),(1...3,6),(22...30,11),(1,12):
            return "Ash"
        case (4...13,6),(2...11,12):
            return "Hornbeam"
        case (14...23,6),(12...20,12):
            return "Fig"
        case (21,3):
            return "Oak"
        case (24,6):
            return "Birch"
        case (23,9):
            return "Olive"
        case (21...22,12):
            return "Beech"
        default:
            return "No match"
        }
        
    }
    var name:String = ""
    
    @objc func onNotificationDatePick(_ notification:Notification){
        let text = notification.userInfo
        
        screenName.text = (text!["info"] as! String)
        let datePick = text!["info"] as! String
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/YY"
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        let now = Date()
        let stringNow = formatter.string(from: now)
        let date1 = (formatter.date(from: datePick) ?? formatter.date(from: stringNow))!
        
        var dateComponent = DateComponents()
        dateComponent.day = 1
        let realDate = Calendar.current.date(byAdding: dateComponent, to: date1)
        
        let name=getDruidSign(realDate!)
        let name2 = name.lowercased()
        
        screenName.text = name
        print(name2)
        if let path = Bundle.main.path(forResource: "assets/druid/\(name2)", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let description = jsonResult["description"] as? String {
                    print(description)
                    druidDetailTextView.text = description
                }
            } catch {
                print(error)
            }
        }
    }
    
    @objc func onNotification(_ notification:Notification)
    {
        
        let text = notification.userInfo
        
        screenName.text = (text!["info"] as! String)
        name = text!["info"] as! String 
        name = name.lowercased()
        if let path = Bundle.main.path(forResource: "assets/druid/\(name)", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let description = jsonResult["description"] as? String {
                    print(description)
                    druidDetailTextView.text = description
                }
            } catch {
                print(error)
            }
        }
        print(name)
        
    }
    
    
    @IBOutlet weak var druidDetailTextView: UITextView!
    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var screenName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(name)
        druidDetailTextView.isEditable = false
        NotificationCenter.default.addObserver(self, selector: #selector(onNotification(_:)), name: Notification.Name("druidName"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onNotificationDatePick(_:)), name: Notification.Name("dateDruid"), object: nil)
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "behindText")!)
        screenName.text = "Hello"
        screenName.textColor = .white
        druidDetailTextView.layer.cornerRadius = 20.0
        screenName.textColor = .white
    }
    
    
    @IBAction func leftButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ViewControllerDruidHoroscope")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    
}
