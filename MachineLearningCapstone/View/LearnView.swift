//
//  LearnView.swift
//  MachineLearningCapstone
//
//  Created by Noah Brauner on 3/2/21.
//

import SwiftUI

struct LearnPageModel {
    var title: String
    var text: String
}

struct LearnView: View {
    let models = [
        LearnPageModel(
            title: "What is Machine Learning?",
            text: """
                            Machine learning is a type of artificial intelligence, where a machine trains itself using different types of data such as images, audio clips, and numerical information. The machine "learns" by finding patterns in the data. For example, a machine could learn to recognize dogs by finding a pattern between pictures and each dog breed. Once the pattern is established, it can classify a future dog correctly. As the machine trains with more images of each dog breed, it can more accurately predict a given dog’s breed.
                            """
        ),
        LearnPageModel(
            title: "How Will It Be Used in Medicine?",
            text: "Machine Learning can be used in medicine to fully diagnose patients or help doctors with their diagnoses. Machine learning will be first used in fields of medicine such as ophthalmology, radiology, and pathology due to it being particularly accurate at interpreting images and x-rays. Machine learning is an emerging technology that, when used correctly, can benefit patients and doctors."
        ),
        LearnPageModel(
            title: "What is Holding ML Back from Being More Widely Employed in Healthcare?",
            text: "Many doctors and patients still do not trust machine learning in healthcare. Some doctors are opposed to machine learning as they fear for their jobs, while some patients prefer to have human connection in the doctor’s office. One memorable quote by a patient from my paper was, “You can’t write an algorithm to feel for somebody.” This brings the question, should you trust machine learning?"
        ),
        LearnPageModel(
            title: "Should I trust Machine Learning with My Health?",
            text: "Machine learning is still an emerging technology, but by the time it is incorporated into healthcare, you may have to decide between having a human doctor or machine diagnose your condition. If you want a more accurate diagnosis and are comfortable trusting a computer with your health (like me), then you may opt for machine learning for treatment. But if you need human connection and trust, then you may still want a human doctor for your diagnosis."
        )
    ]
    
    @State private var currentPage = 0
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1))
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                TabView(selection: $currentPage) {
                    ForEach (0..<4, id: \.self) { index in
                        LearnTextView(title: models[index].title, text: models[index].text)
                            .tag(index)
                            .padding()
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .offset(y: -100)
                
                // NEXT button
                HStack {
                    Button(action: {
                        withAnimation (.easeInOut(duration: 1.0)) {
                            currentPage = currentPage == 3 ? 0 : currentPage + 1
                        }
                    }) {
                        Image(systemName: currentPage != 3 ? "arrow.right" : "arrow.backward")
                            .font(.largeTitle)
                            .foregroundColor(Color(#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)))
                            .padding()
                            .background(Circle().fill(Color.white))
                    }
                }
                .padding()
                .offset(y: -100)
            }
        }
    }
}

struct LearnTextView: View {
    var title: String
    var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            Text(title)
                .fontWeight(.semibold)
                .font(.title)
                .padding(.horizontal)
            
            Text(text)
                .fontWeight(.semibold)
                .font(.body)
                .padding(.horizontal)
            
            Spacer()
        }
        .padding(.top, 200)
    }
}

class BookColor: ObservableObject {
    @Published var isOrange = true
}
