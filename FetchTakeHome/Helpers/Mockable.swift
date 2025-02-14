//
//  Mockable.swift
//  FetchTakeHome
//
//  Created by Sako Hovaguimian on 2/13/25.
//

protocol Mockable {
    
    static func DUMMY_DATA() -> Self
    static func DUMMY_DATA_ARRAY() -> [Self]
    
}
