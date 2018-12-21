
struct QuestionProvider {
    let question: String
    let answerOptions:[String]
    let correctAnswer: Int
}

let q1 = QuestionProvider (question: "Norvasc",
                        answerOptions: ["Amlodipine","Montelukast","Prednisone","Escitalopram"],
                        correctAnswer: 0)
let q2 = QuestionProvider (question: "Xanax",
                        answerOptions:["Amlodipine","Montelukast","Alprazolam","Escitalopram"],
                        correctAnswer: 2)
let q3 = QuestionProvider (question: "Glucophage",
                        answerOptions:["Ibuprofen","Citalopram","Albuterol","Metformin"],
                        correctAnswer: 3)
let q4 = QuestionProvider (question: "Lipitor",
                        answerOptions:["Ibuprofen","Atorvastatin","Cephalexin","Cyclobenzaprine"],
                        correctAnswer: 1)
let q5 = QuestionProvider (question: "Prilosec",
                        answerOptions:["Ibuprofen","Omeprazole","Cephalexin","Cyclobenzaprine"],
                        correctAnswer: 1)
let q6 = QuestionProvider (question: "Augmentin",
                        answerOptions:["Clonazepam","Lorazepam","Cephalexin","Amoxicillin + Clavulanate"],
                        correctAnswer: 3)
let q7 = QuestionProvider (question: "Tenormin",
                          answerOptions:["Atenolol","Xanax", "Glucophage", "Lipitor"],
                          correctAnswer: 0)
let q8 = QuestionProvider (question: "Lasix",
                           answerOptions:["Sertraline","Lipitor", "Furosemide", "metoprolol"],
                           correctAnswer: 2)
let q9 = QuestionProvider (question: "Lopressor",
                          answerOptions:["metoprolol","Montelukast","Prednisone","Escitalopram"],
                          correctAnswer: 0)
let q10 = QuestionProvider (question: "Zoloft",
                          answerOptions:["Alprazolam", "Metformin", "Atorvastatin","Sertraline"],
                          correctAnswer: 3)

struct Quiz {
    var questions: [QuestionProvider] = [q1,q2,q3,q4,q5,q6,q7,q8,q9,q10]
}






/*
 let q = QuestionProvider (question: "",
 answerOptions:["","","",""],
 correctAnswer: )
 */
//let questions:[String] = ["Norvasc", "Xanax", "Glucophage", "Lipitor","Prilosec", "Augmentin", "Tenormin", "Lasix", "Lopressor", "Zoloft"]
//  let answers:[String] = ["Amlodipine", "Alprazolam", "Metformin", "Atorvastatin","Omeprazole","Amoxicillin + Clavulanate", "Atenolol", "Furosemide", "metoprolol", "Sertraline"]
// let possibleAnswers:[String] = ["Montelukast","Prednisone","Escitalopram","Ibuprofen","Citalopram","Albuterol","Fluoxetine","Gabapentin","Warfarin","Tramadol","Clonazepam","Lorazepam","Cephalexin","Cyclobenzaprine","Ciprofloxacin","Fluticasone","Triamterene","Pravastatin","Rosuvastatin"]

//let q1:[String] = ["Norvasc", "Amlodipine"]
//let q2:[String] = ["Xanax ", "Alprazolam"]
//let q3:[String] = ["Glucophage", "Metformin"]
//let q4:[String] = ["Lipitor",  "Atorvastatin"]
//let q5:[String] = ["Prilosec", "Omeprazole"]
//let q6:[String] = ["Augmentin", "Amoxicillin + Clavulanate"]
//let q7:[String] = ["Tenormin", "Atenolol"]
//let q8:[String] = ["Lasix", "Furosemide"]
//let q9:[String] = ["Lopressor", "metoprolol"]
//let q10:[String] = ["Zoloft", "Sertraline"]
//let q4 = Question(drugBrandName: "", optA: " ", optionB: " ", optionC: " ", optD: " ", answer: " ")
//    func questionCollection(){
//        let questions:[[String]] = [q1,q2,q3,q4,q5,q6,q7,q8,q9,q10]
//    }
