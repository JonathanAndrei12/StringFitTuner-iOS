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
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var noteTracker: NoteTracker = NoteTracker()
    @StateObject var tuner: Tuner = Tuner()
    
    @State var showDevices: Bool = false
    @State var showSettings: Bool = false
    @State var noteSelected: [Bool] = [true, false, false, false, false, false]
    @State var currentIndexSelected = 0
    @State var tuningStatus: String = "Good"
    @State var statusColor: Color = .green
    
    var body: some View {
        
        NavigationView {
            
            VStack(alignment: .center) {
                
                HStack {
                    HStack(alignment: .bottom, spacing: 0) {
                        Text("\(noteTracker.data.noteNameWithSharps)")
                            .font(.title)
                        Text("\(noteTracker.data.noteOctave)")
                    }
                    
                    Text("/")
                        .font(.title)
                    
                    HStack(alignment: .bottom, spacing: 0) {
                        Text("\(noteTracker.data.noteNameWithFlats)")
                            .font(.title)
                        Text("\(noteTracker.data.noteOctave)")
                    }
                }
                
                Text("Frequency : \(noteTracker.frequencies, specifier: "%0.1f") Hz")
                    .font(.caption)
                
                Text("Distance : \(noteTracker.minDistances, specifier: "%0.1f") Hz")
                    .font(.caption)
                
                Spacer()
                
                Text(tuningStatus)
                    .font(.title)
                    .foregroundColor(statusColor)
                
                Spacer()
                
                ZStack(alignment: .center) {
                    Image("Guitar Neck Icon")
                        .resizable()
                        .frame(width: 250,height: 320)
                    VStack(alignment: .center) {
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
                            }) {
                                ZStack(alignment: .center) {
                                    Circle()
                                        .foregroundColor(.gray)
                                    Text(tuner.currentTuning[2])
                                        .font(.title)
                                        .foregroundColor(noteSelected[2] ?  .green : .white)
                                }
                            }
                            .frame(width: 50,height: 50)
                            
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
                            }) {
                                ZStack(alignment: .center) {
                                    Circle()
                                        .foregroundColor(.gray)
                                    Text(tuner.currentTuning[3])
                                        .font(.title)
                                        .foregroundColor(noteSelected[3] ?  .green : .white)
                                }
                            }
                            .frame(width: 50,height: 50)
                        }
                        .padding(.horizontal, -60)
                        
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
                            }) {
                                ZStack(alignment: .center) {
                                    Circle()
                                        .foregroundColor(.gray)
                                    Text(tuner.currentTuning[1])
                                        .font(.title)
                                        .foregroundColor(noteSelected[1] ?  .green : .white)
                                }
                            }
                            .frame(width: 50,height: 50)
                            
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
                            }) {
                                ZStack(alignment: .center) {
                                    Circle()
                                        .foregroundColor(.gray)
                                    Text(tuner.currentTuning[4])
                                        .font(.title)
                                        .foregroundColor(noteSelected[4] ?  .green : .white)
                                }
                            }
                            .frame(width: 50,height: 50)
                        }
                        .padding(.horizontal, -50)
                        .padding(.vertical, 5)
                        
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
                            }) {
                                ZStack(alignment: .center) {
                                    Circle()
                                        .foregroundColor(.gray)
                                    Text(tuner.currentTuning[0])
                                        .font(.title)
                                        .foregroundColor(noteSelected[0] ?  .green : .white)
                                }
                            }
                            .frame(width: 50,height: 50)
                            
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
                            }) {
                                ZStack(alignment: .center) {
                                    Circle()
                                        .foregroundColor(.gray)
                                    Text(tuner.currentTuning[5])
                                        .font(.title)
                                        .foregroundColor(noteSelected[5] ?  .green : .white)
                                }
                            }
                            .frame(width: 50,height: 50)
                        }
                        .padding(.horizontal, -40)
                    }
                    .padding(.top, -60)
                }
                
            }
            .padding(.horizontal, 70)
            .padding(.vertical, 100)
            
            .navigationBarTitle("Tuner", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                showDevice()
            }){
                Image(systemName: "mic.fill")
            },
            trailing: Button(action: {
                
            }){
                Image(systemName: "gearshape.fill")
            })
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
            .sheet(isPresented: self.$showDevices, content: {ShowDevicesView(noteTracker: self.noteTracker, ShowDevices: self.$showDevices)})
            
        }
        
    }
    
    func showDevice() {
        self.showDevices.toggle()
        print(self.showDevices)
    }
    
}

struct TunerView_Previews: PreviewProvider {
    static var previews: some View {
        TunerView()
    }
}
