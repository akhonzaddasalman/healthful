import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthful/View/Utils/next_screen.dart';
import 'package:healthful/View/theme/light_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuestionnairePage extends StatefulWidget {
  @override
  _QuestionnairePageState createState() => _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage> {
  int _currentQuestionIndex = 0;

  final List<Question> _questions = [
    Question(
      questionText: 'Age:',
      options: [
        'Under 18',
        '18-24',
        '25-34',
        '35-44',
        '45-54',
        '55-64',
        '65 and over'
      ],
    ),
    Question(
      questionText: 'Gender:',
      options: ['Male', 'Female', 'Other', 'Prefer not to say'],
    ),
    Question(
      questionText:
          'Do you have any chronic conditions? (Check all that apply)',
      options: [
        'Diabetes',
        'Hypertension',
        'Asthma',
        'Heart Disease',
        'Other (please specify)'
      ],
      isMultiSelect: true,
    ),
    Question(
      questionText: 'Have you had any major surgeries?',
      options: ['Yes (please specify)', 'No'],
    ),
    Question(
      questionText: 'Are you currently taking any medications?',
      options: ['Yes', 'No'],
    ),
    Question(
      questionText: 'Do you have any known allergies?',
      options: ['Yes (please specify)', 'No'],
    ),
    Question(
      questionText:
          'Does anyone in your family have a history of chronic diseases? (Check all that apply)',
      options: [
        'Heart Disease',
        'Cancer',
        'Diabetes',
        'Other (please specify)',
        'No'
      ],
      isMultiSelect: true,
    ),
    Question(
      questionText:
          'Are you experiencing any of the following symptoms? (Check all that apply)',
      options: [
        'Fever',
        'Cough',
        'Shortness of Breath',
        'Pain',
        'Other (please specify)',
        'None'
      ],
      isMultiSelect: true,
    ),
    Question(
      questionText:
          'What is your preferred language for communication with healthcare providers?',
      options: ['English', 'Spanish', 'French', 'Other (please specify)'],
    ),
    Question(
      questionText:
          'Do you have any preferences for the healthcare provider? (Check all that apply)',
      options: [
        'Gender (please specify)',
        'Specialty (please specify)',
        'Location (please specify)',
        'No preference'
      ],
      isMultiSelect: true,
    ),
    Question(
      questionText:
          'What are your preferred days and times for appointments? (Check all that apply)',
      options: ['Weekdays', 'Weekends', 'Mornings', 'Afternoons', 'Evenings'],
      isMultiSelect: true,
    ),
    Question(
      questionText:
          'Do you consent to share your health information with the healthcare providers for the purpose of better diagnosis and treatment?',
      options: ['Yes', 'No'],
    ),
  ];

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SummaryPage(questions: _questions),
        ),
      );
    }
  }

  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double progress = (_currentQuestionIndex + 1) / _questions.length;

    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[300],
              valueColor:
                  const AlwaysStoppedAnimation<Color>(LightColor.marron),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        _questions[_currentQuestionIndex].questionText,
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      ..._buildOptions(_questions[_currentQuestionIndex]),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentQuestionIndex > 0)
                    Expanded(
                      child: SizedBox(
                        height: 55,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              backgroundColor:
                                  WidgetStateProperty.all(LightColor.marron)),
                          onPressed: _previousQuestion,
                          child: Text(
                            'Previous',
                            style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  if (_currentQuestionIndex > 0)
                    const SizedBox(
                      width: 30,
                    ),
                  Expanded(
                    child: SizedBox(
                      height: 55,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            backgroundColor:
                                WidgetStateProperty.all(LightColor.marron)),
                        onPressed: _nextQuestion,
                        child: Text(
                          _currentQuestionIndex < _questions.length - 1
                              ? 'Next'
                              : 'Submit',
                          style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildOptions(Question question) {
    List<Widget> optionsList = [];

    if (question.isMultiSelect) {
      for (var option in question.options) {
        optionsList.add(
          CheckboxListTile(
            title: Text(option),
            value: question.selectedOptions.contains(option),
            checkColor: LightColor.white,
            activeColor: LightColor.marron,
            onChanged: (bool? selected) {
              setState(() {
                if (selected == true) {
                  question.selectedOptions.add(option);
                } else {
                  question.selectedOptions.remove(option);
                }
              });
            },
          ),
        );
        if (option.contains('please specify') &&
            question.selectedOptions.contains(option)) {
          optionsList.add(
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (text) {
                  question.additionalInput[option] = text;
                },
                decoration: InputDecoration(
                  labelText: "Please specify",
                  labelStyle: GoogleFonts.poppins(color: LightColor.marron),
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        const BorderSide(color: LightColor.marron, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        const BorderSide(color: LightColor.marron, width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Color(0xffE64646)),
                  ),
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
          );
        }
      }
    } else {
      for (var option in question.options) {
        optionsList.add(
          RadioListTile<String>(
            title: Text(option),
            value: option,
            groupValue: question.selectedOption,
            activeColor: LightColor.marron,
            onChanged: (String? selected) {
              setState(() {
                question.selectedOption = selected;
              });
            },
          ),
        );
        if (option.contains('please specify') &&
            question.selectedOption == option) {
          optionsList.add(
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: TextField(
                onChanged: (text) {
                  question.additionalInput[option] = text;
                },
                decoration: InputDecoration(
                  labelText: "Please specify",
                  labelStyle: GoogleFonts.poppins(color: LightColor.marron),
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        const BorderSide(color: LightColor.marron, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        const BorderSide(color: LightColor.marron, width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Color(0xffE64646)),
                  ),
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
          );
        }
      }
    }

    return optionsList;
  }
}

class Question {
  final String questionText;
  final List<String> options;
  final bool isMultiSelect;
  final bool hasAdditionalInput;
  List<String> selectedOptions = [];
  String? selectedOption;
  Map<String, String> additionalInput = {};

  Question({
    required this.questionText,
    required this.options,
    this.isMultiSelect = false,
    this.hasAdditionalInput = false,
  });
}

class SummaryPage extends StatelessWidget {
  final List<Question> questions;

  SummaryPage({required this.questions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Summary'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0,),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: ListView.builder(
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    final question = questions[index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              question.questionText,
                              style: const TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                            if (question.isMultiSelect)
                              ...question.selectedOptions.map((option) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(option),
                                    if (option.contains('please specify'))
                                      Text(
                                          'Additional input: ${question.additionalInput[option] ?? ''}'),
                                  ],
                                );
                              }).toList()
                            else if (question.selectedOption != null)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(question.selectedOption!),
                                  if (question.selectedOption!
                                      .contains('please specify'))
                                    Text(
                                        'Additional input: ${question.additionalInput[question.selectedOption!] ?? ''}'),
                                ],
                              ),

                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 55,
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    backgroundColor:
                    WidgetStateProperty.all(LightColor.marron)),
                onPressed: () async {
                  print("Selected Option == ${questions[2].selectedOptions.first.toString()}");
                  final SharedPreferences s = await SharedPreferences.getInstance();
                  if(questions[2].selectedOptions.isNotEmpty){
                    s.setStringList("disease", questions[2].selectedOptions ?? []);
                    Future.delayed(const Duration(seconds: 3)).then((value) {
                      print(s.getStringList("disease"));

                    });
                    nextScreenRemoveUntil(context, '/signIn');
                  }

                },
                child: Text(
                  'Submit',
                  style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 30,)
          ],
        ),
      ),
    );
  }
}
