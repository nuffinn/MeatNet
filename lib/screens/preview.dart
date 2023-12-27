import 'dart:io';

import 'package:Lockit/screens/result.dart';
import 'package:flutter/material.dart';

import '../settings/global.dart';

class ImagePreview extends StatefulWidget {
  const ImagePreview({super.key, required this.imagePath });
final String imagePath;
  @override
  State<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  late TextEditingController _textEditingController ;

  @override
  void initState() {
    _textEditingController = TextEditingController(text: server);
    super.initState();
  }

  void _showTextEntryPopup(BuildContext context) {
    print('hello');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Enter Text"),
          content: TextField(
            controller: _textEditingController,
            decoration: const InputDecoration(
              hintText: "Type something...",
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                server = _textEditingController.text ;
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("OK"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,

      child: Scaffold(
        backgroundColor: const Color(0xff1d1b20),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
          height: 500,
          width: MediaQuery.of(context).size.width,
          child: Column(
            
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton( onPressed: () {
                print("hi there");
                _showTextEntryPopup(context);
              },
                child: const Icon(
                    Icons.add
                ),
              ),

              Flexible(
                child: Container(
                  height: MediaQuery.of(context).size.width,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                        image: FileImage(File(widget.imagePath)),
                        fit: BoxFit.cover
                      )
                    ),
                
                  ),
              ),
                Flexible(
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.1,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(onPressed: (){
                          images.add(widget.imagePath);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResultPage.provider(imagePath: widget.imagePath),
                            ),
                          );
                          setState(() {
                          });
                        }, icon: const Icon(
                          Icons.send,
                          size: 50,
                          color: Colors.white,
                        ),),

                      ],
                    ),
                  ),
                )
            ],
          ),
        )
      ),
    );
  }
}
