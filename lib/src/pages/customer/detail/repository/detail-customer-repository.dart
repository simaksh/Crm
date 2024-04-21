import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;
import '../../../../infrastructure/commons/repository-Url.dart';
import '../model/detail-customer-patch-dto.dart';
import '../model/detail-customer-post-dto.dart';
import '../model/detail-customerview-model.dart';


class DetailCustomerRepository {
  Future<Either<String, DetailCustomerViewModel>> getProductById(
      {required int id}) async {
    try {
      final url = Uri.http(
          RepositoryUrls.webBaseUrl, RepositoryUrls.getProductById(id: id));
      final response = await http.get(url);
      if (response.statusCode >= 200 && response.statusCode < 400) {
        Map<String, dynamic> productJson = jsonDecode(response.body);
        DetailCustomerViewModel product =
        DetailCustomerViewModel.fromJson(productJson);
        return Right(product);
      } else {
        return Left(response.statusCode.toString());
      }
    } catch (error) {
      return Left(error.toString());
    }
  }

  Future<Either<String, List<dynamic>>>
  getSelectedProductByProductIdAndUserId(
      {required int userId, required int productId}) async {
    try {
      final url = Uri.http(
          RepositoryUrls.webBaseUrl,
          RepositoryUrls.getSelectedProducts,
          {'productId': productId.toString(), 'userId': userId.toString()});
      final response = await http.get(url);
      if (response.statusCode >= 200 && response.statusCode < 400) {
        return Right(jsonDecode(response.body));
      } else {
        return Left(response.statusCode.toString());
      }
    } catch (error) {
      return Left(error.toString());
    }
  }

  Future<Either<String, Map<String, dynamic>>> postSelectedProduct(
      {required DetailCustomerPostDto dto}) async {
    try {
      final url = Uri.http(
          RepositoryUrls.webBaseUrl, RepositoryUrls.postSelectedProduct);
      final response = await http.post(
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
      } else {
        return Left(response.statusCode.toString());
      }
    } catch (error) {
      return Left(error.toString());
    }
  }

  Future<Either<String, Map<String, dynamic>>> patchSelectedProduct(
      {required DetailCustomerPathDto dto}) async {
    try {
      final url = Uri.http(
          RepositoryUrls.webBaseUrl, RepositoryUrls.patchSelectedProduct(id: dto.id));
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
      } else {
        return Left(response.statusCode.toString());
      }
    } catch (error) {
      return Left(error.toString());
    }
  }
}
