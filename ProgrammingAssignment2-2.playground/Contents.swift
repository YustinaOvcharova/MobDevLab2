
import Foundation

// Part 1

// Given string with format "Student1 - Group1; Student2 - Group2; ..."

let studentsStr = "Бортнік Василь - ІВ-72; Чередніченко Владислав - ІВ-73; Гуменюк Олександр - ІВ-71; Корнійчук Ольга - ІВ-71; Киба Олег - ІВ-72; Капінус Артем - ІВ-73; Овчарова Юстіна - ІВ-72; Науменко Павло - ІВ-73; Трудов Антон - ІВ-71; Музика Олександр - ІВ-71; Давиденко Костянтин - ІВ-73; Андрющенко Данило - ІВ-71; Тимко Андрій - ІВ-72; Феофанов Іван - ІВ-71; Гончар Юрій - ІВ-73"

// Task 1
// Create dictionary:
// - key is a group name
// - value is sorted array with students

var studentsGroups: [String: [String]] = [:]

// Your code begins

for record in studentsStr.components(separatedBy: "; ") {
    struct Pair {
        let name: String
        let group: String

        init(_ pairOfStrings: [String]) {
            name = pairOfStrings[0]
            group = pairOfStrings[1]
        }
    }

    let recordPair = Pair(record.components(separatedBy: " - "))

    if studentsGroups[recordPair.group] == nil {
        studentsGroups[recordPair.group] = [recordPair.name]
    } else {
        studentsGroups[recordPair.group]!.append(recordPair.name)
    }
}

for group in studentsGroups.keys {
    studentsGroups[group]!.sort()
}

// Your code ends

print(studentsGroups)
print()

// Given array with expected max points

let points: [Int] = [5, 8, 12, 12, 12, 12, 12, 12, 15]

// Task 2
// Create dictionary:
// - key is a group name
// - value is dictionary:
//   - key is student
//   - value is array with points (fill it with random values, use function `randomValue(maxValue: Int) -> Int` )

func randomValue(maxValue: Int) -> Int {
    switch(arc4random_uniform(6)) {
    case 1:
        return Int(ceil(Float(maxValue) * 0.7))
    case 2:
        return Int(ceil(Float(maxValue) * 0.9))
    case 3, 4, 5:
        return maxValue
    default:
        return 0
    }
}

var studentPoints: [String: [String: [Int]]] = [:]

// Your code begins

for group in studentsGroups.keys {
    studentPoints[group] = [:]

    for name in studentsGroups[group]! {
        studentPoints[group]![name] = []

        for point in points {
            studentPoints[group]![name]!.append(randomValue(maxValue: point))
        }
    }
}


// Your code ends

print(studentPoints)
print()

// Task 3
// Create dictionary:
// - key is a group name
// - value is dictionary:
//   - key is student
//   - value is sum of student's points

var sumPoints: [String: [String: Int]] = [:]

// Your code begins

for group in studentPoints.keys {
    sumPoints[group] = [:]

    for name in studentPoints[group]!.keys {
        sumPoints[group]![name] = studentPoints[group]![name]!.reduce(0, +)
    }
}

// Your code ends

print(sumPoints)
print()

// Task 4
// Create dictionary:
// - key is group name
// - value is average of all students points

var groupAvg: [String: Float] = [:]

// Your code begins

for group in sumPoints.keys {
    let sum = Float(sumPoints[group]!.values.reduce(0, +))
    let count = Float(sumPoints[group]!.count)

    groupAvg[group] = sum / count
}

// Your code ends

print(groupAvg)
print()

// Task 5
// Create dictionary:
// - key is group name
// - value is array of students that have >= 60 points

var passedPerGroup: [String: [String]] = [:]

// Your code begins

for group in sumPoints.keys {
    passedPerGroup[group] = [String](sumPoints[group]!.filter({
        $0.value >= 60
    }).keys)
}

// Your code ends

print(passedPerGroup)

