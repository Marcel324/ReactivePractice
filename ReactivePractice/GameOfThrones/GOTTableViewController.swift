//
//  GOTTableViewController.swift
//  ReactivePractice
//
//  Created by Marcel Chaucer on 12/6/17.
//  Copyright © 2017 Marcel Chaucer. All rights reserved.
//

import UIKit

class GOTTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: GOTViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = GOTViewModel()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        viewModel.housesPipe.output.observe { (_) in
            print("Signal from View Model")
            print("This is how many houses are in the json \(self.viewModel.getHouseCount())")
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    // TableView Methods
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GOTTableViewCell", for: indexPath) as? GOTTableViewCell else { fatalError("Cell not exists in storyboard")}
        
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.houseRegionLabel.text = cellVM.houseRegion
        cell.houseTitleLabel.text = cellVM.houseName
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getHouseCount()
    }
    
}
