//
//  DetalhesViewController.swift
//  DetalhesMoedas
//
//  Created by Leticia Sousa Siqueira on 26/01/21.
//

import UIKit
import CommonsService
public class DetalhesViewController: UIViewController {
    
    
    //MARK: Variáveis
    let formataNumero: FormataNumero
    
    
    //MARK: @IBOutlet
    
    @IBOutlet weak var siglaMoeda: UILabel!
    
    @IBOutlet weak var imagemMoeda: UIImageView!
    
    @IBOutlet weak var valorPrincipal: UILabel!
    
    @IBOutlet weak var valorUltimaHora: UILabel!
    
    @IBOutlet weak var valorUltimoDia: UILabel!
    
    @IBOutlet weak var valorUltimoMes: UILabel!
    
    @IBOutlet weak var labelBotao: UILabel!
    
    
    // MARK : @IBAction
    
    @IBAction func voltar(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil) }
    
    @IBOutlet weak var imagemFavorito: UIImageView!
    
    @IBAction func removeAdiciona(_ sender: UIButton) {
        labelBotao.text = "ADICIONAR"
    }
    
    
    public init(_ formata: FormataNumero = FormataNumero()) {
        self.formataNumero = formata
        super.init(nibName: "DetalhesViewController", bundle: Bundle(for: DetalhesViewController.self))
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   public func carregaDetalhes(_ moeda:Moeda) {
        siglaMoeda.text = moeda.siglaMoeda
        valorPrincipal.text = self.formataNumero.formatarCotacao(cotacao: moeda.priceUSD!)
        valorUltimaHora.text = self.formataNumero.formatarCotacao(cotacao: moeda.volumeHora!)
        valorUltimoDia.text = self.formataNumero.formatarCotacao(cotacao: moeda.volumeDia!)
        valorUltimoMes.text = self.formataNumero.formatarCotacao(cotacao: moeda.volumeMes!)
   }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        let moedaEstatico: Moeda = Moeda(siglaMoeda: "BTC" , name: "BitCoin", priceUSD: 130000.21, volumeHora: 300000.21, volumeDia: 220000.21, volumeMes: 136800.21, idIcon: "4caf2b16-a017-4e26-a348-2cea69c34cba")
        
        carregaDetalhes(moedaEstatico)
        
        
        let url = moedaEstatico.idIcon!
        let newUrl = url.replacingOccurrences(of: "-", with: "")
        guard let imageUrl = URL(string: "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_32/\(newUrl).png") else { return }
//
//        cell.imagemMoeda.af_setImage(withURL: imageUrl)
    
      // imagemMoeda.image = image

        
    }
}
