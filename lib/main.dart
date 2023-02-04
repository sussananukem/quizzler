import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'quiz_brain.dart';


QuizBrain quizBrain = QuizBrain();

void main() {
  runApp(
    DevicePreview(
      enabled: kDebugMode,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const QuizzlerHome(),
    );
  }
}

class QuizzlerHome extends StatefulWidget {
  const QuizzlerHome({Key? key}) : super(key: key);
  @override
  State<QuizzlerHome> createState() => _QuizzlerHomeState();
}

class _QuizzlerHomeState extends State<QuizzlerHome> {

  List<Widget> myIcons = [];

  int questionNumber = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: const Center(
          child: Text('Quizzler'),
        ),
      ),
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      quizBrain.questionBank[questionNumber].question,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                      ),
                    ),
                  ),
                ),
              ),

              //Buttons
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () {
                      bool correctAnswer = quizBrain.questionBank[questionNumber].answer;
                      setState(() {
                        if (correctAnswer == true) {
                          myIcons.add(
                            const Icon(
                              Icons.check,
                              color: Colors.green,
                            ),
                          );
                        } else {
                          myIcons.add(
                            const Icon(
                              Icons.cancel,
                              color: Colors.red,
                            ),
                          );
                        }
                        questionNumber++;
                      });
                    },
                    child: const Text(
                      'True',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      bool correctAnswer = quizBrain.questionBank[questionNumber].answer;
                      setState(() {
                        if (correctAnswer == false) {
                          myIcons.add(
                            const Icon(
                              Icons.check,
                              color: Colors.green,
                            ),
                          );
                        } else {
                          myIcons.add(
                            const Icon(
                              Icons.cancel,
                              color: Colors.red,
                            ),
                          );
                        }
                        questionNumber++;
                      });
                    },
                    child: const Text(
                      'False',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: myIcons,
              )
            ],
          ),
        ),
      ),
    );
  }
}
