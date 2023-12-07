// aboutPage.dart

import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("About"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Welcome to the PokeApp! An app that serves as a go-to information source for all things Pokemon. It will provide you with information on any Pokemon that has been released, including move-sets, where to find, and any other information you may find valuable.\n\nDeveloped by Aaron Kingsley for CMSC 2204",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
