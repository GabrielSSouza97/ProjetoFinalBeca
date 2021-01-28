//
//  DetalhesViewController.swift
//  DetalhesMoedas
//
//  Created by Leticia Sousa Siqueira on 26/01/21.
//

import UIKit
import CommonsService
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
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    public init() {
        super.init(nibName: "DetalhesViewController", bundle: Bundle(for: DetalhesViewController.self))
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//   public func carregaDetalhes(_ moeda:Moeda) {
//    siglaMoeda.text = moeda.siglaMoeda
//       valorPrincipal.text = String(moeda.priceUSD)
//       valorUltimaHora.text = String(moeda.volumeHora)
//
//   }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        siglaMoeda.text = "SIGLA MOEDA"
        valorPrincipal.text = "$35.0000.22"
        valorUltimoDia.text = "$123.456.78"
        valorUltimoMes.text = "$123.456.78"
        valorUltimaHora.text = "$123.456.78"
      // imagemMoeda.image = image
        
    }
}
