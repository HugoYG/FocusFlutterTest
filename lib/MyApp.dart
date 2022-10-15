import 'package:flutter/material.dart';
import 'package:focus_flutter_test/config/size_config.dart';

import 'helpers/fibonacci_functions.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FibonacciLists fibonacciFunctions = FibonacciLists();

  List<int> _list = [0, 0, 0, 0, 0, 0, 0, 0, 0];
  final controllerStart = TextEditingController();
  final controllerEnd = TextEditingController();
  String total = "0";
  bool generated = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Text(
                      "Matriz de Fibonacci",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                      ),
                    ),
                  ),
                ],
              ),
              GridView.count(
                shrinkWrap: true,
                mainAxisSpacing: 4,
                crossAxisSpacing: 100,
                crossAxisCount: 3,
                children: _list.map((item) {
                  return Center(
                    child: Text('$item',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 2 * SizeConfig.blockSizeVertical)),
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text('Suma de matriz: $total',
                    style: const TextStyle(fontSize: 18)),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Text(
                      "Elemento inicial:",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 2 * SizeConfig.blockSizeVertical),
                    ),
                  ),
                  SizedBox(
                    width: 4 * SizeConfig.blockSizeVertical,
                    child: TextField(
                      controller: controllerStart,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 2 * SizeConfig.blockSizeVertical),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Text(
                      "Elemento final:",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 2 * SizeConfig.blockSizeVertical),
                    ),
                  ),
                  SizedBox(
                    width: 4 * SizeConfig.blockSizeVertical,
                    child: TextField(
                      controller: controllerEnd,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 2 * SizeConfig.blockSizeVertical),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 3 * SizeConfig.blockSizeVertical,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize:
                            Size((70 * SizeConfig.blockSizeHorizontal), 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: Text(
                      'Generar matriz',
                      style:
                          TextStyle(fontSize: 3 * SizeConfig.blockSizeVertical),
                    ),
                    onPressed: () {
                      if (controllerEnd.text == null ||
                          controllerStart.text == null) {
                        return;
                      } else {
                        if (int.tryParse(controllerStart.text) == null ||
                            int.tryParse(controllerEnd.text) == null) {
                          return;
                        }
                      }

                      generated = true;
                      int controllerIntEnd = int.tryParse(controllerEnd.text)!;
                      int controllerIntStart =
                          int.tryParse(controllerStart.text)!;
                      int controllerInt = controllerIntEnd - controllerIntStart;
                      if (controllerInt > 9) {
                        //error si intenta mostrar + 9 elementos
                        var test = AlertDialog(
                          title: const Text('Error'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: const <Widget>[
                                Text(
                                    'Error, se ha sobrepasado el limite de números para mostrar'),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Ok'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return test;
                          },
                        );
                      } else {
                        _list = fibonacciFunctions.generateWithBounds(
                            int.parse(controllerStart.text),
                            controllerInt,
                            int.parse(controllerEnd.text));
                        total = fibonacciFunctions.totalList(_list).toString();
                        setState(() {});
                      }
                    },
                  ),
                  SizedBox(height: 3 * SizeConfig.blockSizeVertical),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize:
                            Size((70 * SizeConfig.blockSizeHorizontal), 50),
                        primary: generated ? Colors.blue : Colors.grey,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: Text(
                      'Rotar a la derecha',
                      style:
                          TextStyle(fontSize: 3 * SizeConfig.blockSizeVertical),
                    ),
                    onPressed: () {
                      if (generated) {
                        var fixed = _list;
                        _list = fibonacciFunctions.rotateRight(fixed);
                        setState(() {});
                      }
                    },
                  ),
                  SizedBox(height: 3 * SizeConfig.blockSizeVertical),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize:
                            Size((70 * SizeConfig.blockSizeHorizontal), 50),
                        primary: generated ? Colors.blue : Colors.grey,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: Text(
                      'Limpiar matriz',
                      style:
                          TextStyle(fontSize: 3 * SizeConfig.blockSizeVertical),
                    ),
                    onPressed: () {
                      if (generated) {
                        _list = [0, 0, 0, 0, 0, 0, 0, 0, 0];
                        setState(() {});
                        generated = false;
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
