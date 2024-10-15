import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 140, 29, 230)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

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
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';
  String _passwordErrorMessage = '';
  final String _correctPassword = '1991';
  final String _passwordHint = "The year of Ukraine's independence";

  // Add number to the counter
  void _incrementCounter() {
    String inputText = _controller.text;

    int? number = int.tryParse(inputText);

    if (number != null) {
      setState(() {
        _counter += number;
        _errorMessage = '';
      });
    } else {
      setState(() {
        _errorMessage = 'Please, enter a number';
      });
    }
  }

  // Reset counter and check a password
  void _resetCounter() {
    String enteredPassword = _passwordController.text;

    if (enteredPassword == _correctPassword) {
      setState(() {
        _counter = 0;
        _controller.clear();
        _passwordController.clear();
        _errorMessage = '';
        _passwordErrorMessage = '';
      });
    } else {
      setState(() {
        _passwordErrorMessage = 'Incorrect password';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('An almost primitive counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Counter: $_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter a number',
                  errorText: _errorMessage.isEmpty ? null : _errorMessage,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _incrementCounter,
                  child: Text('Add to the counter'),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Enter the reset password',
                  hintText: _passwordHint,
                  errorText: _passwordErrorMessage.isEmpty
                      ? null
                      : _passwordErrorMessage,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _resetCounter,
              style: ElevatedButton.styleFrom(),
              child: Text('Reset the counter'),
            ),
          ],
        ),
      ),
    );
  }
}
