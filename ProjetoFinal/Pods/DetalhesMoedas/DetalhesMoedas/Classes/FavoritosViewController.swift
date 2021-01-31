//
//  FavoritosViewController.swift
//  DetalhesMoedas
//
//  Created by Leticia Sousa Siqueira on 26/01/21.
//

import UIKit
import CommonsService

public class FavoritosViewController: UIViewController {
    
    //@IBOutlet weak var siglaMoeda: UILabel!
    @IBOutlet weak var collectionViewFavoritos: UICollectionView?
    
    
    @IBOutlet weak var labelData: UILabel?
    
    let celulaFavorito = "celulaFavorito"
    public var moedaFavorito: Array<Moeda> = []
    var formata:FormataNumero
    
    
    public init() {
        formata = FormataNumero()
        let defaults = UserDefaults.standard
        print(defaults.object(forKey: "ListaFavoritos") ?? 0)
        
        super.init(nibName: "FavoritosViewController", bundle: Bundle(for: FavoritosViewController.self))
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        labelData?.text = Date().dateString()
        collectionViewFavoritos?.reloadData()
        //Perfil.shared
        //print(Perfil.shared.nome)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
            collectionViewFavoritos?.reloadData()
        }
    
    func setupCollectionView() {
        collectionViewFavoritos?.dataSource = self
        collectionViewFavoritos?.delegate = self
        
        let nibCell = UINib(nibName: "FavoritosCollectionViewCell", bundle: Bundle(for: FavoritosViewController.self))
        collectionViewFavoritos?.register(nibCell, forCellWithReuseIdentifier: celulaFavorito)
    }
    
}

extension FavoritosViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moedaFavorito.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width/2 - 20, height: collectionView.bounds.height/4)
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celula = collectionView.dequeueReusableCell(withReuseIdentifier: celulaFavorito, for: indexPath) as! FavoritosCollectionViewCell
                
                let moeda = moedaFavorito[indexPath.row]
                
                celula.layer.cornerRadius = 7
                celula.layer.borderWidth = 0.5
                celula.labelNomeMoeda.text = moeda.name
                celula.labelSiglaMoeda.text = moeda.siglaMoeda
                celula.labelValorMoeda.text = formata.formatarCotacao(cotacao: moeda.priceUSD ?? 0)

                return celula
    }
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            collectionView.deselectItem(at: indexPath, animated: true)
            var moedaSelecionada = moedaFavorito[indexPath.row]
            moedaSelecionada.isFavorite = true
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
