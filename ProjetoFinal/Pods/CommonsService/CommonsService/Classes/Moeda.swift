//
//  Moeda.swift
//  CommonsService
//
//  Created by Leticia Sousa Siqueira on 26/01/21.
//

import Foundation

public struct Moeda : Decodable {
    
    public var siglaMoeda: String
    public var name: String?
    public var priceUSD: Double?
    public var volumeHora: Double?
    public var volumeDia: Double?
    public var volumeMes: Double?
    public var idIcon: String?
    public var isFavorite: Bool = false
    
    public init(siglaMoeda: String, name: String?, priceUSD: Double?, volumeHora: Double?, volumeDia: Double?, volumeMes: Double?, idIcon: String?) {
        self.siglaMoeda = siglaMoeda
        self.name = name
        self.priceUSD = priceUSD
        self.volumeHora = volumeHora
        self.volumeDia = volumeDia
        self.volumeMes = volumeMes
        self.idIcon = idIcon
    }
    
    public enum CodingKeys: String, CodingKey{
        case siglaMoeda = "asset_id"
        case name
        case priceUSD = "price_usd"
        case volumeHora = "volume_1hrs_usd"
        case volumeDia = "volume_1day_usd"
        case volumeMes = "volume_1mth_usd"
        case idIcon = "id_icon"
    }
    
}

