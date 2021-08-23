import 'package:flutter/material.dart';
import 'helper.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Helper helper = Helper();
void main() => runApp(QuizApp());

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> marcadorDePontos = [];

  void conferirResposta(bool respostaSelecionada) {
    bool respostaCerta = helper.obterResposta();
    setState(() {
      if (helper.confereFimDaExecucao() == true) {
        Alert(
          context: context,
          title: 'Fim do Quiz!',
          desc: 'Você respondeu a todas as perguntas.',
          buttons: [
            DialogButton(
              child: Text('Finalizar'),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ).show();
        helper.resetarQuiz();
        marcadorDePontos = [];
      } else {
        if (respostaSelecionada == respostaCerta) {
          marcadorDePontos.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          marcadorDePontos.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }

        helper.proximaPergunta();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                helper.obterQuestao(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.deepPurple),
              child: Text(
                'Verdadeiro',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                conferirResposta(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style:
                  TextButton.styleFrom(backgroundColor: Colors.grey.shade800),
              child: Text(
                'Falso',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                conferirResposta(false);
              },
            ),
          ),
        ),
        Row(
          children: marcadorDePontos,
        ),
      ],
    );
  }
}
