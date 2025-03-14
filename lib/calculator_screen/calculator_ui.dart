import 'package:calculator/calculator_screen/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorUi extends StatefulWidget {
  const CalculatorUi({super.key});

  @override
  State<CalculatorUi> createState() => _CalculatorUiState();
}

class _CalculatorUiState extends State<CalculatorUi> {
  double firstNum = 0.0;
  double secondNum = 0.0;
  var input = "";
  var output = "";
  var oprator = "";
  var hideInput=false;
  var outputSize=35.0;


  onButtonClick(value){
   if(value=="AC"){
     input='';
     output='';
   }
   else if(value=="<"){
     if(input.isNotEmpty) {
       input = input.substring(0, input.length - 1);
     }
   }

   else if(value=="="){

     if(input.isNotEmpty) {
       var userInput = input;
       userInput = input.replaceAll("X", "*");
       Parser p = Parser();
       Expression expression = p.parse(userInput);
       ContextModel contextModel = ContextModel();
       var finalValue = expression.evaluate(EvaluationType.REAL, contextModel);
       output = finalValue.toString();
       input=output;
       hideInput=true;
       outputSize=48;
     }
   }else{
     input=input+value;
     hideInput=false;
     outputSize=30;
   }

   setState(() {

   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,

      body: Column(
        children: [
          //input output aria
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    hideInput?'': input,
                    style: TextStyle(fontSize: 48, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Text(
                    output,
                    style: TextStyle(fontSize: outputSize, color: Colors.white),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),

          //button Ui design
          Row(children: [
            UiHelper(text: "AC",tColors: orangeCaolor),
            UiHelper(text: "" ,tColors: orangeCaolor),
            UiHelper(text: "<",tColors: orangeCaolor),
            UiHelper(text: "/",tColors: orangeCaolor),
          ]),
          Row(children: [
            UiHelper(text: "7"),
            UiHelper(text: "8"),
            UiHelper(text: "9"),
            UiHelper(text: "X",tColors: orangeCaolor),
          ]),
          Row(children: [
            UiHelper(text: "4"),
            UiHelper(text: "5"),
            UiHelper(text: "6"),
            UiHelper(text: "-",tColors: orangeCaolor),
          ]),

          Row(children: [
            UiHelper(text: "1"),
            UiHelper(text: "2"),
            UiHelper(text: "3"),
            UiHelper(text: "+",tColors: orangeCaolor),
          ]),

          Row(children: [
            UiHelper(text: "%"),
            UiHelper(text: "0"),
            UiHelper(text: "."),
            UiHelper(text: "=",tColors: Colors.white,buttonBgColor: orangeCaolor),
          ]),

        ],
      ),
    );
  }

  Widget UiHelper({
    text,
    tColors = Colors.white30,
    buttonBgColor = buttonColor,
  }) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(12),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonBgColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.all(10),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 28,
              color: tColors,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () =>onButtonClick(text),
        ),
      ),
    );
  }
}
