//
//  CameraViewController.swift
//  Horoscopes
//
//  Created by Nguyễn Minh on 1/27/21.
//

import UIKit
import AVFoundation


let imageDataDict:[String: UIImage] = ["image": image]
var image = UIImage()
class CameraViewController: UIViewController,AVCapturePhotoCaptureDelegate {
    var screenName = ""
    var captureSession: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    let imgPickerView = UIImagePickerController()
    let backButton = UIButton()
    let cameraView = UIView()
    let bottomView = UIView()
    let capture = UIButton()
    let libraryButton = UIButton()
    let label = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print(view.frame.size.width)
        NotificationCenter.default.addObserver(self, selector: #selector(onNotification(_:)), name: Notification.Name("typeScreen"), object: nil)
        
        addSubviews()
        addTarget()
    }
    @objc func onNotification(_ notification:Notification)
    {
        let text = notification.userInfo
        screenName = (text!["info"] as? String)!
        
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //Layout:
        let scale = view.frame.size.width/428
        print(scale)
        cameraView.frame = CGRect(x: 0.0, y: 0.0, width: view.frame.size.width, height: view.frame.size.height)
        cameraView.backgroundColor = .clear
        bottomView.frame = CGRect(x:0, y:view.frame.size.height*3/4, width: view.frame.size.width, height: view.frame.size.height/4)
        bottomView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        libraryButton.backgroundColor = .white
        capture.backgroundColor = .clear
        libraryButton.backgroundColor = .clear
        libraryButton.frame = CGRect(x:(bottomView.frame.size.width/2-120*scale), y:(bottomView.frame.size.height/2-25*scale), width: 50*scale, height: 50*scale)
        capture.frame = CGRect(x:bottomView.frame.size.width/2-40*scale, y:bottomView.frame.size.height/2-40*scale ,width: 80*scale, height: 80*scale)
        backButton.frame = CGRect(x:30*scale, y:50*scale ,width: 40*scale, height: 40*scale)
        backButton.setImage(UIImage(named: "Group 14"), for: .normal)
        
        label.frame =  CGRect(x:view.frame.size.width/2-60*scale, y:50*scale ,width: 120*scale, height: 40*scale)
        label.text = "Analyst"
        label.textAlignment = .center
        label.font = label.font.withSize(23)
        libraryButton.setImage(UIImage(named: "libraryImage"), for: .normal)
        capture.setImage(UIImage(named: "capture"), for: .normal)
        label.textColor = .white
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .medium
        
        guard let backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: AVCaptureDevice.Position.front)
        else {
            print("Unable to access back camera!")
            return
        }
        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
            //Step 9
            stillImageOutput = AVCapturePhotoOutput()
            if captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput) {
                captureSession.addInput(input)
                captureSession.addOutput(stillImageOutput)
                setupLivePreview()
            }
        }
        catch let error  {
            print("Error Unable to initialize back camera:  \(error.localizedDescription)")
        }
        
        
    }
    @objc private func back(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "startViewController")
        
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true, completion: nil)
    }
    func setupLivePreview() {
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        videoPreviewLayer.videoGravity = .resizeAspect
        videoPreviewLayer.connection?.videoOrientation = .portrait
        cameraView.layer.addSublayer(videoPreviewLayer)
        addSubviews()
        DispatchQueue.global(qos: .userInitiated).async { //[weak self] in
            self.captureSession.startRunning()
            //Step 13
            DispatchQueue.main.async {
                self.videoPreviewLayer.frame = self.cameraView.bounds
            }
        }
        
    }
    private func addSubviews() {
        view.addSubview(cameraView)
        cameraView.addSubview(bottomView)
        bottomView.addSubview(capture)
        bottomView.addSubview(libraryButton)
        cameraView.addSubview(backButton)
        cameraView.addSubview(label)
    }
    private func addTarget(){
        capture.addTarget(self, action: #selector(didTakePhoto), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        libraryButton.addTarget(self, action: #selector(didTapLibrary), for: .touchUpInside)
    }
    
    @objc private func didTakePhoto(){
        print("take photo")
        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        stillImageOutput.capturePhoto(with: settings, delegate: self)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "typeScreen"), object: nil, userInfo:["info": screenName])
        
        
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        print("get image")
        guard let imageData = photo.fileDataRepresentation()
        else {
            print("failed")
            return
            
        }
        image = UIImage(data: imageData)!
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "analysViewController") as! analysViewController
        vc.screenName = screenName
        vc.modalPresentationStyle = .fullScreen
        vc.choosePic = image
        present(vc, animated: true, completion: nil)
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.captureSession.stopRunning()
    }
    @objc func didTapLibrary(){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        
    }
    
}
extension CameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let choosePic = info[UIImagePickerController.InfoKey(rawValue:"UIImagePickerControllerEditedImage")] as? UIImage{
            image = choosePic
            picker.dismiss(animated: true, completion: nil)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "analysViewController") as! analysViewController
            vc.choosePic = image
            vc.screenName = screenName
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "image"), object: nil, userInfo:imageDataDict)
            
            
        }
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

