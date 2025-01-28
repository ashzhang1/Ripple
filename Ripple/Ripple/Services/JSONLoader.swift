//
//  JSONLoader.swift
//  Ripple
//
//  Created by Ashley Zhang on 28/12/2024.
//

import CoreData
let hasLoadedDataKey = "hasLoadedSampleData"

func loadSampleDataIfNeeded(context: NSManagedObjectContext) {
    let userDefaults = UserDefaults.standard
    
    print("start")
    
    
    // Check if data has already been loaded
//    if userDefaults.bool(forKey: hasLoadedDataKey) {
//        return
//    }

    
    // Load step data
    if let stepData: StepDataResponse = try? loadJSON(filename: "stepData") {
        stepData.steps.forEach { item in
            let step = StepData(context: context)
            step.id = item.id
            step.date = item.date
            step.stepCount = Int64(item.stepCount)
            step.wearTime = item.wearTime
        }
    }
    
    // Load activity data
    if let activityData: ActivityDataResponse = try? loadJSON(filename: "activityData") {
        activityData.activities.forEach { item in
            let activity = ActivityData(context: context)
            activity.id = item.id
            activity.date = item.date
            activity.activityType = item.activityType
        }
    }
    
    
    // Load emotion data
    if let emotionData: EmotionDataResponse = try? loadJSON(filename: "emotionData") {
        emotionData.emotions.forEach { item in
            let emotion = EmotionData(context: context)
            emotion.id = item.id
            emotion.date = item.date
            emotion.emotionType = item.emotionType
        }
    }
    
    
    
    // Load questions
    if let questionData: QuestionResponse = try? loadJSON(filename: "questions") {
        questionData.questions.forEach { item in
            let question = Question(context: context)
            question.id = item.id
            question.questionText = item.questionText
        }
    }
    
    // Load reflections
    if let reflectionData: ReflectionResponse = try? loadJSON(filename: "reflections") {
        reflectionData.reflections.forEach { item in
            let reflection = ReflectionData(context: context)
            reflection.id = item.id
            reflection.date = item.date
            reflection.activities = item.activities
            reflection.emotions = item.emotions
            reflection.response = item.response
            
            // Link to question if it exists
            let questionFetch: NSFetchRequest<Question> = Question.fetchRequest()
            questionFetch.predicate = NSPredicate(format: "id == %@", item.questionId as CVarArg)
            if let question = try? context.fetch(questionFetch).first {
                reflection.question = question
            }
        }
    }
    
    // Save context
    do {
        try context.save()
        userDefaults.set(true, forKey: hasLoadedDataKey)
    } catch {
        print("Failed to save sample data: \(error)")
    }
}

// Helper function to load JSON
private func loadJSON<T: Decodable>(filename: String) throws -> T {
    print("🔍 Starting JSON load process...")
    print("📁 Looking for file: \(filename)")
    
    // Check if file exists and print available resources
    if let urls = Bundle.main.urls(forResourcesWithExtension: "json", subdirectory: "Preview Content") {
        print("📑 Available JSON files in Preview Content:")
        urls.forEach { print($0) }
    } else {
        print("❌ No JSON files found in Preview Content directory")
    }
    
    // Try to get the file URL
    guard let file = Bundle.main.url(forResource: filename,
                                   withExtension: "json") else {
        print("❌ Could not find file: \(filename).json")
        print("📍 Current Bundle path: \(Bundle.main.bundlePath)")
        throw URLError(.fileDoesNotExist)
    }
    
    print("✅ Found file at: \(file)")
    
    do {
        let data = try Data(contentsOf: file)
        print("📦 Successfully loaded data, size: \(data.count) bytes")
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        let decoded = try decoder.decode(T.self, from: data)
        print("✅ Successfully decoded JSON data")
        return decoded
        
    } catch let DecodingError.dataCorrupted(context) {
        print("❌ Data corrupted: \(context.debugDescription)")
        throw DecodingError.dataCorrupted(context)
    } catch let DecodingError.keyNotFound(key, context) {
        print("❌ Key '\(key)' not found: \(context.debugDescription)")
        throw DecodingError.keyNotFound(key, context)
    } catch let DecodingError.valueNotFound(value, context) {
        print("❌ Value '\(value)' not found: \(context.debugDescription)")
        throw DecodingError.valueNotFound(value, context)
    } catch let DecodingError.typeMismatch(type, context) {
        print("❌ Type '\(type)' mismatch: \(context.debugDescription)")
        throw DecodingError.typeMismatch(type, context)
    } catch {
        print("❌ Unknown error: \(error)")
        throw error
    }
}

func resetSampleDataFlag() {
    UserDefaults.standard.removeObject(forKey: hasLoadedDataKey)
}

