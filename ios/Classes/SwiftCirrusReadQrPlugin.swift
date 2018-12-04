import Flutter
import AVFoundation
import UIKit

public class SwiftCirrusReadQrPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "cirrus_read_qr", binaryMessenger: registrar.messenger())
    let instance = SwiftCirrusReadQrPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    
  }
}
class ImagePickerController: UIImagePickerController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var handler: ((_ image: UIImage?) -> Void)?
    
    convenience init(sourceType: UIImagePickerControllerSourceType, handler: @escaping (_ image: UIImage?) -> Void) {
        self.init()
        self.sourceType = sourceType
        self.delegate = self
        self.handler = handler
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        handler?(info[UIImagePickerControllerOriginalImage] as? UIImage)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        handler?(nil)
        
        print("Picker: \(picker)")
    }
}
