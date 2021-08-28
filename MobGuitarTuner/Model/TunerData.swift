//
//  TunerData.swift
//  MobGuitarTuner
//
//  Created by Jonathan Andrei on 24/08/21.
//

import Foundation

class TunerData: ObservableObject {
    
    @Published var pitch: Float = 0.0
    @Published var amplitude: Float = 0.0
    @Published var noteNameWithSharps = "E"
    @Published var noteNameWithFlats = "E"
    @Published var noteOctave = "2"
    
    let noteFrequenciesList = [16.35, 17.32, 18.35, 19.45, 20.6, 21.83, 23.12, 24.5, 25.96, 27.5, 29.14, 30.87]
    let noteNamesWithSharpsList: [String] = ["C", "C♯", "D", "D♯", "E", "F", "F♯", "G", "G♯", "A", "A♯", "B"]
    let noteNamesWithFlatsList: [String] = ["C", "D♭", "D", "E♭", "E", "F", "G♭", "G", "A♭", "A", "B♭", "B"]
    
    let tuningDataList = ["Standard E" : ["E", "A", "D", "G", "B", "E"],
                          "Drop D" : ["D", "A", "D", "G", "B", "E"],
                          "Double Drop D" : ["D", "A", "D", "G", "B", "D"],
                          "Open D Major" : ["D", "A", "D", "F#", "A", "D"],
                          "Open D Minor" : ["D", "A", "D", "F", "A", "D"]]
    
}
