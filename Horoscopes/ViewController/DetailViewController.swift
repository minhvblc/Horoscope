//
//  DetailViewController.swift
//  Horoscopes
//
//  Created by Nguyen Duc Minh on 1/14/21.
//

import UIKit
import SWXMLHash
import SwiftyXMLParser
import Alamofire

class DetailViewController: UIViewController, XMLParserDelegate {
    
    var keyDailyZodiac = ["3c59dc048e8850243be8079a5c74d079", "b6d767d2f8ed5d21a44b0e5886680cb9", "37693cfc748049e45d87b8c7d8b9aacd","1ff1de774005f8da13f42943881c655f", "8e296a067a37563370ded05f5a3bf3ec", "4e732ced3463d06de0ca9a15b6153677", "02e74f10e0327ad868d138f2b4fdd6f0", "33e75ff09dd601bbe69f351039152189", "6ea9ab1baa0efb9e19094440c317e21b", "6f3ef77ac0e3619e98159e9b6febf557", "eb163727917cbba1eea208541a643e74", "1534b76d325a8f591b52d302e7181331"]
    var keyChinesne = ["7f39f8317fbdb1988ef4c628eba02591",
                       "44f683a84163b3523afe57c2e008bc8c",
                       "03afdbd66e7929b125f8597834fa83a4",
                       "ea5d2f1c4608232e07d3aa3d998e5135",
                       "fc490ca45c00b1249bbe3554a4fdf6fb",
                       "3295c76acbf4caaed33c36b1b5fc2cb1",
                       "735b90b4568125ed6c3f678819b6e058",
                       "a3f390d88e4c41f2747bfa2f1b5f87db",
                       "14bfa6bb14875e45bba028a21ed38046",
                       "00ac8ed3b4327bdd4ebbebcb2ba10a00",
                       "8ebda540cbcc4d7336496819a46a1b68",
                       "f76a89f0cb91bc419542ce9fa43902dc"]
    
    var pic = ["aries", "taurus", "gemini", "cancer", "leo", "virgo", "libra", "scorpio","sagittarius", "capricorn", "aquarius", "pisces"]
    var animal = ["Rat", "Ox" , "Tiger", "Rabbit", "Dragon", "Snake", "Horse", "Ram", "Monkey", "Rooster", "Dog", "Pig"]
    var name:String = ""
    func getChineseZodiac(_ date:Date) ->String{
        
        let calendar = Calendar.current
        let y = calendar.component(.year, from: date)
        print(y)
        switch (y%12) {
        case 0:
            return animal[3]
        case 1:
            return animal[4]
        case 2:
            return animal[5]
        case 3:
            return animal[6]
        case 4:
            return animal[7]
        case 5:
            return animal[8]
        case 6:
            return animal[9]
        case 7:
            return animal[10]
        case 8:
            return animal[11]
        case 9:
            return animal[0]
        case 10:
            return animal[1]
        case 11:
            return animal[2]
            
        default:
            return ""
        }
    }
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
    @objc func onNotificationDatePickZodiacCharacteristic(_ notification:Notification){
        let text = notification.userInfo
        
        screenName.text = (text!["info"] as! String)
        var datePick = text!["info"] as! String
        
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
        
        let name=getZodiacSign(realDate!)
        let name2 = name.lowercased()
        
        screenName.text = name
        zodiacImage.image = UIImage(named: name)
        if let path = Bundle.main.path(forResource: "assets/zodiac/characteristics/\(name2)", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let description = jsonResult["description"] as? String {
                    print(description)
                    zodiacDescriptionTextView.text = description
                }
            } catch {
                print(error)
            }
        }
        
