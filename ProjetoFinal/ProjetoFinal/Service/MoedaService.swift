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
    func getDataFromServer(complete: @escaping (_ success: Bool, _ moeda: [Moeda]? ) -> Void)
}

class MoedaService : MoedaServiceProtocol {
    func getDataFromServer(complete: @escaping (Bool, [Moeda]?) -> Void) {
        AF.request("https://rest.coinapi.io/v1/assets?apikey=50F5E142-F260-4CCE-95F6-713F18D30FC3").validate().responseDecodable(of: [Moeda].self) { apiResponse in
            switch apiResponse.result {
            case .success(let events):
                complete(true, events)
            case .failure(let error):
                print(error)
                if let httpResponse =  apiResponse.response?.statusCode {
                    switch httpResponse {
                    case 400:
                        self.alertWindow(title: "Erro 400: Bad Request", message: "Falha na requisição dos dados, sintaxe inválida!")
                    case 401:
                        self.alertWindow(title: "Erro 401: Unauthorized", message: "Falha na requisição dos dados, autenticação inválida!")
                    case 403:
                        self.alertWindow(title: "Erro 403: Forbidden", message: "Falha na requisição dos dados, sem permissão para acesso!")
                    case 429:
                        self.alertWindow(title: "Erro 429: Too Many Requests", message: "Falha na requisição dos dados, quantidade de requisicições excedida!")
                    case 550:
                        self.alertWindow(title: "Erro 550: No Data", message: "Falha na requisição dos dados, o dado não existe!")
                        break
                    default:
                        break
                    }
                }            }
        }
    }
}

extension MoedaService {

    func alertWindow(title: String, message: String) {
        DispatchQueue.main.async(execute: {
            let alertWindow = UIWindow(frame: UIScreen.main.bounds)
            alertWindow.rootViewController = UIViewController()
            alertWindow.windowLevel = UIWindow.Level.alert + 1

            let alerta = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let tentarNovamente = UIAlertAction(title: "Tente novamente", style: .default, handler: { action in
                CustomizacaoViewModel().getData()
            })
            alerta.addAction(tentarNovamente)

            let cancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
            alerta.addAction(cancelar)

            alertWindow.makeKeyAndVisible()

            alertWindow.rootViewController?.present(alerta, animated: true, completion: nil)
        })
    }
}
