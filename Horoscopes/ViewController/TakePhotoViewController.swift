//
//  PalmScannerVC.swift

//

import UIKit
import AVFoundation
import Vision

class TakePhotoViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var label: UILabel!
    
    let cameraViewSession = AVCaptureSession()
    
    // creating a queue to process the video frames
    let frameQueue = DispatchQueue(label: "frameQueue")
    
    // preview layer to display the came input
    var previewDisplayLayer: AVCaptureVideoPreviewLayer!
    
    var visionRequests = [VNRequest]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let camera = AVCaptureDevice.default(for: .video) else {
            fatalError("No camera present or available")
        }
        
        cameraViewSession.sessionPreset = .photo// may need to adjust this a bit
        
        // show the preview layer in UI
        previewDisplayLayer = AVCaptureVideoPreviewLayer(session: cameraViewSession)
        cameraView.layer.addSublayer(previewDisplayLayer)
        
        // creating capture input and video output
        do {
            let cameraInput = try AVCaptureDeviceInput(device: camera)
            let videoOutput = AVCaptureVideoDataOutput()
            videoOutput.setSampleBufferDelegate(self, queue: frameQueue)
            videoOutput.alwaysDiscardsLateVideoFrames = true // discard late frames. Otherwise, we may have inconsistent frames
            videoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA]
            
            // connect the output and input
            cameraViewSession.addInput(cameraInput)
            cameraViewSession.addOutput(videoOutput)
            
            // ensure portrait mode
            let conn = videoOutput.connection(with: .video)
            conn?.videoOrientation = .portrait
            
            // initiate session
            cameraViewSession.startRunning()
            
        } catch _ {
            fatalError("Could not capture camera input")
        }
        
        guard let visionModel = try? VNCoreMLModel(for: hands_cnn().model) else {
            fatalError("Error while loading model")
        }
        
        let classifierRequest = VNCoreMLRequest(model: visionModel, completionHandler: processClassifications)
        classifierRequest.imageCropAndScaleOption = .centerCrop
        visionRequests = [classifierRequest]
    }
    
    func processClassifications(request: VNRequest, error: Error?) {
        if let theError = error {
            print("Error: \(theError.localizedDescription)")
            return
        }
        
        guard let observations = request.results else {
            print("No results")
            return
        }
        
        let classifications = observations[0...2] // get top 2 results
            .compactMap({ $0 as? VNClassificationObservation })
            .compactMap({ $0.confidence > 0.03 ? $0 : nil })
            .map({ "\($0.identifier) \(String(format: "%.2f", $0.confidence))" })
            .joined(separator: "\n")
        
        DispatchQueue.main.async{
            if classifications.contains("Hand") && classifications.contains("Front")  {
                self.label.text = "Press button to take a picture"
                self.label.textColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
                self.btn.isEnabled = true
            } else {
                self.label.text = "Please put your hand on camera"
                self.label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                self.btn.isEnabled = false
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewDisplayLayer.frame = self.cameraView.bounds
    }
    // Convert CIImage to CGImage
    func convert(cmage:CIImage) -> UIImage
    {
        
        let context:CIContext = CIContext.init(options: nil)
        let cgImage:CGImage = context.createCGImage(cmage, from: cmage.extent)!
        let image:UIImage = UIImage.init(cgImage: cgImage)
        return image
    }
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        let ciimage : CIImage = CIImage(cvPixelBuffer: pixelBuffer)
        image = self.convert(cmage: ciimage)
        var requestOptions:[VNImageOption: Any] = [:]
        if let cameraData = CMGetAttachment(sampleBuffer, key: kCMSampleBufferAttachmentKey_CameraIntrinsicMatrix, attachmentModeOut: nil) {
            requestOptions = [.cameraIntrinsics: cameraData]
        }
        
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: requestOptions)
        
        do {
            try imageRequestHandler.perform(self.visionRequests)
            
        } catch {
            print(error)
        }
    }
    
    
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func capturePressed(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ShowHandResultViewController") as! ShowHandResultViewController
            
            vc.modalPresentationStyle = .fullScreen
            vc.capturePic = image
            
            self.present(vc, animated: true, completion: nil)
        }
        
    }
    
}
