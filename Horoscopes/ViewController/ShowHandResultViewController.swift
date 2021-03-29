//
//  ShowHandResultViewController.swift
//  Horoscopes
//
//  Created by Nguyễn Minh on 12/02/2021.
//

import UIKit

class ShowHandResultViewController: UIViewController {
    var randomNum = Int.random(in: 1...30)
    var capturePic = UIImage()
    var result = String()
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var textResult: UITextView!
    @IBOutlet weak var image: UIImageView!
    let resultTextView = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.textColor = .white
        label.textAlignment = .center
        image.image = capturePic
        image.layer.cornerRadius = 20
        textResult.layer.cornerRadius = 20
        textResult.isEditable = false
        textResult.text = openDatabase(randomNum)
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Home")!)
        
    }
    
    @IBAction func back(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "startViewController")
        
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true, completion: nil)
    }
    
    
}










