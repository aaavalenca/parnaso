//
//  Palavra.swift
//  Parnaso
//
//  Created by aaav on 06/04/22.
//

import Foundation

class Palavra {
    var palavra : String = ""
    var tamanho : Int = 0
    var silabas : String = ""
    
    init (_ palavra : String,_ tamanho: Int,_  silabas : String){
        self.palavra = palavra
        self.tamanho = tamanho
        self.silabas = silabas
    }
    
}
