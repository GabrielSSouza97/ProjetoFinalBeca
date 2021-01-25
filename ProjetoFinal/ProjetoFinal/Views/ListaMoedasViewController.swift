//
//  ListaMoedasViewController.swift
//  ProjetoFinal
//
//  Created by Leticia Sousa Siqueira on 22/01/21.
//

import UIKit
import AlamofireImage

class ListaMoedasViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var dataLabel: UILabel!
    
    init() {
        super.init(nibName: "ListaMoedasViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
    
    var dataViewModel = DataViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        tableView.dataSource = self
        
        dataLabel.text = Date().dateString()
        
//        let tabBar = UITabBarController()
//        tabBar.
        
        initViewModel()
        
    }

    
    func initViewModel(){
        dataViewModel.reloadTableView = {
            DispatchQueue.main.async { self.tableView.reloadData() }
        }
        dataViewModel.showError = {
            DispatchQueue.main.async { self.showAlert("Algo deu errado!") }
        }
        dataViewModel.showLoading = {
            DispatchQueue.main.async { self.activityIndicator.startAnimating() }
        }
        dataViewModel.hideLoading = {
            DispatchQueue.main.async { self.activityIndicator.stopAnimating() }
        }
        dataViewModel.getData()
    }
}

extension ListaMoedasViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataViewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(UINib(nibName: "CustomizacaoTableViewCell", bundle: nil), forCellReuseIdentifier: "customTableViewCell")
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customTableViewCell", for: indexPath) as? CustomizacaoTableViewCell else {
            fatalError("A célula não existe!")
        }
        let cellVM = dataViewModel.getCellViewModel( at: indexPath )
        cell.siglaLabel.text = cellVM.siglaText
        cell.nomeLabel.text = cellVM.nomeText
        cell.cotacaoLabel.text = String(cellVM.cotacaoText)
        
        let url = cellVM.imagemURL
        let newUrl = url.replacingOccurrences(of: "-", with: "")
        guard let imageUrl = URL(string: "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_32/\(newUrl).png") else { return UITableViewCell()}
        
        cell.imagemMoeda.af_setImage(withURL: imageUrl)
        
        return cell
    
    }
    
}

extension Date {
    func dateString() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        let result = formatter.string(from: date)
        
        return result
    }
}




