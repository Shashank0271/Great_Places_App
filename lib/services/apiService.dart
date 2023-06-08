import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

import '../models/spot.dart';

class ApiService {
  final dio = Dio();
  ApiService() {
    // dio.options.baseUrl = 'http://192.168.29.94:8000/api/v1/';
    dio.options.baseUrl = 'https://gpps.onrender.com/api/v1/';
  }
  Future<List<Spot>?> findSpotsViaGeocoding(
      {required String state, required String city}) async {
    try {
      final response = await dio.get('geocode', queryParameters: {
        "city": city,
        "state": state,
      });
      List<Spot> myPosts =
          (response.data as List).map((e) => Spot.fromMap(e)).toList();
      return myPosts;
    } on DioException catch (e) {
      print(e.error);
      print(e.message);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<Spot>?> findSpotsViaReverseGeocoding(
      {required double lat, required double lon}) async {
    try {
      final response = await dio.get('geocode/reverse', queryParameters: {
        "lat": lat,
        "lon": lon,
      });
      print(response.data);
      List<Spot> myPosts =
          (response.data as List).map((e) => Spot.fromMap(e)).toList();
      return myPosts;
    } on DioException catch (e) {
      print(e.error);
      print(e.message);
    } catch (e) {
      print(e.toString());
    }
  }
}
