//
//  PhotoCollectionViewCell.swift
//  UserPhoto
//
//  Created by Egor Markov on 6/11/21.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var userTitle: UILabel!
    @IBOutlet weak var backgroundViewCell: UIView!
    
    // MARK: - Property
    let imageCache = NSCache<NSString, UIImage>()
    var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.style = .medium
        activity.startAnimating()
        return activity
    }()
    
    var album: AlbumUser? {
        didSet{
            
            
            guard let photoUrl = URL(string: album?.url ?? "") else {return}
            if let cachedImage = imageCache.object(forKey: photoUrl.absoluteString as NSString) {
                print("cachedImage load", imageCache)
                self.userPhoto.image = cachedImage
                activityIndicator.removeFromSuperview()
            }else{
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: photoUrl) {
                        if let image = UIImage(data: data) {
                            self.imageCache.setObject(image, forKey: photoUrl.absoluteString as NSString)
                            print("imageCache load", self.imageCache)
                            DispatchQueue.main.async {
                                self.activityIndicator.removeFromSuperview()
                                self.userTitle.text = self.album?.title
                                self.userPhoto.image = image
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    // MARK: - AwakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicator.center = userPhoto.center
        userPhoto.addSubview(activityIndicator)
        cellShadow()
    }
    
    // MARK: - PrepareForReuse
    override func prepareForReuse() {
        userPhoto.image = nil
        userTitle.text = nil
    }
    
    
    // MARK: - Func
    func cellShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 2.0, height: 1.0)
        layer.shadowRadius = 10.0
        layer.shadowOpacity = 0.6
        layer.masksToBounds = false
        backgroundViewCell.layer.shadowPath = UIBezierPath(roundedRect: contentView.bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        backgroundViewCell.layer.cornerRadius = 10
    }
    
    
    
}
