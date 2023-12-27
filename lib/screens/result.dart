import 'dart:io';

import 'package:Lockit/bloc/result_page_bloc.dart';
import 'package:Lockit/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  static provider({
    required String imagePath
  }) {
    return BlocProvider(
      create: (context) => ResultBloc(imagePath: imagePath)..add(FetchResult()),
      child: const ResultPage()
    );
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResultBloc, ResultState>(
        builder: (context, state) {
          if (state is ResultError) {
            return Center(
              child: Text('Error: ${state.error}'),
            );
          } else {
            return Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color(0xff47444c),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to a new screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.arrow_back_rounded,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .width,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                            image: FileImage(File(context.read<ResultBloc>().imagePath)),
                            fit: BoxFit.cover
                        )
                    ),

                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if(state is ResultLoading)
                        const CircularProgressIndicator()
                      else if(state is ResultLoaded)
                        Text(
                          state.textResult,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white
                          ),
                        )
                    ],
                  )
                ],
              ),
            );
          }
        }
    );
  }
}