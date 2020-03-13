//
//  Buku.swift
//  KutuBuku
//
//  Created by Firza Ilhami on 13/03/20.
//  Copyright © 2020 Firza Ilhami. All rights reserved.
//

import UIKit

struct Buku {
    var title: String = ""
    var lastPage: Int = 0
    var historyRead: [String] = []
    
    mutating func addTitle(judulBuku: String) {
        title = judulBuku
    }
    
    mutating func addHistoryRead(hist: String) {
        historyRead.append(hist)
    }
    
}


