//
//  TableViewCell.swift
//  Movie-App-UIKit-MVVM-RxSwift
//
//  Created by David Aziz [Pharma] on 16/09/2022.
//

import UIKit
import SDWebImage

class TableViewCell: UITableViewCell {
    
    var movieModel : Movie? {
        didSet {
            guard let downloadURL = URL(string: EndPoints.baseImageURL + movieModel!.poster_path!) else {return}
            posterImage?.sd_setImage(with: downloadURL, completed: nil)
            titleLbl.text = movieModel!.title
            descLbl.text = movieModel!.overview
        }
    }
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    
    override func awakeFromNib() {
        posterImage.clipsToBounds = true
        posterImage.layer.cornerRadius = 15
    }
}
