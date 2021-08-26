//
//  TunerView.swift
//  MobGuitarTuner
//
//  Created by Jonathan Andrei on 24/08/21.
//
import AudioKit
import AudioKitEX
import AudioToolbox
import SoundpipeAudioKit
import AVFoundation
import SwiftUI

struct TunerView: View {
    
    @StateObject var noteTracker: NoteTracker = NoteTracker()
    @StateObject var tuner: Tuner = Tuner()
    
    @State var showDevices: Bool = false
    @State var noteSelected: [Bool] = [true, false, false, false, false, false]
    @State var currentIndexSelected = 0
    @State var tuningStatus: String = "Good"
    @State var statusColor: Color = .green
    
    var body: some View {
        
        NavigationView {
            
            VStack(alignment: .center) {
                
                Text("Frequency : \(noteTracker.frequencies, specifier: "%0.1f") Hz")
                
                Text("Distance : \(noteTracker.minDistances, specifier: "%0.1f") Hz")
                
                Text("Note : \(noteTracker.data.noteNameWithSharps) / \(noteTracker.data.noteNameWithFlats)")
                
                Button("\(noteTracker.engine.inputDevice?.deviceID ?? "Choose Mic")") {
                    self.showDevices = true
                }
                
                Spacer()
                
                Text(tuningStatus)
                    .font(.title)
                    .foregroundColor(statusColor)
                
                Spacer()
                
                VStack(spacing: 0) {
                    
                    HStack(alignment: .center) {
                        
                        Button(action: {
                            currentIndexSelected = 2
                            for i in 0 ..< noteSelected.count {
                                if i != currentIndexSelected {
                                    noteSelected[i] = false
                                } else {
                                    noteSelected[i] = true
                                }
                            }
                        }){
                            ZStack {
                                Image("Guitar Dryer Icon")
                                    .resizable()
                                    .frame(width: 70, height: 100)
                                    .rotationEffect(.degrees(-90.0))
                                
                                Text(tuner.currentTuning[2])
                                    .font(.largeTitle)
                                    .foregroundColor(noteSelected[2] ?  .green : .white)
                                    .padding(.trailing, 15)
                            }
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            currentIndexSelected = 3
                            for i in 0 ..< noteSelected.count {
                                if i != currentIndexSelected {
                                    noteSelected[i] = false
                                } else {
                                    noteSelected[i] = true
                                }
                            }
                        }){
                            ZStack {
                                Image("Guitar Dryer Icon")
                                    .resizable()
                                    .frame(width: 70, height: 100)
                                    .rotationEffect(.degrees(90.0))
                                
                                Text(tuner.currentTuning[3])
                                    .font(.largeTitle)
                                    .foregroundColor(noteSelected[3] ?  .green : .white)
                                    .padding(.leading, 15)
                            }
                        }
                        
                    }
                    
                    HStack(alignment: .center) {
                        
                        Button(action: {
                            currentIndexSelected = 1
                            for i in 0 ..< noteSelected.count {
                                if i != currentIndexSelected {
                                    noteSelected[i] = false
                                } else {
                                    noteSelected[i] = true
                                }
                            }
                        }){
                            ZStack {
                                Image("Guitar Dryer Icon")
                                    .resizable()
                                    .frame(width: 70, height: 100)
                                    .rotationEffect(.degrees(-90.0))
                                
                                Text(tuner.currentTuning[1])
                                    .font(.largeTitle)
                                    .foregroundColor(noteSelected[1] ?  .green : .white)
                                    .padding(.trailing, 15)
                            }
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            currentIndexSelected = 4
                            for i in 0 ..< noteSelected.count {
                                if i != currentIndexSelected {
                                    noteSelected[i] = false
                                } else {
                                    noteSelected[i] = true
                                }
                            }
                        }){
                            ZStack {
                                Image("Guitar Dryer Icon")
                                    .resizable()
                                    .frame(width: 70, height: 100)
                                    .rotationEffect(.degrees(90.0))
                                
                                Text(tuner.currentTuning[4])
                                    .font(.largeTitle)
                                    .foregroundColor(noteSelected[4] ?  .green : .white)
                                    .padding(.leading, 15)
                            }
                        }
                        
                    }
                    
                    HStack(alignment: .center) {
                        
                        Button(action: {
                            currentIndexSelected = 0
                            for i in 0 ..< noteSelected.count {
                                if i != currentIndexSelected {
                                    noteSelected[i] = false
                                } else {
                                    noteSelected[i] = true
                                }
                            }
                        }){
                            ZStack {
                                Image("Guitar Dryer Icon")
                                    .resizable()
                                    .frame(width: 70, height: 100)
                                    .rotationEffect(.degrees(-90.0))
                                    
                                
                                Text(tuner.currentTuning[0])
                                    .font(.largeTitle)
                                    .foregroundColor(noteSelected[0] ?  .green : .white)
                                    .padding(.trailing, 15)
                            }
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            currentIndexSelected = 5
                            for i in 0 ..< noteSelected.count {
                                if i != currentIndexSelected {
                                    noteSelected[i] = false
                                } else {
                                    noteSelected[i] = true
                                }
                            }
                        }){
                            ZStack {
                                Image("Guitar Dryer Icon")
                                    .resizable()
                                    .frame(width: 70, height: 100)
                                    .rotationEffect(.degrees(90.0))
                                
                                Text(tuner.currentTuning[5])
                                    .font(.largeTitle)
                                    .foregroundColor(noteSelected[5] ?  .green : .white)
                                    .padding(.leading, 15)
                            }
                        }
                        
                    }
                    
                }
                
            }
            .padding(.horizontal, 70)
            .padding(.vertical, 100)
            
            .navigationBarTitle("Tuner", displayMode: .inline)
            .onAppear() {
                self.noteTracker.start()
            }
            .onDisappear() {
                self.noteTracker.stop()
            }
            .onChange(of: noteTracker.frequencies, perform: { value in
                self.tuningStatus = tuner.Tuning(currentTuningIndex: currentIndexSelected, frequency: value)
                if tuningStatus == "Good" {
                    statusColor = .green
                } else {
                    statusColor = .red
                }
            })
            .sheet(isPresented: $showDevices, content: {ShowDevicesView(noteTracker: self.noteTracker, ShowDevices: self.$showDevices)})
            
        }
        
    }
}

struct TunerView_Previews: PreviewProvider {
    static var previews: some View {
        TunerView()
    }
}
