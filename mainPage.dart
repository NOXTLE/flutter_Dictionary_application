import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    var wordController = TextEditingController();
    var value = wordController.text;

    Future getWord() async {
      final res = await http.get(
          Uri.parse("https://api.dictionaryapi.dev/api/v2/entries/en/$value"));
      var output = jsonDecode(res.body);
      print("get word called");
      print(output[0]['meanings']);

      // ignore: use_build_context_synchronously
      return showDialog(
          context: context,
          builder: (conext) {
            return AlertDialog(
                content: Container(
              height: MediaQuery.of(context).size.height / 2,
              child: SingleChildScrollView(
                child: Column(children: [
                  Text(output[0]['word'],
                      style: GoogleFonts.novaSquare(
                          textStyle: TextStyle(fontSize: 32))),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Phonetic : ${output[0]['phonetic']}",
                    style: TextStyle(fontSize: 32),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      "Part Of Speech : ${output[0]['meanings'][0]['partOfSpeech']}",
                      style: GoogleFonts.jost(textStyle: TextStyle())),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                      "Meaning : ${output[0]['meanings'][0]['definitions'][0]['definition']}",
                      style: GoogleFonts.jost()),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      "Example : ${output[0]['meanings'][0]['definitions'][0]['example']}",
                      style: GoogleFonts.jost()),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Part Of Speech : ${output[0]['meanings'][2]['partOfSpeech']}",
                    style: GoogleFonts.jost(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      "Meaning : ${output[0]['meanings'][2]['definitions'][0]['definition']}",
                      style: GoogleFonts.jost()),
                  SizedBox(height: 10),
                  Text(
                      "Example : ${output[0]['meanings'][2]['definitions'][0]['example']}",
                      style: GoogleFonts.jost()),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        height: 40,
                        width: 100,
                        decoration: const BoxDecoration(
                            color: Colors.green,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: const Center(
                          child: Text(
                            "Close",
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                  )
                ]),
              ),
            ));
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("D I C T I O N A R Y",
            style: GoogleFonts.novaSquare(
                textStyle: const TextStyle(fontWeight: FontWeight.bold))),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 4,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: TextField(
              keyboardType: TextInputType.name,
              controller: wordController,
              onSubmitted: (String) {
                setState(() {
                  value = wordController.text;
                  getWord();
                });
              },
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter The Word ",
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
          ),
          ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.green),
                  foregroundColor: MaterialStatePropertyAll(Colors.white)),
              onPressed: () {
                getWord();
              },
              child: Text("Search", style: GoogleFonts.novaSquare())),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
