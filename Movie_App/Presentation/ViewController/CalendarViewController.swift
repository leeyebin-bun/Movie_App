import SwiftUI

struct CalendarView: View {
    @State private var currentDate = Date()
    @State private var selectedDate: Date?
    
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
                                .foregroundColor(date == selectedDate ? .blue : .black)
                                .frame(width: 40, height: 40) // 일정한 크기 지정
                                .background(date == selectedDate ? Color.blue.opacity(0.2) : Color.clear)
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
            
            Spacer()
        }
    }
    
    private func getMonthString() -> String {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: currentDate)
        let month = calendar.component(.month, from: currentDate)
        return "\(year)년 \(month)월"
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
