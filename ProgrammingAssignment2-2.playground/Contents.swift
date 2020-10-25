
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
class TimeAY {

    // UInt maps to NSUInteger typedef from Objective-C Foundation framework
    var _hours: UInt
    var _minutes: UInt
    var _seconds: UInt

    init() {
        _hours = 0
        _minutes = 0
        _seconds = 0
    }

    init(_ hours: UInt, _ minutes: UInt, _ seconds: UInt) {
        _hours = hours
        _minutes = minutes
        _seconds = seconds

        if _seconds > 59 {
            _seconds -= 60
            _minutes += 1
        }

        if _minutes > 59 {
            _minutes -= 60
            _hours += 1
        }

        if _hours > 23 {
            _hours -= 24
        }
    }

    // Swift`s Date maps to Foundation`s NSDate
    init(date: Date) {
        let calendar = Calendar.current // gregorian?

        _hours = UInt(calendar.component(.hour, from: date))
        _minutes = UInt(calendar.component(.minute, from: date))
        _seconds = UInt(calendar.component(.second, from: date))
    }

    func stringify() -> String {
        let isAM = self._hours < 13

        let hours = String(isAM ? _hours : _hours - 12)
        let minutes = _minutes < 10 ? "0\(_minutes)" : String(_minutes)
        let seconds = _seconds < 10 ? "0\(_seconds)" : String(_seconds)

        return String(format: "%@:%@:%@ %@", hours, minutes, seconds, isAM ? "AM" : "PM")
    }

    // computed property, for convenience
    var string: String {
        get { stringify() }
    }

    func plus(_ other: TimeAY) -> TimeAY {
        var hours: UInt = 0
        var minutes: UInt = 0
        var seconds: UInt = 0

        seconds += _seconds + other._seconds
        if seconds > 59 {
            seconds -= 60
            minutes += 1
        }

        minutes += _minutes + other._minutes
        if minutes > 59 {
            minutes -= 60
            hours += 1
        }

        hours += _hours + other._hours
        if hours > 23 {
            hours -= 24
        }

        return TimeAY(hours, minutes, seconds)
    }

    func minus(_ other: TimeAY) -> TimeAY {
        var hours = Int(_hours)
        var minutes = Int(_minutes)
        var seconds = Int(_seconds)

        seconds -= Int(other._seconds)
        if seconds < 0 {
            seconds += 60
            minutes -= 1
        }

        minutes -= Int(other._minutes)
        if minutes < 0 {
            minutes += 60
            hours -= 1
        }

        hours -= Int(other._hours)
        if hours < 0 {
            hours += 24
        }

        return TimeAY(
            UInt(hours),
            UInt(minutes),
            UInt(seconds)
        )
    }

    static func + (left: TimeAY, right: TimeAY) -> TimeAY {
        return left.plus(right)
    }

    static func - (left: TimeAY, right: TimeAY) -> TimeAY {
        return left.minus(right)
    }
}

print()

let time_from_defaults = TimeAY()
print("default initializer: \(time_from_defaults.string)")

let time_from_date = TimeAY(date: Date())
print("initialize with Date object: \(time_from_date.string)")

let time_from_parameters = TimeAY(24, 60, 00)
print("initializer with parameters: \(time_from_parameters.string)")

print()

let time1 = TimeAY(23, 59, 59)
let time2 = TimeAY(12, 00, 01)

let result0 = time1 + time2

print(String(format: "%@ - %@ = %@", time1.string, time2.string, result0.string))

let time3 = TimeAY(00, 00, 00)
let time4 = TimeAY(00, 00, 01)

let result1 = time3 - time4

print(String(format: "%@ - %@ = %@", time3.string, time4.string, result1.string))

print()
