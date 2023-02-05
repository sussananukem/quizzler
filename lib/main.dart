import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quiz_brain.dart';

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
  QuizBrain quizBrain = QuizBrain();
  List<Widget> myIcons = [];

  void checkAnswer(bool userAnswer) {
    bool correctAnswer = quizBrain.getAnswer();
    setState(() {
      if (quizBrain.isFinished() == false) {
        if (userAnswer == correctAnswer) {
          myIcons.add(
            const Expanded(
              child: Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
            ),
          );
        } else {
          myIcons.add(
            const Expanded(
              child: Icon(
                Icons.cancel,
                color: Colors.red,
              ),
            ),
          );
        }
        quizBrain.nextQuestion();
      } else {
        Alert(
          context: context,
          title: "Finished!",
          desc: "You've reached the end of the quiz.",
        ).show();

        quizBrain.resetQuestion();
        myIcons.clear();
      }
    });
  }

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
                      quizBrain.getQuestion(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                      ),
                    ),
                  ),
                ),
              ),

              //True Button
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () {
                      checkAnswer(true);
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

              //False Button
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      checkAnswer(false);
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
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: myIcons,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
