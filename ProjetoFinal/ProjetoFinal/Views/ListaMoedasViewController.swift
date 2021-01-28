//
//  ListaMoedasViewController.swift
//  ProjetoFinal
//
//  Created by Leticia Sousa Siqueira on 22/01/21.
//

import UIKit
import AlamofireImage
import CommonsService

class ListaMoedasViewController: UIViewController {
    
    // MARK: - IBOutlets

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var dataLabel: UILabel!
    
    // MARK: Attributes
    
    var customViewModel: CustomizacaoViewModel
    let formataNumero: FormataNumero
    
    var moedas: Array<Moeda> = []

    
    init(customViewModel: CustomizacaoViewModel = CustomizacaoViewModel(), formataNumero: FormataNumero = FormataNumero()) {
        self.customViewModel = customViewModel
        self.formataNumero = formataNumero
        super.init(nibName: "ListaMoedasViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)

        tableView.dataSource = self
        tableView.delegate = self
        
        dataLabel.text = Date().dateString()
        
//        let tabBar = UITabBarController()
//        tabBar.
        
        initViewModel()
        
    }

// MARK: - Methods
    
    func initViewModel(){
        customViewModel.reloadTableView = {
            DispatchQueue.main.async { self.tableView.reloadData() }
        }
        customViewModel.showError = {
            DispatchQueue.main.async { self.showAlert("Algo deu errado!") }
        }
        customViewModel.showLoading = {
            DispatchQueue.main.async { self.activityIndicator.startAnimating() }
        }
        customViewModel.hideLoading = {
            DispatchQueue.main.async { self.activityIndicator.stopAnimating() }
            self.activityIndicator.hidesWhenStopped = true
        }
        customViewModel.getData()
    }
    
}

// MARK: - Extension

extension ListaMoedasViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customViewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(UINib(nibName: "CustomizacaoTableViewCell", bundle: nil), forCellReuseIdentifier: "customTableViewCell")
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customTableViewCell", for: indexPath) as? CustomizacaoTableViewCell else {
            fatalError("A célula não existe!")
        }
        
        let cellVM = customViewModel.getCellViewModel( at: indexPath )
        moedas = customViewModel.moedas
        cell.siglaLabel.text = cellVM.siglaText
        cell.nomeLabel.text = cellVM.nomeText
        cell.cotacaoLabel.text = formataNumero.formatarCotacao(cotacao: cellVM.cotacaoText)
        
        
        let url = cellVM.imagemURL
        let newUrl = url.replacingOccurrences(of: "-", with: "")
        guard let imageUrl = URL(string: "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_32/\(newUrl).png") else { return UITableViewCell()}
        
        cell.imagemMoeda.af_setImage(withURL: imageUrl)
        
        return cell
    
    }
    
}

extension ListaMoedasViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let moedaSelecionada = moedas[indexPath.row]
        
        let controller = DetalhesViewController(moedaDetalhe: moedaSelecionada)
        self.navigationController?.pushViewController(controller, animated: true)
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

