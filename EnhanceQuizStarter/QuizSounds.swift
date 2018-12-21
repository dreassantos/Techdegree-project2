import AudioToolbox
class QuizSounds {
    var gameSound: SystemSoundID = 0
    init(soundName: String, soundType: String) {
        let path = Bundle.main.path(forResource: soundName , ofType: soundType)
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSound)
    }
    
    func play() {
        AudioServicesPlaySystemSound(gameSound)
    }
}
//    func loadGameStartSound(soundName: String) {
//
//    }
    
//    let testSound = gameSound(SoundName: "Correct")
//    testSound.play
