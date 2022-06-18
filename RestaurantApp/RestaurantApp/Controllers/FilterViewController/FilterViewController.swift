//
//  FilterViewController.swift
//  RestaurantApp
//
//  Created by Vitya Mandryk on 16.06.2022.
//

import UIKit

protocol FilterViewControllerDelegate {
    func getSearchItemId(id: Int)
}

final class FilterViewController: UIViewController {

    @IBOutlet weak private var filterList: UITableView!
    
    private var viewModel: FilterViewControllerModel?
    var delegate: FilterViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    private func initUI() {
        
        filterList.register(UINib(nibName: FilterTableViewCell.identifier, bundle: nil),
                           forCellReuseIdentifier: FilterTableViewCell.identifier)
        filterList.delegate = self
        filterList.dataSource = self
        self.viewModel = FilterViewControllerModel()
        guard let viewModel = viewModel else { return }

        self.title = viewModel.titleText
    }
    

}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfrows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilterTableViewCell.identifier, for: indexPath) as? FilterTableViewCell else { return UITableViewCell()}
        cell.configure(data: viewModel?.setData(indexPath: indexPath) ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        delegate?.getSearchItemId(id: viewModel.getCategoriesID(indexPath: indexPath))
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel?.heightForRow() ?? 0
    }
    
    
}

