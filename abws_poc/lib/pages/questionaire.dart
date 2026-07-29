import 'package:flutter/material.dart';
import 'schedulehome.dart';

class Question {
  final String text;
  final List<String> options;

  Question({required this.text, required this.options});
}

class QuestionnaireWidget extends StatefulWidget {
  const QuestionnaireWidget({super.key});

  @override
  State<QuestionnaireWidget> createState() => _QuestionnaireWidgetState();
}

class _QuestionnaireWidgetState extends State<QuestionnaireWidget> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  
  // Track chosen answers mapping: { questionIndex: chosenOption }
  final Map<int, String> _answers = {};

  final List<Question> _questions = [
    Question(
      text: "Sample quesiton for ABWS Questionaire",
      options: ["Option 1", "Option 2", "Option 3", "Option 4"],
    ),
    Question(
      text: "2nd sample question for ABWS",
      options: ["Different options", "Less than previous"],
    ),
  ];

  void _nextPage(int questionIndex, String selectedOption) {
    setState(() {
      _answers[questionIndex] = selectedOption;
    });

    if (_currentIndex < _questions.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      _submitSurvey();
    }
  }

  void _submitSurvey() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Quesitonaire complete"),
        content: Text("Go make your better weekly structure"),
        actions: [
          TextButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ScheduleHomePage())),
            child: const Text("To ABWS"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: PageView.builder(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(), // Prevent manual swiping
        onPageChanged: (index) => setState(() => _currentIndex = index),
        itemCount: _questions.length,
        itemBuilder: (context, qIndex) {
          final currentQuestion = _questions[qIndex];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentQuestion.text,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                ...currentQuestion.options.map((option) {
                  return Card(
                    child: ListTile(
                      title: Text(option),
                      onTap: () => _nextPage(qIndex, option),
                    ),
                  );
                }),
              ],
            ),
          );
        },
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text(
        'A Better Weekly Structure',
        style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: 'HighVoltage'),
      ),
      backgroundColor: Colors.red,
      elevation: 0.0,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset(
            'assets/icons/back_arrow.png',
            height: 20,
            width: 20,
          ),
        ),
      ),

      //Comtains the GOAT profile button
      //the "actions" section is a special property of the appBar widget for things like your profile icon or notifications icon
      actions: [
        Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          width: 37,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset(
            'assets/icons/goat_temp.png',
            height: 20,
            width: 20,
          ),
        ),
      ],
    );
  }
}