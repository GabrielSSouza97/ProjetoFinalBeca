//
//  MoedaService.swift
//  ProjetoFinal
//
//  Created by Leticia Sousa Siqueira on 22/01/21.
//

import UIKit
import Alamofire

protocol MoedaServiceProtocol {
    func getDataFromServer(complete: @escaping (_ success: Bool, _ moeda: [Moeda]? )->() )
}

class MoedaService : MoedaServiceProtocol {
    
    func getDataFromServer(complete: @escaping (Bool, [Moeda]?) -> ()) {

           let request = AF.request("https://rest-sandbox.coinapi.io/v1/assets?apikey=50F5E142-F260-4CCE-95F6-713F18D30FC3")
        
//            request.responseJSON { (data) in
//                  print(data)
//            }

           request.responseDecodable(of: [Moeda].self) { (response) in
                guard let moedas = response.value else {
                    return }

                var listaMoedas: [Moeda] = [Moeda]()
                print(moedas)

//                for i in 0...listaMoedas.count{
//                    listaMoedas.append(Moeda(siglaMoeda: "\(moedas[i].siglaMoeda)", name: "\(moedas[i].name)", priceUSD: "\(moedas[i].priceUSD)", volumeHora: "\(moedas.all[i].volumeHora)", volumeDia: "\(moedas.all[i].volumeDia)", volumeMes: "\(moedas.all[i].volumeMes)", idIcon: "\(moedas.all[i].idIcon)"))
//                }

               complete(true, listaMoedas)

           }

    }

    
}

