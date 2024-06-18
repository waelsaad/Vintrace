//
//  Decodable+.swift
//  Library
//
//  Created by Wael Saad on 15/12/2020.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

import Foundation

extension Decodable {
    
    static func decode(fileName: String) -> Self? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard
            let url = Bundle.main.url(
                forResource: fileName,
                withExtension: FileExtension.json.value
            ),
            let data = try? Data(contentsOf: url),
            let output = try? decoder.decode(self, from: data)
        else {
            print("Error: failed to decode " + fileName)
            return nil
        }
        
        return output
    }
    
}
