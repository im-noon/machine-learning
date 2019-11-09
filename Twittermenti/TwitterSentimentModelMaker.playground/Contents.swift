import Cocoa
import CreateML

let dataPath = "/Users/Slimn/Workspace/GitHub/Machine-Learning/CreateML/Twittermenti/Data/"

let data = try MLDataTable(contentsOf: URL(fileURLWithPath: dataPath + "twitter-sanders-apple3.csv"))

let (trainingData, testingData) = data.randomSplit(by: 0.85, seed: 5)

let sentimentClassifier = try MLTextClassifier(trainingData: trainingData, textColumn: "text", labelColumn: "class")

let evaluationMetrics = sentimentClassifier.evaluation(on: testingData, textColumn: "text", labelColumn: "class")
//let evaluationMetrics = sentimentClassifier.evaluation(on: testingData)

let accuracy = (1.0 - evaluationMetrics.classificationError) * 100

let metadata = MLModelMetadata(author: "Nopthakorn K.", shortDescription: "A model trained to classifiy sentiment on Tweets", license: "MIT", version: "1.0", additional:[:])

try sentimentClassifier.write(to: URL(fileURLWithPath: dataPath + "TweetSentimentClassifier.mlmodel"), metadata: metadata)

// test
try sentimentClassifier.prediction(from: "Apple is a terrible company!")

try sentimentClassifier.prediction(from: "I just found best restaurant ever, and it's @DuckandWaffle")

try sentimentClassifier.prediction(from: "I think @Google is OK!")
