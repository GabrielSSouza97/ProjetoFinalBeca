//
//  MoedaService.swift
//  ProjetoFinal
//
//  Created by Leticia Sousa Siqueira on 22/01/21.
//

import Foundation
import UIKit
import Alamofire
import CommonsService

protocol MoedaServiceProtocol {
    func getDataFromServer(complete: @escaping (_ success: Bool, _ moeda: [Moeda]? )->() )
}

class MoedaService : MoedaServiceProtocol {
    
    func getDataFromServer(complete: @escaping (Bool, [Moeda]?) -> ()) {
        
        AF.request("https://rest.coinapi.io/v1/assets?apikey=50F5E142-F260-4CCE-95F6-713F18D30FC3").validate().responseDecodable(of: [Moeda].self) { apiResponse in
            switch apiResponse.result {
            case .success(let events):
                //print(events[0].siglaMoeda)
                complete(true, events)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

