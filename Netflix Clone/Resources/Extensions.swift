//
//  Extensions.swift
//  Netflix Clone
//
//  Created by Majapahit Wisisono on 23/07/25.
//

import Foundation


extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
