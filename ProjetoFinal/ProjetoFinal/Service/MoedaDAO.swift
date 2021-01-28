//
//  MoedaDAO.swift
//  ProjetoFinal
//
//  Created by Leticia Sousa Siqueira on 28/01/21.
//

import Foundation
import CommonsService

class MoedaDAO {
    
    static let shared: MoedaDAO = MoedaDAO()
    
    private var moedas: [Moeda] = []
    
    private let moedaService: MoedaService
    
    init(moedaService: MoedaService = MoedaService()) {
        self.moedaService = moedaService
    }
    
    func getMoedas(completion: @escaping (_ moeda: [Moeda])->() ) {
        if moedas.count > 0 {
            completion(moedas)
        } else {
            moedaService.getDataFromServer { (sucess, moedasResponse) in
                switch sucess {
                case true:
                    self.moedas = moedasResponse != nil ? moedasResponse! : []
                    completion(self.moedas)
                case false:
                    completion(self.moedas)
                }
            }
        }
    }
}
