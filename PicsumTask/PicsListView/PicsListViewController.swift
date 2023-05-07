//
//  PicsListViewController.swift
//  PicsumTask
//
//  Created by Viveka G on 07/05/23.
//

import UIKit

class PicsListViewController: BaseViewController {

    private var viewModel = PicsListViewModel()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        showLoader()
        self.viewModel.picsLoaded = { [weak self] (_, success) in
            self?.hideLoader()
            if success {
                self?.tableView.reloadData()
            }
        }
    }

    private func setupUI() {
        self.tableView.registerCell(type: PicsListCell.self)
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    @objc func checkBoxAction(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        viewModel.picsList?[sender.tag].isSelected = sender.isSelected
    }
}

extension PicsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

extension PicsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOrRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(withType: PicsListCell.self, for: indexPath) as? PicsListCell, let pic = self.viewModel.getPic(index: indexPath.row) else {
            return UITableViewCell()
        }
        cell.checkBoxBtn.tag = indexPath.row
        cell.checkBoxBtn.addTarget(self, action: #selector(checkBoxAction(sender: )), for: .touchUpInside)
        cell.setPic(pic: pic)
        cell.checkBoxBtn.isSelected = pic.isSelected ?? false
        
        return cell
    }

}
