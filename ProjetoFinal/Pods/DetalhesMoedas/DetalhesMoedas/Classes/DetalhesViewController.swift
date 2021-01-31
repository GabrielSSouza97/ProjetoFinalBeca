//
//  DetalhesViewController.swift
//  DetalhesMoedas
//
//  Created by Leticia Sousa Siqueira on 26/01/21.
//

import UIKit
import CommonsService
import AlamofireImage

public class DetalhesViewController: UIViewController {
    
    //MARK: Variáveis
    let formataNumero: FormataNumero
    var moedaDetalhe: Moeda
    
    //MARK: @IBOutlet
    
    @IBOutlet weak var siglaMoeda: UILabel!
    @IBOutlet weak var imagemMoeda: UIImageView!
    @IBOutlet weak var valorPrincipal: UILabel!
    @IBOutlet weak var valorUltimaHora: UILabel!
    @IBOutlet weak var valorUltimoDia: UILabel!
    @IBOutlet weak var valorUltimoMes: UILabel!
    @IBOutlet weak var labelBotao: UILabel!
    @IBOutlet weak var imagemFavorito: UIImageView!
    

    
    // MARK: Acessibility
    
    func setupAccessibility() {
     
        
        //sigla
        siglaMoeda.isAccessibilityElement = true
        siglaMoeda.accessibilityTraits = .header
        siglaMoeda.accessibilityLabel = "Sigla da moeda"
        
        //imagem
        imagemMoeda.isAccessibilityElement = true
        imagemMoeda.accessibilityTraits = .image
        imagemMoeda.accessibilityLabel = "Imagem que representa a moeda selecionada"
        
        // botao adiciona/remove
        labelBotao.isAccessibilityElement = true
        labelBotao.accessibilityLabel = "Adicione ou Remova aos favoritos"
        labelBotao.accessibilityTraits = .button
        
    }
        
    
    // MARK : @IBAction
    
    @IBAction func removeAdiciona(_ sender: UIButton) {
        guard moedaDetalhe.siglaMoeda != nil else { return }
                    //Chama UserDefaults
                    let defaults = UserDefaults.standard
                    //tenta recuperar a lista, se não existir item, monta um array vazio
                    var listaFavoritos = defaults.object(forKey:"ListaFavoritos") as? [String] ?? [String]()
                    //só guardei a sigla da moeda aqui
                    let moeda = moedaDetalhe.siglaMoeda
                    //tem a sigla na lista? se sim, remove da lista
                    if(listaFavoritos.contains(moeda)) {
                        guard let indiceDaMoeda = listaFavoritos.firstIndex(of: moeda) else { return }
                        listaFavoritos.remove(at: indiceDaMoeda)
                    } else {
                        //se não, adiciona na lista
                        listaFavoritos.append(moeda)
                    }
                    
                    //Recupera Array
                    //var fav = defaults.array(forKey: "ListaFavoritos")
                    //Salva nova sigla no UserDefaults Array
                    
                    defaults.set(listaFavoritos, forKey: "ListaFavoritos")
                    //fav?.append(sigla)
                    self.navigationController?.popViewController(animated: true)
    }
    
    public init(moedaDetalhe: Moeda, formataNumero: FormataNumero = FormataNumero()) {
                self.moedaDetalhe = moedaDetalhe
                self.formataNumero = formataNumero
                super.init(nibName: "DetalhesViewController", bundle: Bundle(for: DetalhesViewController.self))
            }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
            super.viewDidLoad()
            configuraValores()
            self.navigationController?.setNavigationBarHidden(false, animated: false)
            setupAccessibility()
    }
    
    public func configuraValores() {
            siglaMoeda.text = moedaDetalhe.siglaMoeda
            valorPrincipal.text = formataNumero.formatarCotacao(cotacao: (moedaDetalhe.priceUSD ?? 0))
            valorUltimoDia.text = formataNumero.formatarCotacao(cotacao: (moedaDetalhe.volumeDia ?? 0))
            valorUltimaHora.text = formataNumero.formatarCotacao(cotacao: (moedaDetalhe.volumeHora ?? 0))
            valorUltimoMes.text = formataNumero.formatarCotacao(cotacao: (moedaDetalhe.volumeMes ?? 0))
            
            let url = moedaDetalhe.idIcon ?? ""
            let newUrl = url.replacingOccurrences(of: "-", with: "")
            guard let imageUrl = URL(string: "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_32/\(newUrl).png") else { return }
            imagemMoeda.af_setImage(withURL: imageUrl)
            
        if moedaDetalhe.isFavorite == false {

                        labelBotao.text = "ADICIONAR"

                        imagemFavorito.image = UIImage(named: "")

         } else {

                        labelBotao.text = "REMOVER"

                        imagemFavorito.image = UIImage(named: "icon_favorite.png")

         }
    }
}


