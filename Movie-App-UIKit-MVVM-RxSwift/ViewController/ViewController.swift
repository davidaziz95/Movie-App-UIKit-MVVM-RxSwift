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
    let spinner = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height:40))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([ spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor), spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor) ])
        spinner.startAnimating()
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.rx.setDelegate(self).disposed(by: bag)
        viewModel.movies.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: TableViewCell.self)) { (row, item, cell) in
            self.spinner.stopAnimating()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
