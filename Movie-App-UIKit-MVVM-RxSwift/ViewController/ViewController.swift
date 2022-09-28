//
//  ViewController.swift
//  Movie-App-UIKit-MVVM-RxSwift
//
//  Created by David Aziz [Pharma] on 06/09/2022.
//

import UIKit
import RxSwift
import RxCocoa


class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var bag = DisposeBag()
    private var viewModel = HomePageViewModel()
    let spinner = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Home"
        addSpinner()
        addTableView()
    }
    
    func addSpinner() {
        view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([ spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor), spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor) ])
        viewModel.isLoading.observe(on: MainScheduler.instance).bind(to: spinner.rx.isAnimating).disposed(by: bag)
    }
    
    func addTableView() {
        tableView.register(UINib(nibName: String(describing: TableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: TableViewCell.self))
        tableView.rx.setDelegate(self).disposed(by: bag)
        viewModel.movies.bind(to: tableView.rx.items(cellIdentifier: String(describing: TableViewCell.self), cellType: TableViewCell.self)) { (row, item, cell) in
            cell.movieModel = item
        }.disposed(by: bag)
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
