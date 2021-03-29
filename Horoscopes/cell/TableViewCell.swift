//
//  TableViewCell.swift
//  Horoscopes
//
//  Created by Nguyen Duc Minh on 1/13/21.
//
import UserNotifications
import UIKit
import StoreKit

class TableViewCell: UITableViewCell {
    var index = Int()
    
    @IBOutlet weak var label: UILabel!

   
    @IBOutlet weak var buttonImage: UIImageView!
    @IBAction func switchOnePressed(_ sender: UISwitch) {
        if `switch`.isOn{
           
            let selectedDate = Date().addingTimeInterval(5)
           
            switchOn = true
            if #available(iOS 13.0, *) {
                let delegate = UIApplication.shared.delegate as? AppDelegate
                delegate?.scheduleNotification(at: selectedDate)
            } else {
                // Fallback on earlier versions
                
                var dateComponents = DateComponents()
                dateComponents.hour = 9
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

                
                let content = UNMutableNotificationContent()
                content.title = "Daily Horoscope"
                content.body = "Let's check your today horoscope"
                content.sound = UNNotificationSound.default
                
                let request = UNNotificationRequest(identifier: "textNotification", content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                UNUserNotificationCenter.current().add(request) {(error) in
                    if let error = error {
                        print("Uh oh! We had an error: \(error)")
                    }
                    print(request.content.title)
                }
            }
        }
        else{
          
            switchOn = false
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        }
        
        
    }
    @IBOutlet weak var `switch`: UISwitch!
    @IBOutlet weak var menuTextLabel: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.`switch`.isOn = switchOn
        // Initialization code
    }

    @IBOutlet weak var smallView: UIView!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}
