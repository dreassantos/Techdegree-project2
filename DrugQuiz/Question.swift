/// Creates the questions
struct QuestionProvider {
    let question: String
    let answerOptions: [String]
    let correctAnswer: Int
}

/// Holds all the questions in the quiz
struct Quiz {
    let questions: [QuestionProvider] = [
        QuestionProvider ( question: "Norvasc",
                          answerOptions: ["Amlodipine","Montelukast","Prednisone","Escitalopram"],
                          correctAnswer: 0),
        QuestionProvider (question: "Xanax",
                          answerOptions:["Amlodipine","Montelukast","Alprazolam","Escitalopram"],
                          correctAnswer: 2),
        QuestionProvider (question: "Glucophage",
                          answerOptions:["Ibuprofen","Citalopram","Albuterol","Metformin"],
                          correctAnswer: 3),
        QuestionProvider (question: "Lipitor",
                          answerOptions:["Ibuprofen","Atorvastatin","Cephalexin","Cyclobenzaprine"],
                          correctAnswer: 1),
        QuestionProvider (question: "Prilosec",
                          answerOptions:["Ibuprofen","Omeprazole","Cephalexin","Cyclobenzaprine"],
                          correctAnswer: 1),
        QuestionProvider (question: "Augmentin",
                          answerOptions:["Clonazepam","Lorazepam","Cephalexin","Amoxicillin + Clavulanate"],
                          correctAnswer: 3),
        QuestionProvider (question: "Tenormin",
                          answerOptions:["Atenolol","Xanax", "Glucophage", "Lipitor"],
                          correctAnswer: 0),
        QuestionProvider (question: "Lasix",
                          answerOptions:["Sertraline","Lipitor", "Furosemide", "metoprolol"],
                          correctAnswer: 2),
        QuestionProvider (question: "Lopressor",
                          answerOptions:["metoprolol","Montelukast","Prednisone","Escitalopram"],
                          correctAnswer: 0),
        QuestionProvider (question: "Zoloft",
                          answerOptions:["Alprazolam", "Metformin", "Atorvastatin","Sertraline"],
                          correctAnswer: 3)]
}
