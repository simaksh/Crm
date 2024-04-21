import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;

import '../../../../infrastructure/commons/repository-Url.dart';

import '../models/seller-edit-dto.dart';
import '../models/seller-edit-view-model.dart';

class SellerEditRepository{

  Future<Either<String, SellerEditViewModel>> getProductById({required int id}) async {
    try {
      final url =
      Uri.http(
          RepositoryUrls.webBaseUrl, RepositoryUrls.getProductById(id: id));
      final response = await http.get(url);
      if (response.statusCode >= 200 && response.statusCode < 400) {
        Map<String, dynamic> productJson = jsonDecode(response.body);
        SellerEditViewModel product = SellerEditViewModel.fromJson(
            productJson);
        return Right(product);
      } else {
        return Left(response.statusCode.toString());
      }
    } catch (error) {
      return Left(error.toString());
    }
  }

  Future<Either<String, Map<String ,dynamic>>> patchProduct(
      {required SellerEditDto dto}) async {
    try{
      final url = Uri.http(
          RepositoryUrls.webBaseUrl, RepositoryUrls.patchProduct(id: dto.id));
      final response = await http.patch(
        url,
        body: jsonEncode(
          dto.toJson(),
        ),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode >= 200 && response.statusCode < 400) {
        return Right(
          jsonDecode(response.body),
        );
      }else{
        return Left(response.statusCode.toString());
      }
    }catch(error){
      return Left(error.toString());
    }
  }

}