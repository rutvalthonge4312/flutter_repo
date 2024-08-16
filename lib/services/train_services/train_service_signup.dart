import 'package:sanchalak/services/api_services/api_exception.dart';
import 'package:sanchalak/services/api_services/api_service.dart';

class TrainServiceSignup {
  static Future<List<String>> getDepot(
    final String division,
  ) async {
    try {
      final responseJson =
          await ApiService.get('/depot-of-division/?division=$division', {});
      List<String> depotList = (responseJson['depo'] as List<dynamic>)
          .map((depot) => depot.toString())
          .toList();
      return depotList;
    } on ApiException catch (e) {
      throw (e.message);
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<List<String>> getTrainList(
    final String depot,
  ) async {
    try {
      final responseJson =
          await ApiService.get('/trains-of-depo/?depo=$depot', {});
      List<String> trainList = (responseJson['trains'] as List<dynamic>)
          .map((train) => train.toString())
          .toSet()
          .toList();
      print(trainList);
      return trainList;
    } on ApiException catch (e) {
      throw (e.message);
    } catch (e) {
      print(e);
      return [];
    }
  }

  //coaches-of-train/?trains=2391
  static Future<List<String>> getCoaches(
    final String trainNumber
  ) async {
    try {
      final responseJson =
          await ApiService.get('/coaches-of-train/?trains=$trainNumber', {});
      List<String> coachList = (responseJson['coaches'] as List<dynamic>)
          .map((train) => train.toString())
          .toSet()
          .toList();
      print(coachList);
      return coachList;
    } on ApiException catch (e) {
      throw (e.message);
    } catch (e) {
      print(e);
      return [];
    }
  }
}
