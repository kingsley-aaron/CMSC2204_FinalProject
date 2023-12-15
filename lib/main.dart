import 'package:flutter/material.dart';
import 'Models/LoginStructure.dart';
import 'Models/Pokemon.dart';
import 'Repositories/DataService.dart';
import 'Views/aboutPage.dart';
import 'Repositories/UserClient.dart';
import 'Views/PokemonView_2.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
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
      getPokemon();
    }

    setState(() {
      _loading = false;
    });
  }

  void getPokemon() {
    setState(() {
      _loading = true;

      widget.userClient
          .GetPokemonAsync()
          .then((response) => onGetPokemonResponse(response));
    });
  }

  onGetPokemonResponse(List<Pokemon>? pokemon) {
    setState(() {
      if (pokemon != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PokemonView(inPokemon: pokemon)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 8,
        title: Text(widget.title),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              Colors.red,
            ],
          ),
        ),
        child: Center(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                color: Colors.transparent,
                child: Column(
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
              ),
              _loading
                  ? Column(
                      children: [
                        CircularProgressIndicator(),
                        Text("Loading..."),
                      ],
                    )
                  : Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AboutPage()),
                        );
                      },
                      child: Text(
                        "About",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          decoration: TextDecoration.underline,
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
      ),
    );
  }
}
