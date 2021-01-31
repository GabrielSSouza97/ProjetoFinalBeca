//
//  ListaMoedasViewController.swift
//  ProjetoFinal
//
//  Created by Leticia Sousa Siqueira on 22/01/21.
//

import UIKit
import AlamofireImage
import CommonsService
import DetalhesMoedas

class ListaMoedasViewController: UIViewController {
    
    // MARK: - IBOutlets

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var dataLabel: UILabel!
    
    // MARK: Attributes
    
    var customViewModel: CustomizacaoViewModel
    var moedas: Array<Moeda> = []
    let formataNumero: FormataNumero
    
    init(customViewModel: CustomizacaoViewModel = CustomizacaoViewModel(), formataNumero: FormataNumero = FormataNumero()) {
        self.customViewModel = customViewModel
        //self.customViewModel.getData()
        self.moedas = customViewModel.moedas
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
        initViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        print("Appear da lista principal")
        atualizaFavorito()
    }
    
    func atualizaFavorito() {
        let defaults = UserDefaults.standard
        //lista de favoritos
        let listaFavoritos = defaults.object(forKey:"ListaFavoritos") as? [String] ?? [String]()
        
        if(listaFavoritos.count > 0) {
            for var item in moedas {
                for itemFavorito in listaFavoritos {
                    if(item.siglaMoeda == itemFavorito) {
                        item.isFavorite = true
                    } else {
                        item.isFavorite = false
                    }
                }
            }
        }
    }

// MARK: - Methods
    
    func initViewModel(){
        customViewModel.reloadTableView = {
            DispatchQueue.main.async { self.tableView.reloadData() }
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
        
//        guard let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "customTableViewCell") as? CustomizacaoTableViewCell else {
//            fatalError("A célula não existe!")
//        }
        
        let cellVM = customViewModel.getCellViewModel( at: indexPath )
        moedas = customViewModel.moedas
        cell.siglaLabel.text = cellVM.siglaText
        cell.nomeLabel.text = cellVM.nomeText
        cell.cotacaoLabel.text = formataNumero.formatarCotacao(cotacao: cellVM.cotacaoText)
        
        //Chama UserDefaults
        let defaults = UserDefaults.standard
        //tenta recuperar a lista, se não existir item, monta um array vazio
        var listaFavoritos = defaults.object(forKey:"ListaFavoritos") as? [String] ?? [String]()

        //tem a sigla na lista? se sim, remove da lista
        if(listaFavoritos.contains(cellVM.siglaText)) {
            cell.imagemFavorito.image = UIImage(named: "icon_favorite.png")
            customViewModel.moedas[indexPath.row].isFavorite = true
        } else {
            cell.imagemFavorito.image = UIImage(named: "")
            customViewModel.moedas[indexPath.row].isFavorite = false
        }
        
        let url = cellVM.imagemURL
        let newUrl = url.replacingOccurrences(of: "-", with: "")
        guard let imageUrl = URL(string: "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_32/\(newUrl).png") else { return UITableViewCell()}
        cell.imagemMoeda.af_setImage(withURL: imageUrl)

        return cell
    
    }
    
}

extension ListaMoedasViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let moedaSelecionada = customViewModel.moedas[indexPath.row]
        
        tableView.deselectRow(at: indexPath, animated: true)
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



