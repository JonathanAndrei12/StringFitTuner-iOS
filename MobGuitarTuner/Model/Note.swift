//
//  Note.swift
//  GuitarTuner WatchKit Extension
//
//  Created by Jonathan Andrei on 16/08/21.
//

import Foundation

//enum Accidental: String {
//    case Sharp = "♯"
//    case Flat =  "♭"
//    case Natural = ""
//}
//
//enum Note: CustomStringConvertible {
//    case c(_:Accidental?)
//    case d(_:Accidental?)
//    case e(_:Accidental?)
//    case f(_:Accidental?)
//    case g(_:Accidental?)
//    case a(_:Accidental?)
//    case b(_:Accidental?)
//
//    static let all: [Note] = [
//        c(.Natural), c(.Sharp),
//
//    ]
//}
class Note: Equatable {
    
    enum Accidental: String { //Note Sign
        case Sharp = "♯"
        case Flat =  "♭"
        case Natural = ""
    }
    
    enum Name: String { //Note Name
        case c = "c"
        case d = "d"
        case e = "e"
        case f = "f"
        case g = "g"
        case a = "a"
        case b = "b"
    }
    
    var note: Name
    var accidental: Accidental
    
    var frequency: Double { //To get note's frequency
        let index = Note.allNote.firstIndex(where: {$0 == self})! -
            Note.allNote.firstIndex(where: {$0 == Note(.a, .Natural)})!
        
        return 440.0 * pow(2, Double(index) / 12.0)
    }
    
    init(_ note: Name, _ accidental: Accidental) { //Note intializer
        self.note = note
        self.accidental = accidental
    }
    
    static let allNote: [Note] = [ //All note array
        Note(.c, .Natural), Note(.c, .Sharp),
        Note(.d, .Natural),
        Note(.e, .Flat), Note(.e, .Natural),
        Note(.f, .Natural), Note(.f, .Sharp),
        Note(.g, .Natural),
        Note(.a, .Flat), Note(.a, .Natural),
        Note(.b, .Flat), Note(.b, .Natural)
    ]
    
    //Equality Operators (Equatable code rule)
    static func == (a: Note, b: Note) -> Bool {
        return a.note == b.note && a.accidental == b.accidental
    }
    
    static func != (a: Note, b: Note) -> Bool {
        return !(a == b)
    }
}