// Example of output. Your results will differ because random is used to fill points.
//
//["ІВ-73": ["Гончар Юрій", "Давиденко Костянтин", "Капінус Артем", "Науменко Павло", "Чередніченко Владислав"], "ІВ-72": ["Бортнік Василь", "Киба Олег", "Овчарова Юстіна", "Тимко Андрій"], "ІВ-71": ["Андрющенко Данило", "Гуменюк Олександр", "Корнійчук Ольга", "Музика Олександр", "Трудов Антон", "Феофанов Іван"]]
//
//["ІВ-73": ["Давиденко Костянтин": [5, 8, 9, 12, 11, 12, 0, 0, 14], "Капінус Артем": [5, 8, 12, 12, 0, 12, 12, 12, 11], "Науменко Павло": [4, 8, 0, 12, 12, 11, 12, 12, 15], "Чередніченко Владислав": [5, 8, 12, 12, 11, 12, 12, 12, 15], "Гончар Юрій": [5, 6, 0, 12, 0, 11, 12, 11, 14]], "ІВ-71": ["Корнійчук Ольга": [0, 0, 12, 9, 11, 11, 9, 12, 15], "Музика Олександр": [5, 8, 12, 0, 11, 12, 0, 9, 15], "Гуменюк Олександр": [5, 8, 12, 9, 12, 12, 11, 12, 15], "Трудов Антон": [5, 0, 0, 11, 11, 0, 12, 12, 15], "Андрющенко Данило": [5, 6, 0, 12, 12, 12, 0, 9, 15], "Феофанов Іван": [5, 8, 12, 9, 12, 9, 11, 12, 14]], "ІВ-72": ["Киба Олег": [5, 8, 12, 12, 11, 12, 0, 0, 11], "Овчарова Юстіна": [5, 8, 12, 0, 11, 12, 12, 12, 15], "Бортнік Василь": [4, 8, 12, 12, 0, 12, 9, 12, 15], "Тимко Андрій": [0, 8, 11, 0, 12, 12, 9, 12, 15]]]
//
//["ІВ-72": ["Бортнік Василь": 84, "Тимко Андрій": 79, "Овчарова Юстіна": 87, "Киба Олег": 71], "ІВ-73": ["Капінус Артем": 84, "Науменко Павло": 86, "Чередніченко Владислав": 99, "Гончар Юрій": 71, "Давиденко Костянтин": 71], "ІВ-71": ["Корнійчук Ольга": 79, "Трудов Антон": 66, "Андрющенко Данило": 71, "Гуменюк Олександр": 96, "Феофанов Іван": 92, "Музика Олександр": 72]]
//
//["ІВ-71": 79.333336, "ІВ-72": 80.25, "ІВ-73": 82.2]
//
//["ІВ-72": ["Бортнік Василь", "Киба Олег", "Овчарова Юстіна", "Тимко Андрій"], "ІВ-73": ["Давиденко Костянтин", "Капінус Артем", "Чередніченко Владислав", "Гончар Юрій", "Науменко Павло"], "ІВ-71": ["Музика Олександр", "Трудов Антон", "Гуменюк Олександр", "Феофанов Іван", "Андрющенко Данило", "Корнійчук Ольга"]]

enum MyErrors: Error {
    case wrongHours
    case wrongMinutes
    case wrongSeconds
}

class TimeYO{
    var hours, minutes, seconds : UInt

    init(){
        hours = 0;
        minutes = 0;
        seconds = 0;
    }
    init(hours : UInt = 0, minutes : UInt = 0, seconds : UInt = 0) throws{
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds

        if (hours > 23 || hours < 0){
            throw MyErrors.wrongHours
        }
        if (minutes > 59 || minutes < 0){
            throw MyErrors.wrongMinutes
        }
        if (seconds > 59 || seconds < 0){
            throw MyErrors.wrongSeconds
        }
    }
    init(date : Date){
        let date = Date()
        let calendar = Calendar.current

        self.hours = UInt(calendar.component(.hour, from: date))
        self.minutes = UInt(calendar.component(.minute, from: date))
        self.seconds = UInt(calendar.component(.second, from: date))
    }

