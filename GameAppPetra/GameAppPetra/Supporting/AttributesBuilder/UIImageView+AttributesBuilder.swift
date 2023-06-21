import UIKit
import Alamofire

public extension UIImageView {

    @discardableResult
    func image(_ image: UIImage?) -> Self {
        self.image = image
        return self
    }

    @discardableResult
    func contentMode(_ contentMode: UIView.ContentMode) -> Self {
        self.contentMode = contentMode
        return self
    }

    @discardableResult
    func transform(_ transform: CGAffineTransform) -> Self {
        self.transform = transform
        return self
    }

    @discardableResult
    func rotatedBy(_ angle: CGFloat) -> Self {
        return self.transform(CGAffineTransform(rotationAngle: angle))
    }
    
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        AF.download(url).responseData { [weak self] response in
            switch response.result {
            case .success(let data):
                if let loadedImage = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = loadedImage
                    }
                }
            case .failure(let error):
                print("Error loading image: \(error.localizedDescription)")
            }
        }
    }
    
//    func loadFrom(URLAddress: String) {
//        guard let url = URL(string: URLAddress) else {
//            return
//        }
//
//        DispatchQueue.global().async { [weak self] in
//            URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
//                if let error = error {
//                    print("Error loading image: \(error.localizedDescription)")
//                    return
//                }
//
//                if let imageData = data, let loadedImage = UIImage(data: imageData) {
//                    DispatchQueue.main.async {
//                        self?.image = loadedImage
//                    }
//                }
//            }.resume()
//        }
//    }
}
