//
//  analysViewController.swift
//  Horoscopes
//
//  Created by Nguyễn Minh on 1/27/21.
//

import UIKit

class analysViewController: UIViewController {
    var screenName = ""
    let backButton = UIButton()
    let label = UILabel()
    let scanText = UILabel()
    let analyzingLabel = UILabel()
    let bottomView = UIView()
    let scan = UIButton()
    var choosePic = UIImage()
    let faceImageView:UIImageView = UIImageView()
    let analyzeImageView:UIImageView = UIImageView()
    let analyzeImage = UIImage(named: "analyst")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTarget()
        addSubviews()
        
        analyzeImageView.image = analyzeImage
        faceImageView.image = choosePic
        
        NotificationCenter.default.addObserver(self, selector: #selector(onImageNotification(_:)), name: Notification.Name(rawValue:"image"), object: nil)
        
    }
    private func addTarget(){
        scan.addTarget(self, action: #selector(scanPic), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
    }
    @objc private func back(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "startViewController")
        
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true, completion: nil)
    }
    private func addSubviews() {
        view.addSubview(faceImageView)
        
        view.addSubview(backButton)
        view.addSubview(label)
        view.addSubview(scan)
        view.addSubview(bottomView)
        view.addSubview(scanText)
        bottomView.addSubview(analyzeImageView)
        bottomView.addSubview(analyzingLabel)
        
    }
    
    @objc func onImageNotification(_ notification:Notification)
    {
        print("aaaaaa")
        if let dict = notification.userInfo as NSDictionary? {
            if (dict["image"] as? UIImage) != nil{
                faceImageView.image = dict["image"] as? UIImage
            }
        }
        
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.backgroundColor = #colorLiteral(red: 0, green: 0.05098039216, blue: 0.1921568627, alpha: 1)
        let scale = view.frame.size.width/428
        backButton.frame = CGRect(x:30*scale, y:50*scale ,width: 40*scale, height: 40*scale)
        backButton.setImage(UIImage(named: "Group 14"), for: .normal)
        faceImageView.frame = CGRect(x: 100*scale, y: 150*scale , width: view.frame.size.width-200*scale, height: view.frame.size.height/2)
        faceImageView.backgroundColor = .blue
        bottomView.frame = CGRect(x:0, y:view.frame.size.height*3/4, width: view.frame.size.width, height: view.frame.size.height/4)
        
        bottomView.backgroundColor = #colorLiteral(red: 0, green: 0.07139267772, blue: 0.2515854239, alpha: 1)
        bottomView.isHidden = true
        label.frame =  CGRect(x:view.frame.size.width/2-60*scale, y:50*scale ,width: 120*scale, height: 40*scale)
        
        label.textAlignment = .center
        scanText.frame =  CGRect(x: 50*scale, y: 150*scale + view.frame.size.height/2  ,width: view.frame.size.width-100*scale, height: 40*scale)
        
        scan.frame = CGRect(x: 50*scale, y: view.frame.size.height/10*9  , width: view.frame.size.width-100*scale, height: view.frame.size.height/10)
        scan.setImage(UIImage(named: "scan"), for: .normal)
        bottomView.layer.cornerRadius = 20
        scanText.textAlignment = .center
        analyzeImageView.frame = CGRect(x:0, y: 40*scale, width: bottomView.frame.size.width, height:  bottomView.frame.size.height-100*scale)
        label.textColor = .white
        scanText.textColor = .white
        analyzeImageView.isHidden = false
        faceImageView.layer.cornerRadius = 20
        analyzingLabel.frame =  CGRect(x: 50*scale, y: 5*scale  ,width: bottomView.frame.size.width - 100*scale, height: 40*scale)
        
        faceImageView.clipsToBounds = true
        analyzingLabel.textAlignment = .center
        analyzingLabel.textColor = .white
        analyzingLabel.isHidden = true
        analyzeImageView.isHidden = true
        label.text = "Face analyst"
        label.font = label.font.withSize(25)
        scanText.text = "Scan Your face"
        analyzingLabel.text = "Analyzing your face..."
    }
    
    
    @objc private func scanPic(){
        bottomView.isHidden = false
        scan.isHidden = true
        scanText.isHidden = true
        analyzingLabel.isHidden = false
        analyzeImageView.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ShowPreditionViewController") as! ShowPreditionViewController
            vc.choosePic = self.choosePic
            vc.modalPresentationStyle = .fullScreen
            
            self.present(vc, animated: true, completion: nil)
        }
    }
}
