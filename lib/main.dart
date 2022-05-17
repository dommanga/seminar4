import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> FormProvider()),
        ChangeNotifierProvider(create: (_)=> CheckYou()),

      ],
      child: MaterialApp(
        title: '너의 MBTI는',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.green,
        ),
        home: const MyHomePage(title: '너의 MBTI는'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    context.read<CheckYou>().initialize();
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '너의 MBTI는 앱에 오신 것을 환영합니다.\n'
                  '당신의 MBTI, 궁금하신가요?',
            ),
            const SizedBox(height : 50,),
            const Text(
              '당신의 이름을 입력하세요.\n'
            ),
            TextField(
              onChanged: (String str){
                context.read<FormProvider>().changeName(str);
            }
            ),
            // FlatButton(onPressed: (){
            //   context.read<FormProvider>().increaseAge();
            // }, child: Container(
            //     color: Colors.yellow,
            //     child: Text("증가"))),
            Text("${context.watch<FormProvider>().name}님의 MBTI 검사를 시작합니다."),
            FlatButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
              return SecondScreen();
              }));
            }, child: Container(
                color: Colors.blueGrey,
                child: Text("이동"))),

          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class CheckYou with ChangeNotifier {
  String _EI = "I";
  String _SN = "N";
  String _TF = "F";
  String _JP = "P";

  // bool isEI = false;
  // bool isSN = false;
  // bool isTF = false;
  // bool isJP = false;
  //
  String get EI => _EI;
  String get SN => _SN;
  String get TF => _TF;
  String get JP => _JP;

  bool b = false;

  void initialize()
  {
    _EI = "I";
    _SN = "N";
    _TF = "F";
    _JP = "P";
  }

  void changeEI(bool b) {
    if(b == false)
      _EI = "I";
    else
      _EI = "E";
    notifyListeners();
  }

  void changeSN(bool b) {
    if(b == false)
      _SN = "N";
    else
      _SN = "S";
    notifyListeners();
  }
  void changeTF(bool b) {
    if(b == false)
      _TF = "F";
    else
      _TF = "T";
    notifyListeners();
  }
  void changeJP(bool b) {
    if(b == false)
      _JP = "P";
    else
      _JP = "J";
    notifyListeners();
  }
}

class FormProvider with ChangeNotifier {
  String _name = "";

  String get name => _name;


  void changeName(String str){
    _name = str;
    notifyListeners();
  }
}
//
// class CheckBox with ChangeNotifier {
//   value:
// }

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  bool _value = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [const Text("당신은 외향적인가요?\n"
              "(해당하지 않으면 체크하지 않고 넘어가십시오.)"),
            Checkbox(onChanged: (bool? value){
              setState((){
                _value = value!;
                context.read<CheckYou>().changeEI(_value);
                print(context.read<CheckYou>().EI);

              });
            },  value : _value,
            ),

            FlatButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                return ThirdScreen();
              }));
            }, child: Container(
                color: Colors.blueGrey,
                child: Text("이동"))),
          ],
        ),
      ),
    );
  }
}

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({Key? key}) : super(key: key);

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  bool _value = false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [const Text("당신은 현실적인가요?\n"
              "(해당하지 않으면 체크하지 않고 넘어가십시오.)"),
            Checkbox(onChanged: (bool? value){
              setState((){
                _value = value!;
                context.read<CheckYou>().changeSN(_value);
                print(context.read<CheckYou>().SN);
              });
            },  value : _value,
            ),
            FlatButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                return FourthScreen();
              }));
            }, child: Container(
                color: Colors.blueGrey,
                child: Text("이동"))),
          ],
        ),
      ),
    );
  }
}

class FourthScreen extends StatefulWidget {
  const FourthScreen({Key? key}) : super(key: key);

  @override
  State<FourthScreen> createState() => _FourthScreenState();
}

class _FourthScreenState extends State<FourthScreen> {
  bool _value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [const Text("당신은 감성적이기 보다는 이성적인 편인가요?\n"
              "(해당하지 않으면 체크하지 않고 넘어가십시오.)"),
            Checkbox(onChanged: (bool? value){
              setState((){
                _value = value!;
                context.read<CheckYou>().changeTF(_value);
                print(context.read<CheckYou>().TF);
              });
            },  value : _value,
            ),
            FlatButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                return FifthScreen();
              }));
            }, child: Container(
                color: Colors.blueGrey,
                child: Text("이동"))),
          ],
        ),
      ),
    );
  }
}

class FifthScreen extends StatefulWidget {
  const FifthScreen({Key? key}) : super(key: key);

  @override
  State<FifthScreen> createState() => _FifthScreenState();
}

class _FifthScreenState extends State<FifthScreen> {
  bool _value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [const Text("당신은 계획적인가요?\n"
              "(해당하지 않으면 체크하지 않고 넘어가십시오.)"),
            Checkbox(onChanged: (bool? value){
              setState((){
                _value = value!;
                context.read<CheckYou>().changeJP(_value);
                print(context.read<CheckYou>().JP);
              });
            },  value : _value,
            ),
            FlatButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                return FinalScreen();
              }));
            }, child: Container(
                color: Colors.blueGrey,
                child: Text("이동"))),
          ],
        ),
      ),
    );
  }
}

class FinalScreen extends StatefulWidget {
  const FinalScreen({Key? key}) : super(key: key);

  @override
  State<FinalScreen> createState() => _FinalScreenState();
}

class _FinalScreenState extends State<FinalScreen> {
  bool _value = false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Container(
              height: 100,
              width: 400,
              child: Text(
                  "테스트가 완료되었습니다.\n"
              "당신의 MBTI는\n"
          "${context.watch<CheckYou>().EI} ${context.watch<CheckYou>().SN} ${context.watch<CheckYou>().TF} ${context.watch<CheckYou>().JP}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            ),
            ),
            FlatButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                return MyHomePage(title: '너의 MBTI는');
              }));
            }, child: Container(
                color: Colors.blueGrey,
                child: Text("HOME"))),
          ],
        ),
      ),
    );
  }
}







