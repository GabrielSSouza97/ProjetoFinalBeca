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
    
    //MARK: @IBOutlet
    
    @IBOutlet weak var siglaMoeda: UILabel!
    @IBOutlet weak var imagemMoeda: UIImageView!
    @IBOutlet weak var valorPrincipal: UILabel!
    @IBOutlet weak var removerAdicionar: UILabel!
    @IBOutlet weak var valorUltimaHora: UILabel!
    @IBOutlet weak var valorUltimoDia: UILabel!
    @IBOutlet weak var valorUltimoMes: UILabel!
    
    // MARK : @IBAction
    
    @IBAction func voltar(_ sender: UIButton) {
        //self.dismiss(animated: true, completion: nil)
        //self.navigationController?.pushViewController(controller, animated: true)
        //self.navigationController?.popViewController(animated: true)
    }
    
    var moedaDetalhe: Moeda
    let formataNumero: FormataNumero
    
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
    }
    
    public func configuraValores() {
        siglaMoeda.text = moedaDetalhe.siglaMoeda
        valorPrincipal.text = formataNumero.formatarCotacao(cotacao: (moedaDetalhe.priceUSD ?? 0))
        valorUltimoDia.text = formataNumero.formatarCotacao(cotacao: (moedaDetalhe.volumeDia ?? 0))
        valorUltimaHora.text = formataNumero.formatarCotacao(cotacao: (moedaDetalhe.volumeHora ?? 0))
        valorUltimoMes.text = formataNumero.formatarCotacao(cotacao: (moedaDetalhe.volumeMes ?? 0))

        
//        let url = moedaDetalhe.idIcon
//        let newUrl = url?.replacingOccurrences(of: "-", with: "")
//        guard let imageUrl = URL(string: "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_32/\(newUrl).png") else { return UIImage()}
//
//        imagemMoeda.af_setImage(withURL: imageUrl)
    }
    
}
