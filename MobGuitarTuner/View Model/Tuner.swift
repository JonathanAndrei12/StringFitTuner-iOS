//
//  Tuner.swift
//  MobGuitarTuner
//
//  Created by Jonathan Andrei on 26/08/21.
//

import Foundation

class Tuner: ObservableObject {
    
    @Published var data = TunerData()
    @Published var currentTuning: [String] = []
    @Published var currentTuningFreq: [Float] = []
    
    init() {
        currentTuning = data.tuningDataList["Standard E"] ?? [""]
        print(currentTuning)
        for i in currentTuning {
            if i.contains("♯") {
                
                let index = data.noteNamesWithSharpsList.firstIndex(of: i)!
                currentTuningFreq.append(Float(data.noteFrequenciesList[index]))

            } else if i.contains("♭") {

                let index = data.noteNamesWithFlatsList.firstIndex(of: i)!
                currentTuningFreq.append(Float(data.noteFrequenciesList[index]))
                
            } else {
                
                let index = data.noteNamesWithSharpsList.firstIndex(of: i)!
                currentTuningFreq.append(Float(data.noteFrequenciesList[index]))
                
            }
        }
        print(currentTuningFreq)
    }
    
    func Tuning(currentTuningIndex: Int, frequency: Float) -> String {
        
        let distance =  currentTuningFreq[currentTuningIndex] - frequency
        let absoluteDistance = fabsf(distance)
        
        if absoluteDistance < 0.5 {
            return "Good"
        } else {
            if distance < 0 {
                return "To Low"
            } else if distance > 0 {
                return "To High"
            }
        }
        
        return ""
    }
    
}
