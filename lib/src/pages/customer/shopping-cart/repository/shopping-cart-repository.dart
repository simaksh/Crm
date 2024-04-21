import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;

import '../../../../infrastructure/commons/repository-Url.dart';

import '../models/shopping-cart-choice-product-dto.dart';
import '../models/shopping-cart-choice-product-view-model.dart';
import '../models/shopping-cart-dto.dart';
import '../models/shopping-cart-view-model.dart';

class ShoppingCartRepository {
  Future<Either<String, List<SoppingCartChoiceProductViewModel>>>
  getSelectedProductsByUserId({required int userId}) async {
    try {
      final url = Uri.http(
          RepositoryUrls.webBaseUrl, RepositoryUrls.getSelectedProducts,{'userId': userId.toString()});
      final response = await http.get(url);
      if (response.statusCode >= 200 && response.statusCode < 400) {
        List<dynamic> productsJson = jsonDecode(response.body);
        List<SoppingCartChoiceProductViewModel> products = [];
        for (final json in productsJson) {
          final product =
          SoppingCartChoiceProductViewModel.fromJson(json);
          products.add(product);
        }
        return Right(products);
      } else {
        return Left(response.statusCode.toString());
      }
    } catch (error) {
      return Left(error.toString());
    }
  }

  Future<Either<String, Map<String, dynamic>>> patchProduct(
      {required ShoppingCartDto dto}) async {
    try {
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
      } else {
        return Left(response.statusCode.toString());
      }
    } catch (error) {
      return Left(error.toString());
    }
  }

  Future<Either<String, Map<String, dynamic>>> patchSelectedProduct(
      {required ShoppingCartChoiceProductDto dto}) async {
    try {
      final url = Uri.http(RepositoryUrls.webBaseUrl,
          RepositoryUrls.patchSelectedProduct(id: dto.id));
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

  Future<Either<String, String>> deleteSelectedProduct(
      {required int id}) async {
    try {
      final url = Uri.http(RepositoryUrls.webBaseUrl,
          RepositoryUrls.deleteSelectedProductById(id: id));
      final response = await http.delete(url);
      if (response.statusCode >= 200 && response.statusCode < 400) {
        return Right(response.body);
      } else {
        return Left(response.body);
      }
    } catch (error) {
      return Left(error.toString());
    }
  }

  Future<Either<String, ShoppingCartViewModel>> getProducts(
      {required int id}) async {
    try {
      final url = Uri.http(
          RepositoryUrls.webBaseUrl, RepositoryUrls.getProductById(id: id));
      final response = await http.get(url);
      if (response.statusCode >= 200 && response.statusCode < 400) {
        Map<String , dynamic> productJson = jsonDecode(response.body);
        final product = ShoppingCartViewModel.fromJson(productJson);
        return Right(product);
      } else {
        return Left(response.statusCode.toString());
      }
    } catch (error) {
      return Left(error.toString());
    }
  }
}
