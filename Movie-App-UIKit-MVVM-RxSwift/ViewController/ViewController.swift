//
//  ViewController.swift
//  Movie-App-UIKit-MVVM-RxSwift
//
//  Created by David Aziz [Pharma] on 06/09/2022.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var bag = DisposeBag()
    private var viewModel = HomePageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.rx.setDelegate(self).disposed(by: bag)
        viewModel.movies.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: TableViewCell.self)) { (row, item, cell) in
            guard let downloadURL = URL(string: EndPoints.baseImageURL + item.poster_path!) else {return}
            cell.posterImage?.sd_setImage(with: downloadURL, completed: nil)
          cell.titleLbl.text = item.title
          cell.descLbl.text = item.overview
            
        }.disposed(by: bag)
        
        navigationItem.title = "Home"
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
