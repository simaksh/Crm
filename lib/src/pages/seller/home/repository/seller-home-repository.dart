import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;
import '../../../../infrastructure/commons/repository-Url.dart';

import '../models/seller-home-dto.dart';
import '../models/seller-home-view-model.dart';

class SellerHomeRepository {
  Future<Either<String, List<SellerHomeViewModel>>> getProducts({
    required int sellerId,
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
          'q': searchText,
          'sellerId': sellerId.toString(),
          'colors_like': color,
        });
        final response = await http.get(url);
        if (response.statusCode >= 200 && response.statusCode < 400) {
          List<dynamic> productsJson = jsonDecode(response.body);
          List<SellerHomeViewModel> products = [];
          for (final json in productsJson) {
            final product = SellerHomeViewModel.fromJson(json);
            products.add(product);
          }
          return Right(products);
        } else {
          return Left(response.statusCode.toString());
        }
      } else {
        final url =
        Uri.http(RepositoryUrls.webBaseUrl, RepositoryUrls.getProduct, {
          'price_lte': maxPrice.toString(),
          'price_gte': minPrice.toString(),
          'q': searchText,
          'sellerId': sellerId.toString(),
          'colors_like': color,
        });
        final response = await http.get(url);
        if (response.statusCode >= 200 && response.statusCode < 400) {
          List<dynamic> productsJson = jsonDecode(response.body);
          List<SellerHomeViewModel> products = [];
          for (final json in productsJson) {
            final product = SellerHomeViewModel.fromJson(json);
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

  Future<Either<String, List<SellerHomeViewModel>>> getProductsBySortPrice(
      {required int sellerId}) async {
    try {
      final url =
      Uri.http(RepositoryUrls.webBaseUrl, RepositoryUrls.getProduct, {
        '_sort': 'price',
        'sellerId': sellerId.toString(),
      });
      final response = await http.get(url);
      if (response.statusCode >= 200 && response.statusCode < 400) {
        List<dynamic> productsJson = jsonDecode(response.body);
        List<SellerHomeViewModel> products = [];
        for (final json in productsJson) {
          final product = SellerHomeViewModel.fromJson(json);
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

  Future<Either<String, SellerHomeViewModel>> patchProduct(
      {required SellerHomeDto dto}) async {
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
          SellerHomeViewModel.fromJson(
            jsonDecode(response.body),
          ),
        );
      } else {
        return Left(response.statusCode.toString());
      }
    } catch (error) {
      return Left(error.toString());
    }
  }
}
