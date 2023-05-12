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
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        showLoader()
        fetchPics()
    }
    
    private func fetchPics() {
        self.viewModel.picsLoaded = { [weak self] (_, success) in
            self?.hideLoader()
            if success {
                self?.tableView.reloadData()
                self?.refreshControl.endRefreshing()
            }
        }
    }

    private func setupUI() {
        self.title = "Picsum"
        self.tableView.registerCell(type: PicsListCell.self)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
           refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
           tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        viewModel.callService()
    }
    
    @objc func checkBoxAction(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        viewModel.picsList?[sender.tag].isSelected = sender.isSelected
    }
    
    func getAspectRatioAccordingToiPhones(cellImageFrame: CGSize, downloadedImage: UIImage) -> CGFloat {
        let widthOffset = downloadedImage.size.width - cellImageFrame.width
        let widthOffsetPercentage = (widthOffset*100)/downloadedImage.size.width
        let heightOffset = (widthOffsetPercentage * downloadedImage.size.height)/100
        let effectiveHeight = downloadedImage.size.height - heightOffset
        return(effectiveHeight)
    }
}

extension PicsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let isSelected = viewModel.picsList?[indexPath.row].isSelected, isSelected {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let detailView = storyBoard.instantiateViewController(withIdentifier: "PicsDetailViewController") as! PicsDetailViewController
            detailView.pic = viewModel.picsList?[indexPath.row]
            self.navigationController?.pushViewController(detailView, animated: true)
        }
        else {
            let alert = UIAlertController(title: "Picsum", message: "Please select picture to procees", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
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
        
        var cellFrame = cell.frame.size
        cellFrame.height =  cellFrame.height - 15
        cellFrame.width =  cellFrame.width - 15
        if let url = URL(string: pic.downloadUrl) {
            cell.picImageView.sd_setImage(with: url, placeholderImage: nil, options: [], completed: { (theImage, error, cache, url) in
                self.tableView.beginUpdates()
                if let image = theImage {
                    cell.imageHeightContraint.constant = self.getAspectRatioAccordingToiPhones(cellImageFrame: cellFrame,downloadedImage: image)
                }
                self.tableView.endUpdates()
            })
        }
        
        return cell
    }

}
