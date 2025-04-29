//
//  SpeechRecognitionManager.swift
//  Ripple
//
//  Created by Ashley Zhang on 20/4/2025.
//

import Foundation
import Speech
import AVFoundation

class SpeechRecognitionManager: ObservableObject {
    // Published properties for UI binding
    @Published var isRecording = false
    @Published var transcribedText = ""
    @Published var isButtonEnabled = false
    @Published var showSubmitButton = false
    
    // Speech recognition properties
    private var audioEngine: AVAudioEngine?
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-AU"))
    
    init() {
        // Request authorisation for speech recognition
        SFSpeechRecognizer.requestAuthorization { authStatus in
            DispatchQueue.main.async {
                switch authStatus {
                case .authorized:
                    self.isButtonEnabled = true
                default:
                    self.isButtonEnabled = false
                }
            }
        }
    }
    
    func toggleRecording() {
        if isRecording {
            stopRecording()
        } else {
            startRecording()
        }
    }
    
    func startRecording() {
        // Initialise recording components if needed
        if audioEngine == nil {
            audioEngine = AVAudioEngine()
        }
        
        // Reset previous task if any
        if let recognitionTask = recognitionTask {
            recognitionTask.cancel()
            self.recognitionTask = nil
        }
        
        // Prepare the session
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("Failed to set up audio session: \(error.localizedDescription)")
            return
        }
        
        // Set up recognition request
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        guard let recognitionRequest = recognitionRequest,
              let audioEngine = audioEngine,
              speechRecognizer?.isAvailable == true else {
            print("Recognition request or audio engine setup failed")
            return
        }
        
        // Audio microphone input
        let inputNode = audioEngine.inputNode
        
        // Configure request for real-time transcription
        recognitionRequest.shouldReportPartialResults = true
        
        // Start recognition task
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest) { [weak self] result, error in
            guard let self = self else { return }
            
            if let result = result {
                // Update the transcribed text with the latest result
                DispatchQueue.main.async {
                    self.transcribedText = result.bestTranscription.formattedString
                }
            }
            
            if error != nil || (result?.isFinal ?? false) {
                // Stop engine when there's an error or final result
                audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
            }
        }
        
        // Configure audio input
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            recognitionRequest.append(buffer)
        }
        
        // Start audio engine
        audioEngine.prepare()
        do {
            try audioEngine.start()
            DispatchQueue.main.async {
                self.isRecording = true
                self.showSubmitButton = false
            }
        } catch {
            print("Audio engine failed to start: \(error.localizedDescription)")
        }
    }
    
    func stopRecording() {
        // Stop the audio engine and recognition task
        audioEngine?.stop()
        recognitionRequest?.endAudio()
        
        DispatchQueue.main.async {
            self.isRecording = false
            self.showSubmitButton = true
        }
        
        // Clean up audio session
        do {
            try AVAudioSession.sharedInstance().setActive(false)
        } catch {
            print("Failed to deactivate audio session: \(error.localizedDescription)")
        }
    }
    
    // Clean up resources when no longer needed
    func cleanup() {
        audioEngine?.stop()
        audioEngine?.inputNode.removeTap(onBus: 0)
        recognitionTask?.cancel()
        
        audioEngine = nil
        recognitionRequest = nil
        recognitionTask = nil
    }
}
