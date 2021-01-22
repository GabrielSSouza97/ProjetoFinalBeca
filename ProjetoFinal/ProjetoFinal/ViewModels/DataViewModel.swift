//
//  DataViewModel.swift
//  ProjetoFinal
//
//  Created by Leticia Sousa Siqueira on 22/01/21.
//

import UIKit

class DataViewModel {
    
    var moedas: [Moeda] = [Moeda]()
    var reloadTableView: (()->())?
    var showError: (()->())?
    var showLoading: (()->())?
    var hideLoading: (()->())?
    
    
    private var cellViewModels: [DataListCellViewModel] = [DataListCellViewModel]() {
        didSet {
            self.reloadTableView?()
        }
    }
    
    func getData(){
        showLoading?()
        MoedaService().getDataFromServer { (success, moeda) in
            self.hideLoading?()
            if success {
                self.createCell(moedas: moeda!)
                self.reloadTableView?()
            } else {
                self.showError?()
            }
        }
    }
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> DataListCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func createCell(moedas: [Moeda]){
        self.moedas = moedas
        var vms = [DataListCellViewModel]()
        for data in moedas {
            vms.append(DataListCellViewModel(titleText: String(data.volumeMes), subTitleText: data.siglaMoeda))
        }
        cellViewModels = vms
    }
}

struct DataListCellViewModel {
    let titleText: String
    let subTitleText: String
}

