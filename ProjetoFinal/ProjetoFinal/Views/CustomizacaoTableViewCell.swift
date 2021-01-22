//
//  CustomizacaoTableViewCell.swift
//  ProjetoFinal
//
//  Created by Leticia Sousa Siqueira on 22/01/21.
//

import UIKit

class CustomizacaoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var siglaLabel: UILabel!
    @IBOutlet weak var nomeLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
