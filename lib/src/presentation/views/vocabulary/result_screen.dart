import 'package:flutter/material.dart';
import 'package:flutter_english/src/domain/models/result_vocabulary.dart';
import './widgets/pie_chart.dart';
import 'package:go_router/go_router.dart';

class ResultScreen extends StatefulWidget {
  final List<ResultVocabulary> answers;
  const ResultScreen({super.key, required this.answers});
  static const routeName = 'result-screen';

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  int correctAnswers = 0;

  @override
  Widget build(BuildContext context) {
    correctAnswers = widget.answers.where((element) => element.isTrue).length;
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/result.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(.06),
        appBar: AppBar(
          backgroundColor: Colors.black45,
          title: const Text(
            "Your Result",
          ),
          leading: IconButton(
            onPressed: () {
              context.pop();
              context.pop();
            },
            icon: const Icon(Icons.chevron_left_sharp, size: 30),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            children: [
              Center(
                child: PieChart(
                  radius: 80,
                  correctAnswers: correctAnswers,
                  incorrectAnswers: widget.answers.length - correctAnswers,
                  child: Center(
                    child: Text(
                      "$correctAnswers/${widget.answers.length}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Your Answers",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 5),
                  itemCount: widget.answers.length,
                  itemBuilder: (context, index) => ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    tileColor: widget.answers[index].isTrue
                        ? Colors.green.withOpacity(.5)
                        : Colors.red.withOpacity(.5),
                    title: Text(
                      widget.answers[index].vocabularies.english,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