        if let path = Bundle.main.path(forResource: "assets/zodiac/signs/\(name2)", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let sign = jsonResult["sign"] as? String,let alias = jsonResult["alias"] as? String,let startDate = jsonResult["startDate"] as? String,let endDate = jsonResult["endDate"] {
                    print(description)
                    zodiacDetailTextView.text = "\(sign)\nAlias: \(alias)\n\(startDate) - \(endDate)"
                }
            } catch {
                print(error)
            }
        }
        
    }
    @objc func onNotificationDailyHoroscopeDatePick(_ notification:Notification){
        let text = notification.userInfo
        print(text!["info"])
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
        formatter.calendar = .init(identifier: .chinese)
        
        let name=getZodiacSign(realDate!)
        let name2 = name.lowercased()
        screenName.text = name
        zodiacImage.image = UIImage(named: name)
        let index = pic.firstIndex(of: name2)
        AF.request("https://medo.mobi/horoscope_xml.php?p=2&s=\(index!+1)&lang=en&key=\(keyDailyZodiac[index!])", method: .get).response { response in
            if let data = response.data {
                print(data)
                let xml = XML.parse(data)
                print("aaaa")
                let fortime = xml.horoscope.item.fortime.text
                self.zodiacDetailTextView.text = String(fortime!)
                // outputs the top title of iTunes app raning.
                print(fortime!)
                if let text = xml["horoscope", "item", "description"].text {
                    self.zodiacDescriptionTextView.text = text
                }
            }
        }
        
        
        
    }
    @objc func onNotification(_ notification:Notification)
    {
        
        let text = notification.userInfo
        
        screenName.text = (text!["info"] as! String)
        name = text!["info"] as! String
        let name2 = name.lowercased()
        
        zodiacImage.image = UIImage(named: name)
        print(name2)
        if let path = Bundle.main.path(forResource: "assets/zodiac/characteristics/\(name2)", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let description = jsonResult["description"] as? String {
                    print(description)
                    zodiacDescriptionTextView.text = description
                }
            } catch {
                print(error)
            }
        }
        
        if let path = Bundle.main.path(forResource: "assets/zodiac/signs/\(name2)", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let sign = jsonResult["sign"] as? String,let alias = jsonResult["alias"] as? String,let startDate = jsonResult["startDate"] as? String,let endDate = jsonResult["endDate"] {
                    print(description)
                    zodiacDetailTextView.text = "\(sign)\nAlias: \(alias)\n\(startDate) - \(endDate)"
                }
            } catch {
                print(error)
            }
        }
        
        
        
    }
    @objc func onNotificationYearlyZodiac(_ notification:Notification)
    {
        let text = notification.userInfo
        
        screenName.text = (text!["info"] as! String)
        name = text!["info"] as! String
        var name2 = name.lowercased()
        zodiacImage.image = UIImage(named: name)
        print(name2)
        
        if let path = Bundle.main.path(forResource: "assets/zodiac/signs/\(name2)", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let sign = jsonResult["sign"] as? String,let alias = jsonResult["alias"] as? String,let startDate = jsonResult["startDate"] as? String,let endDate = jsonResult["endDate"] {
                    print(description)
                    zodiacDetailTextView.text = "\(sign)\nAlias: \(alias)\n\(startDate) - \(endDate)"
                }
            } catch {
                print(error)
            }
        }
        print("test parse data")
        if let path = Bundle.main.path(forResource: "assets/yearly/zodiac_2020", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String: Any]
                
                print(name2)
                if let item1 = jsonResult?[name2]  as? [String: Any]{
                    if let description = item1["content"] as? String{
                        print(description)
                        zodiacDescriptionTextView.text = description
                    }
                    
                }
                
            } catch {
                print("ERRRRRRRRRRR")
            }
        }
        
        
    }
    @objc func onNotificationDatePickYearlyZodiac(_ notification:Notification)
    {
        let text = notification.userInfo
        
        screenName.text = (text!["info"] as! String)
        var datePick = text!["info"] as! String
        
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
        
        var name=getZodiacSign(realDate!)
        var name2 = name.lowercased()
        
        screenName.text = name
        zodiacImage.image = UIImage(named: name)
        print(name2)
        
        if let path = Bundle.main.path(forResource: "assets/zodiac/signs/\(name2)", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let sign = jsonResult["sign"] as? String,let alias = jsonResult["alias"] as? String,let startDate = jsonResult["startDate"] as? String,let endDate = jsonResult["endDate"] {
                    print(description)
                    zodiacDetailTextView.text = "\(sign)\nAlias: \(alias)\n\(startDate) - \(endDate)"
                }
            } catch {
                print(error)
            }
        }
        print("test parse data")
        if let path = Bundle.main.path(forResource: "assets/yearly/zodiac_2020", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String: Any]
                
                print(name2)
                if let item1 = jsonResult?[name2]  as? [String: Any]{
                    if let description = item1["content"] as? String{
                        print(description)
                        zodiacDescriptionTextView.text = description
                    }
                    
                }
                
            } catch {
                print("ERRRRRRRRRRR")
            }
        }
        
        
    }
    @objc func onNotificationDatePickYearlyChinese(_ notification:Notification)
    {
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
        formatter.calendar = .init(identifier: .chinese)
        //        let stringChinese = realDate
        let formatterChinese = DateFormatter()
        formatterChinese.dateFormat = "MM/dd/YY"
        formatterChinese.dateStyle = .short
        formatterChinese.timeStyle = .none
        let chineseDate = formatterChinese.date(from: formatter.string(from: realDate!))
        print("---\(chineseDate)")
        let name=getChineseZodiac(chineseDate!)
        let name2 = name.lowercased()
        
        screenName.text = name
        zodiacImage.image = UIImage(named: name)
        
        print("---2\(name2)")
        print("---1\(name)")
        
        
        if let path = Bundle.main.path(forResource: "assets/chinese/signs/\(name2)", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let name = jsonResult["name"] as? String,let alternative = jsonResult["alternative"] as? String,let fixedelement = jsonResult["fixedelement"] as? String {
                    print(description)
                    zodiacDetailTextView.text = "\(name)\nAlternative: \(alternative)\n\(fixedelement)"
                }
            } catch {
                print(error)
            }
        }
        if let path = Bundle.main.path(forResource: "assets/yearly/chinese_2020", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String: Any]
                
                print(name2)
                if let item1 = jsonResult?[name2]  as? [String: Any]{
                    if let description = item1["content"] as? String{
                        print(description)
                        zodiacDescriptionTextView.text = description
                    }
                    
                }
                
            } catch {
                print("ERRRRRRRRRRR")
            }
        }
    }
    
    @objc func onNotificationYearlyChinese(_ notification:Notification)
    {
        let text = notification.userInfo
        
        screenName.text = (text!["info"] as! String)
        name = text!["info"] as! String
        var name2 = name.lowercased()
        zodiacImage.image = UIImage(named: name)
        print(name)
        print("name2\(name2)")
        if let path = Bundle.main.path(forResource: "assets/chinese/signs/\(name2)", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let name = jsonResult["name"] as? String,let alternative = jsonResult["alternative"] as? String,let fixedelement = jsonResult["fixedelement"] as? String {
                    print(description)
                    zodiacDetailTextView.text = "\(name)\nAlternative: \(alternative)\nFixedelement: \(fixedelement)"
                }
            } catch {
                print(error)
            }
        }
        if let path = Bundle.main.path(forResource: "assets/yearly/chinese_2020", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String: Any]
                
                print(name2)
                if let item1 = jsonResult?[name2]  as? [String: Any]{
                    if let description = item1["content"] as? String{
                        print(description)
                        zodiacDescriptionTextView.text = description
                    }
                    
                }
                
            } catch {
                print("ERRRRRRRRRRR")
            }
        }
        
    }
    @objc func onNotificationDailyHoroscope(_ notification:Notification)
    {
        let text = notification.userInfo
        
        screenName.text = (text!["info"] as! String)
        name = text!["info"] as! String
        var name2 = name.lowercased()
        zodiacImage.image = UIImage(named: name)
        print(name)
        
        let index = pic.index(of: name2)
        AF.request("https://medo.mobi/horoscope_xml.php?p=2&s=\(index!+1)&lang=en&key=\(keyDailyZodiac[index!])", method: .get).response { response in
            if let data = response.data {
                print(data)
                let xml = XML.parse(data)
                print("aaaa")
                var fortime = xml.horoscope.item.fortime.text
                self.zodiacDetailTextView.text = String(fortime!)
                // outputs the top title of iTunes app raning.
                print(fortime)
                if let text = xml["horoscope", "item", "description"].text {
                    self.zodiacDescriptionTextView.text = text
                }
            }
        }
        
    }
    
    @IBOutlet weak var zodiacView: UIView!
    @IBOutlet weak var zodiacImage: UIImageView!
    @IBOutlet weak var zodiacDetailTextView: UITextView!
    @IBOutlet weak var leftbutton: UIButton!
    @IBOutlet weak var screenName: UILabel!
    
    @IBOutlet weak var zodiacDescriptionTextView: UITextView!
    override func viewDidLoad() {
        NotificationCenter.default.addObserver(self, selector: #selector(onNotification(_:)), name: Notification.Name("zodiacCharacteristic"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onNotificationYearlyChinese(_:)), name: Notification.Name("YearlyChinese"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onNotificationYearlyZodiac(_:)), name: Notification.Name("YearlyZodiac"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onNotificationDatePickZodiacCharacteristic(_:)), name: Notification.Name("dateZodiacCharacteristic"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onNotificationDatePickYearlyZodiac(_:)), name: Notification.Name("dateYearlyZodiac"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onNotificationDatePickYearlyChinese(_:)), name: Notification.Name("dateYearlyChinese"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onNotificationDailyHoroscope(_:)), name: Notification.Name("dailyHoroscope"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onNotificationDailyHoroscopeDatePick(_:)), name: Notification.Name("dateDaily"), object: nil)
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "behindText")!)
        zodiacDetailTextView.isEditable = false
        screenName.textColor = .white
        zodiacView.layer.cornerRadius = 20.0
        screenName.textColor = .white
        zodiacDescriptionTextView.isEditable = false
    }
    
    @IBAction func leftButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        zodiacDetailTextView.text = nil
        
        
    }
}
