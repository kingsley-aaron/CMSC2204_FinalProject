import 'package:flutter/material.dart';
import 'Models/LoginStructure.dart';
import 'Repositories/DataService.dart';
import 'Views/aboutPage.dart';
import 'Repositories/UserClient.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized

  await _initInitialCredentials();
  runApp(MyApp());
}

final DataService _dataService = DataService();
Future<void> _initInitialCredentials() async {
  // Check if credentials already exist to avoid overwriting
  Map<String, String> credentials = await _dataService.getCredentials();
  if (credentials['username']!.isEmpty && credentials['password']!.isEmpty) {
    // Save initial login credentials if not already set
    await _dataService.saveCredentials('admin', 'Password1');
  }
}

class MyApp extends StatelessWidget {
  MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Kingsley Mobile App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final UserClient userClient = UserClient();
  MyHomePage({Key? key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

bool _loading = false;

class _MyHomePageState extends State<MyHomePage> {
  String appVersion = "1.0.1";
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  onLoginButtonPress() {
    setState(() {
      _loading = true;
      LoginStructure user =
          LoginStructure(usernameController.text, passwordController.text);

      widget.userClient
          .Login(user)
          .then((loginSuccess) => {onLoginCallCompleted(loginSuccess!)});
    });
  }

  void onLoginCallCompleted(String loginSuccess) {
    if (loginSuccess != "Login Success") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Unsuccessful login: $loginSuccess"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Login successful"),
        ),
      );
      // Add code to launch Poke API information
    }

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Please sign in"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: usernameController,
                        decoration: InputDecoration(hintText: "Username"),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: passwordController,
                        decoration: InputDecoration(hintText: "Password"),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: onLoginButtonPress,
                      child: Text("Sign In"),
                    ),
                  ],
                ),
              ],
            ),
            _loading
                ? Column(
                    children: [
                      CircularProgressIndicator(),
                      Text("Loading..."),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AboutPage()),
                            );
                          },
                          child: Text(
                            "About",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "Version: $appVersion",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
