import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../settings/global.dart';

// Events
abstract class ResultEvent {}

class FetchResult extends ResultEvent {}

// States
abstract class ResultState {}

class ResultLoading extends ResultState {
  final String imagePath;

  ResultLoading({required this.imagePath});
}

class ResultLoaded extends ResultState {
  final String result;
  final String imagePath;
  final String textResult;

  ResultLoaded({
    required this.result,
    required this.imagePath,
    required this.textResult
  });
}

class ResultError extends ResultState {
  final String error;

  ResultError({required this.error});
}

// BLoC
class ResultBloc extends Bloc<ResultEvent, ResultState> {
  final String imagePath;

  ResultBloc({
    required this.imagePath
  }) : super(ResultLoading(
    imagePath: imagePath
  )){
    on<FetchResult>(_fetchResult);
  }

  FutureOr<void> _fetchResult(
      FetchResult event, Emitter<ResultState> emit ) async {
    try{
      print('come');
      Dio dio = Dio();

      // Create FormData object to send multipart/form-data
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(imagePath),
      });

      print('here');

      // Make POST request
      Response response = await dio.post(server + '/formSubmit', data: formData);

      // Handle the response
      if (response.statusCode == 200) {
        // Request successful, parse and handle the response
        final Map<String, dynamic> decodedResponse = json.decode(response.toString());
        print(decodedResponse);
        print(decodedResponse['result']);
        String result = decodedResponse['result'];
        String responseText = '';
        if(result.toLowerCase() == 'fresh'){
          responseText = 'This meat is fresh!!';
        } else if (result.toLowerCase() == 'spoiled'){
          responseText = 'This meat is spoiled!!';
        } else {
          responseText = 'This meat is half-fresh';
        }
        emit(ResultLoaded(result: result,
            imagePath: imagePath,
            textResult: responseText));
      } else {
        // Request failed
        print("Failed to upload image. Status code: ${response.statusCode}");
      }
    } catch(e){
      print(e.toString());
      emit(ResultError(error: e.toString()));
    }
  }
}