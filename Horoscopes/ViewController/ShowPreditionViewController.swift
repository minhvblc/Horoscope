//
//  ShowPreditionViewController.swift
//  Horoscopes
//
//  Created by Nguyễn Minh on 1/28/21.
//

import UIKit
import Vision
import CoreML
class ShowPreditionViewController: UIViewController {
    let label = UILabel()
    let backButton = UIButton()
    let resultImageView = UIImageView()
    let result = UILabel()
    let faceImageView:UIImageView = UIImageView()
    var choosePic = UIImage()
    private var faceRect = CGRect.zero
    override func viewDidLoad() {
        super.viewDidLoad()
        addTarget()
        addSubviews()
        faceImageView.image = choosePic
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Home")!)
        let photoSensor = ChildPhotoSensor(image: choosePic)
        print(photoSensor.age)
        result.text = "\(String(describing: photoSensor.age)) years old"
        // Do any additional setup after loading the view.
    }
    
    private func addTarget(){
        
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
    }
    private func addSubviews() {
        view.addSubview(faceImageView)
        view.addSubview(resultImageView)
        view.addSubview(backButton)
        view.addSubview(label)
        resultImageView.addSubview(result)
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let scale = view.frame.size.width/428
        backButton.frame = CGRect(x:30*scale, y:20*scale ,width: 40*scale, height: 40*scale)
        backButton.setImage(UIImage(named: "Group 14"), for: .normal)
        faceImageView.frame = CGRect(x: 50*scale, y: 100*scale , width: view.frame.size.width-100*scale, height: view.frame.size.height/4*3)
        resultImageView.frame =  CGRect(x:50*scale, y:150*scale + view.frame.size.height/2 ,width: 140*scale, height: 50*scale)
        result.frame = CGRect(x:5*scale, y: 0  , width: resultImageView.frame.size.width-10*scale,height: resultImageView.frame.size.height)
        resultImageView.image = #imageLiteral(resourceName: "Rectangle 6")
        resultImageView.backgroundColor = .clear
        faceImageView.layer.cornerRadius = 20
        faceImageView.clipsToBounds = true
        label.frame =  CGRect(x:view.frame.size.width/2-60*scale, y:20*scale ,width: 120*scale, height: 40*scale)
        label.text = "Result"
        label.textColor = .white
        label.font = label.font.withSize(25)
        result.textAlignment = .center
        result.textColor = .white
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
    }
    @objc private func back(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "startViewController")
        
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true, completion: nil)
    }
    func detectFaces(within uiImage: UIImage) {
        guard let cgImage = uiImage.cgImage else {
            fatalError("Invalid image")
        }
        
        let request = VNDetectFaceRectanglesRequest { [unowned self] request, err in
            guard err == nil else {
                print(err!)
                return
            }
            
            guard let results = request.results else {
                return
            }
            
            for case let result as VNFaceObservation in results {
                self.choosePic = self.imageWith(size: uiImage.size, style: { ctx in
                    self.faceRect = self.rect(fromRelative: result.boundingBox, size: uiImage.size)
                    
                    ctx.setStrokeColor(UIColor.yellow.cgColor)
                    ctx.stroke(self.faceRect, width: 3.0)
                })!
            }
        }
        
        request.preferBackgroundProcessing = true
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).async {
            let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            try? handler.perform([request])
        }
    }
    private func imageWith(size: CGSize, style: (CGContext) -> Void) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        
        guard let ctx = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        self.choosePic.draw(at: .zero)
        style(ctx)
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    private func rect(fromRelative boundingBox: CGRect, size: CGSize) -> CGRect {
        var rect = CGRect(
            x: boundingBox.origin.x * size.width,
            y: size.height - boundingBox.origin.y * size.height,
            width: boundingBox.width * size.width,
            height: boundingBox.height * size.height
        )
        
        rect.origin.y -= rect.height
        
        return rect
    }
    
    
}
