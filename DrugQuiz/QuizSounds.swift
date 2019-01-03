import AudioToolbox

struct QuizSounds {
    var idNumber: SystemSoundID // A system sound object, identified with a sound file you want to play
    var soundName: String
    var soundType: String
    
   func loadSound (idNumber: inout SystemSoundID, soundName: String, soundType: String ) {
        let path = Bundle.main.path(forResource: soundName , ofType: soundType)
        let soundUrl = URL(fileURLWithPath: path!) //The URL of the audio file to play.
        // Creates a system sound object.
    AudioServicesCreateSystemSoundID(soundUrl as CFURL, &idNumber) // outSystemSoundID - &idNumber
                                                                   // On output, a system sound object associated with the specified audio file.
    }
    
    func play(idNumber: SystemSoundID) {
    AudioServicesPlaySystemSound(idNumber) // Plays a system sound object.
    }
}
var startSound = QuizSounds(idNumber: 0, soundName: "GameSound" , soundType: "wav")
var correctSound = QuizSounds(idNumber: 1, soundName: "correct" , soundType: "wav")
var wrongSound = QuizSounds (idNumber: 2, soundName: "wrong" , soundType: "wav")

