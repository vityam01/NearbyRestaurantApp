//
//  ViewController.swift
//  RestaurantApp
//
//  Created by Vitya Mandryk on 15.06.2022.
//

import UIKit

final class ViewController: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak private var searchBar: UISearchBar!
    @IBOutlet weak private var tableView: UITableView!
    
    
    private var viewModel: MainViewControllerModel?
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }

    //MARK: private methods
    private func initUI() {
        self.viewModel = MainViewControllerModel()
        tableView.register(UINib(nibName: MainTableViewCell.identifier, bundle: nil),
                           forCellReuseIdentifier: MainTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        setData()
    }
    
    private func setData() {
        guard let viewModel = viewModel else { return }
        viewModel.getDataForElements { [ weak self ] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    @IBAction func filterButtomTapped(_ sender: Any) {
        let vc = FilterViewController()
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


//MARK: TableView Extension
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as? MainTableViewCell, let viewModel = viewModel else { return UITableViewCell() }
        cell.configure(with: viewModel.getCell(indexPath: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async { [ weak self ] in
            let vc = DetailViewController()
            guard let viewModel = self?.viewModel else { return }
            let index = viewModel.getData(indexPath: indexPath)
            vc.viewModel = index
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel?.heightForRow() ?? 0
    }
}

//MARK: SearchBar Extension
extension ViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) { }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text,
              let viewModel = viewModel else { return }
        viewModel.searchData(query: text, completion: { [ weak self ] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })
    }
}


extension ViewController: FilterViewControllerDelegate {
    func getSearchItemId(id: Int) {
        viewModel?.filterDataByID(id: id) { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
}