    func getTimeInfoOrdinary() -> String {
        return ("TIME\t\(hours):\(minutes):\(seconds)")
    }
    func getTimeInfo() -> String {
        if (hours == 0){
            return ("12:\(minutes):\(seconds) AM")
        }
        else if (hours == 12) {
            return ("12:\(minutes):\(seconds) PM")
        }
        else if (hours < 12) {
            return ("\(hours):\(minutes):\(seconds) AM")
        }
        else {
            return ("\(hours - 12):\(minutes):\(seconds) PM")
        }
    }

    func getSum (time : TimeYO) -> TimeYO? {
        self.hours += time.hours
        self.minutes += time.minutes
        self.seconds += time.seconds

        if (self.seconds > 59) {
            self.minutes += 1
            self.seconds -= 60
        }
        if (self.minutes > 59) {
            self.hours += 1
            self.minutes -= 60
        }
        if (self.hours > 23) {
            self.hours -= 24
        }

        return try! TimeYO(hours: self.hours, minutes: self.minutes, seconds: self.seconds)
    }
    func getDif(time : TimeYO) -> TimeYO? {
        self.hours -= time.hours
        self.minutes -= time.minutes
        self.seconds -= time.seconds

        if (self.seconds < 0) {
            self.seconds += 60
            self.minutes -= 1
        }
        if (self.minutes < 0) {
            self.minutes += 60
            self.hours -= 1
        }
        if (self.hours < 0) {
            self.hours += 24
        }

        return try! TimeYO(hours: self.hours, minutes: self.minutes, seconds: self.seconds)
    }

    func getSumOfTwoTimes (time1 : TimeYO, time2 : TimeYO) -> TimeYO? {
        var hoursSum = time1.hours + time2.hours
        var minutesSum = time1.minutes + time2.minutes
        var secondsSum = time1.seconds + time2.seconds

        if (secondsSum > 59) {
            minutesSum += 1
            secondsSum -= 60
        }
        if (minutesSum > 59) {
            hoursSum += 1
            minutesSum -= 60
        }
        if (hoursSum > 23) {
            hoursSum -= 24
        }

        return try! TimeYO(hours: hoursSum, minutes: minutesSum, seconds: secondsSum)
    }
    func getDifOfTwoTimes(time1 : TimeYO, time2 : TimeYO) -> TimeYO? {
        var hoursDif = time1.hours - time2.hours
        var minutesDif = time1.minutes - time2.minutes
        var secondsDif = time1.seconds - time2.seconds

        if (secondsDif < 0) {
            secondsDif += 60
            minutesDif -= 1
        }
        if (minutesDif < 0) {
            minutesDif += 60
            hoursDif -= 1
        }
        if (hoursDif < 0) {
            hoursDif += 24
        }

        return try! TimeYO(hours: hoursDif, minutes: minutesDif, seconds: secondsDif)
    }
}

var time0 = TimeYO()
var time1 = try! TimeYO(hours: 3, minutes: 30, seconds: 45)
var time2 = try! TimeYO(hours: 15, minutes: 45, seconds: 55)

let date = Date()
var timeFromDate = TimeYO(date: date)



print(time0.getTimeInfo())
print(time1.getTimeInfo())
print(time2.getTimeInfo())
print(timeFromDate.getTimeInfo())

print()
print(time1.getTimeInfoOrdinary())
print(time2.getTimeInfoOrdinary())
var sum = time1.getSum(time: time2)
print("Time1 + Time2 = " + sum!.getTimeInfoOrdinary() + "\n")
var sumOfTwoTimes = TimeYO().getSumOfTwoTimes(time1: time2, time2: timeFromDate)
print("Time1: " + time2.getTimeInfoOrdinary())
print("Time2: " + timeFromDate.getTimeInfoOrdinary())
print("Time1 + Time2: " + sumOfTwoTimes!.getTimeInfoOrdinary())

var difOfTwoTimes = TimeYO().getDifOfTwoTimes(time1: time1, time2: time0)
print("\nTime1: " + time1.getTimeInfoOrdinary())
print("Time2: " + time0.getTimeInfoOrdinary())
print("Time1 - Time2: " + difOfTwoTimes!.getTimeInfoOrdinary())

