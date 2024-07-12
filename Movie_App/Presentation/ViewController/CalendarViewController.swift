import SwiftUI
import RealmSwift

struct CalendarView: View {
    @State private var currentDate = Date()
    @State private var selectedDate: Date? = Date()
    @State private var isCreateViewPresented = false
    @ObservedObject var viewModel = MyDataViewModel()

    private var currentWeek: [Date] {
        let calendar = Calendar.current
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: currentDate))!
        return (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: startOfWeek) }
    }

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E\nd"
        formatter.locale = Locale(identifier: "ko_KR") // 한글 요일 설정
        return formatter
    }()

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button(action: previousWeek) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                            .font(.system(size: 10))
                    }
                    Text(getMonthString())
                        .font(.system(size: 15))
                    Button(action: nextWeek) {
                        Image(systemName: "chevron.right")
                            .foregroundColor(.black)
                            .font(.system(size: 10))
                    }
                }
                .padding(.top, 20)
                .padding(.horizontal, 20)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(currentWeek, id: \.self) { date in
                            VStack {
                                Text(dateFormatter.string(from: date))
                                    .font(.system(size: 13))
                                    .foregroundColor(isSelected(date) ? .blue : .black)
                                    .frame(width: 40, height: 40) // 일정한 크기 지정
                                    .background(isSelected(date) ? Color.blue.opacity(0.2) : Color.clear)
                                    .clipShape(Circle())
                                    .onTapGesture {
                                        selectedDate = date
                                        currentDate = date
                                    }
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                }

                if let selectedDate = selectedDate {
                    List(viewModel.getTasks(for: selectedDate)) { task in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(task.titleText)
                                    .font(.headline)
                                Text("러닝타임: \(task.timeText)")
                                HStack {
                                    Text("평점: ")
                                    ForEach(0..<task.rating) { _ in
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.yellow)
                                    }
                                }
                                Text("명대사: \(task.famousLineText)")
                            }
                            Spacer()
                            if let imageUrl = task.imageUrl, !imageUrl.isEmpty {
                                URLImage(urlString: imageUrl)
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                } else {
                    Spacer()
                }
            }

            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        isCreateViewPresented.toggle()
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(.black)
                            .padding()
                            .background(Color(UIColor(red: 191/255, green: 255/255, blue: 0/255, alpha: 1.0)))
                            .clipShape(Circle())
                    }
                    Spacer()
                    .sheet(isPresented: $isCreateViewPresented) {
                        CreateView(viewModel: viewModel)
                    }
                }
            }
        }
        .onAppear {
            selectedDate = Date() // 페이지 로드 시 현재 날짜로 포커스
            currentDate = Date()
        }
        .navigationBarHidden(true) // 네비게이션 바 숨기기
    }

    private func getMonthString() -> String {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: currentDate)
        let month = calendar.component(.month, from: currentDate)
        return "\(year)년 \(month)월"
    }

    private func isSelected(_ date: Date) -> Bool {
        if let selectedDate = selectedDate {
            return Calendar.current.isDate(date, inSameDayAs: selectedDate)
        }
        return false
    }

    private func previousWeek() {
        currentDate = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: currentDate) ?? currentDate
    }

    private func nextWeek() {
        currentDate = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: currentDate) ?? currentDate
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
