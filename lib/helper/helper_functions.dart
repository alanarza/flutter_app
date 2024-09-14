import 'package:flutter/material.dart';
import 'package:http_exception/http_exception.dart';
import 'package:http_status/http_status.dart';

//display error messaje to user
void displayMessageToUser(String message, BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(message),
    )
  );
}

void validateResponseStatus(response) {
  if (response.statusCode == HttpStatus.notFound.code) {
    throw const NotFoundHttpException(data: {'error': 'User not found'});
  } else if (response.statusCode == HttpStatus.internalServerError.code) {
    throw const InternalServerErrorHttpException();
  } else if (response.statusCode != HttpStatus.ok.code) {
    throw HttpException(
      httpStatus: HttpStatus.fromCode(response.statusCode),
      detail: 'Unexpected error occurred'
    );
  }
}