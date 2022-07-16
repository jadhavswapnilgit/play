//
//  TableViewCells.swift
//  Playo
//
//  Created by Sachin Jadhav on 15/07/22.
//

import UIKit

class TableViewCells: UITableViewCell {

    @IBOutlet weak var author: UILabel!
    
    @IBOutlet weak var descriptions: UILabel!
    
    @IBOutlet weak var title: UILabel!
//    @IBOutlet weak var img: LazyImageView!
    
    @IBOutlet weak var img: LazyImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    
}



class LazyImageView: UIImageView
{

    private let imageCache = NSCache<AnyObject, UIImage>()

    func loadImage(fromURL imageURL: URL, placeHolderImage: String)
    {
        self.image = UIImage(named: placeHolderImage)

        if let cachedImage = self.imageCache.object(forKey: imageURL as AnyObject)
        {
           
            self.image = cachedImage
            return
        }

        DispatchQueue.global().async {
            [weak self] in

            if let imageData = try? Data(contentsOf: imageURL)
            {
                if let image = UIImage(data: imageData)
                {
                    DispatchQueue.main.async {
                        self!.imageCache.setObject(image, forKey: imageURL as AnyObject)
                        self?.image = image
                    }
                }
            }
        }
    }
}
