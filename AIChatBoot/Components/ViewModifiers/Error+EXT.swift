//
//  Error+EXT.swift
//  AIChatBoot
//
//  Created by Dhiman Das on 11.06.25.
//

import Foundation

extension Error {
    
    var eventParameters: [String: Any] {
        [
            "error_description": localizedDescription
        ]
    }
}
