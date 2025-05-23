import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:fluffyn_e_commerce/core/error/failures.dart';
import 'package:http/http.dart' as http;

abstract class GetRequest {
  static Future<Either<dynamic, Failure>> getRequest(String path) async {
    try {
      final result = await http.get(
        Uri.parse(path),
      );
      if (result.statusCode != 200) {
        return Right(
          Failure("Something went wrong!!"),
        );
      } else {
        return Left(
          jsonDecode(result.body),
        );
      }
    } catch (error) {
      return Right(
        Failure("Something went wrong"),
      );
    }
  }
}
