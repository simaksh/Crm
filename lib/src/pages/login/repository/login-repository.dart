import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:http/http.dart'as http;

import '../../../infrastructure/commons/repository-Url.dart';
class LoginRepository{
  Future<Either<String,List<dynamic>>>getUsers({required String userName})async{
    try{
      final url=Uri.http(RepositoryUrls.webBaseUrl,RepositoryUrls.getUser,{'userName':userName});
      final response=await http.get(url);
      if(response.statusCode>=200&&response.statusCode<400){
        return Right(jsonDecode(response.body));

      }else {
        return Left(response.statusCode.toString());
      }
    }catch(error){
      return Left(error.toString());
    }
  }
}