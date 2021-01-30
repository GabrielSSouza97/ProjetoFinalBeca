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
    
// @IBOutlet weak var viewUm: UIView!
    
// @IBOutlet weak var viewDois: UIView!
    
    // MARK: Acessibility
    
    func setupAccessibility() {
       // viewUm.isAccessibilityElement = true
       // viewUm.accessibilityLabel = "Nesse espaço contém o valor da moeda selecionada, o botão adicionar ou remover aos favoritos"
        
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
        
        
        //viewDois.isAccessibilityElement = true
       // viewDois.accessibilityLabel = "Nesse espaço contém os volumes negociados, sendo os valores da última hora, do último dia e do último mês"
        
//        valorUltimaHora.isAccessibilityElement = true
//
//        valorUltimaHora.accessibilityLabel = "valor da última hora"
//
//        valorUltimoDia.isAccessibilityElement = true
//        //valorUltimoDia.accessibilityTraits = .
//        valorUltimoDia.accessibilityLabel = "valor do último dia"
//
//        valorUltimoMes.isAccessibilityElement = true
//        //valorUltimoMes.accessibilityTraits = .
//        valorUltimoMes.accessibilityLabel = "valor do último mês"
    
       //self.accessibilityElements = [viewUm,siglaMoeda, imagemMoeda,valorPrincipal, labelBotao, viewDois ]
    }
        
    
    // MARK : @IBAction
    
    @IBAction func removeAdiciona(_ sender: UIButton) {
        if moedaDetalhe.isFavorite == false {
                  guard moedaDetalhe.siglaMoeda != nil else { return }
                  let sigla = moedaDetalhe.siglaMoeda
                  
                  //Chama UserDefaults
                  let defaults = UserDefaults.standard
                  //Recupera Array
                  var fav = defaults.array(forKey: "ArrayFavoritos")
                  //Salva nova sigla no UserDefaults Array
                  fav?.append(sigla)
                  defaults.set(fav, forKey: "ArrayFavoritos")
              } else {
        }
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
                    } else {
                        labelBotao.text = "REMOVER"
                    }
           }
    }


