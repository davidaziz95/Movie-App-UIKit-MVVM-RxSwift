//
//  TableViewCell.swift
//  Movie-App-UIKit-MVVM-RxSwift
//
//  Created by David Aziz [Pharma] on 16/09/2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: "cell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
    }
    
    override func awakeFromNib() {
        posterImage.clipsToBounds = true
        posterImage.layer.cornerRadius = 15
    }
}
