import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;

import '../../../../infrastructure/commons/repository-Url.dart';
import '../models/customer-choice-view-model.dart';
import '../models/customer-product-view-model.dart';


class CustomerRepository {
  Future<Either<String, List<CustomerProductViewModel>>> getProducts({
    required int minPrice,
    required int maxPrice,
    required String? search,
    required String color,
  }) async {
    final String searchText = search ?? '';
    try {
      if (minPrice == 0 || maxPrice == 0) {
        final url =
        Uri.http(RepositoryUrls.webBaseUrl, RepositoryUrls.getProduct, {
          'isActive': 'true',
          'count_gte': '1',
          'q': searchText,
          'colors_like': color,
        });
        final response = await http.get(url);
        if (response.statusCode >= 200 && response.statusCode < 400) {
          List<dynamic> productsJson = jsonDecode(response.body);
          List<CustomerProductViewModel> products = [];
          for (final json in productsJson) {
            final product = CustomerProductViewModel.fromJson(json);
            products.add(product);
          }
          return Right(products);
        } else {
          return Left(response.statusCode.toString());
        }
      } else {
        final url =
        Uri.http(RepositoryUrls.webBaseUrl, RepositoryUrls.getProduct, {
          'isActive': 'true',
          'count_gte': '1',
          'price_lte': maxPrice.toString(),
          'price_gte': minPrice.toString(),
          'q': searchText,
          'colors_like': color,
        });
        final response = await http.get(url);
        if (response.statusCode >= 200 && response.statusCode < 400) {
          List<dynamic> productsJson = jsonDecode(response.body);
          List<CustomerProductViewModel> products = [];
          for (final json in productsJson) {
            final product = CustomerProductViewModel.fromJson(json);
            products.add(product);
          }
          return Right(products);
        } else {
          return Left(response.statusCode.toString());
        }
      }
    } catch (error) {
      return Left(error.toString());
    }
  }

  Future<Either<String, List<CustomerChoiceViewModel>>>
  getSelectedProducts({required int userId}) async {
    try {
      final url = Uri.http(RepositoryUrls.webBaseUrl,
          RepositoryUrls.getSelectedProducts, {'userId': userId.toString()});
      final response = await http.get(url);
      if (response.statusCode >= 200 && response.statusCode < 400) {
        List<dynamic> productsJson = jsonDecode(response.body);
        List<CustomerChoiceViewModel> products = [];
        for (final json in productsJson) {
          final product = CustomerChoiceViewModel.fromJson(json);
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

  Future<Either<String, List<CustomerProductViewModel>>>
  getProductsBySortPrice() async {
    try {
      final url = Uri.http(RepositoryUrls.webBaseUrl, RepositoryUrls.getProduct,
          {'isActive': 'true', '_sort': 'price'});
      final response = await http.get(url);
      if (response.statusCode >= 200 && response.statusCode < 400) {
        List<dynamic> productsJson = jsonDecode(response.body);
        List<CustomerProductViewModel> products = [];
        for (final json in productsJson) {
          final product = CustomerProductViewModel.fromJson(json);
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
}
