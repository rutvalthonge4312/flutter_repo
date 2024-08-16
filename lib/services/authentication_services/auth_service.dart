import 'package:sanchalak/services/api_services/index.dart';
import 'package:sanchalak/types/user_types/index.dart';

class AuthService {
  static Future<LoginResponse?> login(
    String mobileNumber,
    String password,
  ) async {
    try {
      final request =
          LoginRequest(mobileNumber: mobileNumber, password: password);
      final responseJson =
          await ApiService.post('/users/login/', request.toJson());
      print(responseJson);
      return LoginResponse.fromJson(responseJson);
    } on ApiException catch (e) {
      throw (e.message);
    } catch (e) {
      print(e);
      print("Error Occourded while login");
      return null;
    }
  }

  static Future<LoginResponse?> loginWithGoogle(
    String authToken,
  ) async {
    try {
      final responseJson =
          await ApiService.post('/user/google/', {"auth_token": authToken});
      return LoginResponse.fromJson(responseJson);
    } on ApiException catch (e) {
      throw (e.message);
    } catch (e) {
      print(e);
      print("Error Occourded while login");
      return null;
    }
  }

  // static Future<LoginResponse?> loginByMobile(
  //   String loginCode,
  //   String phone,
  // ) async {
  //   try{
  //     final request =
  //       LoginMobileRequest(mobileNumber: phone, otp: loginCode);
  //       print(request);
  //     final responseJson =
  //         await ApiService.post('/user/login-using-otp-verify/', request.toJson());
  //     print("The ResponseresponseJson");
  //     return LoginResponse.fromJson(responseJson);
  //   }
  //   on ApiException catch (e) {
  //     throw (e.message);
  //   }
  //   catch(e){
  //     print(e);
  //     print("Error Occourded while login");
  //     return null;
  //   }
  // }

  static Future<String> signup(
    String mobileNumber,
    String fName,
    String lName,
    String email,
    String password,
    String rePassword,
    String userType,
    String division,
    String trains,
    String coaches,
  ) async {
    try {
      final request = SignupRequest(
        fName: fName,
        lName: lName,
        email: email,
        phone: mobileNumber,
        password: password,
        rePassword: rePassword,
        userType: userType,
        division: division,
        trains: trains,
        coaches: coaches,
      );
      final responseJson =
          await ApiService.post('/users/request-user/', request.toJson());
      return responseJson['message'];
    } on ApiException catch (e) {
      throw (e.message);
    } catch (e) {
      return "Error Occourded while sign up";
    }
  }

  static Future<String> logout(
    String refreshToken,
    String token,
  ) async {
    try {
      final request = {'refresh_token': refreshToken, 'token': token};
      final response = await ApiService.delete('/user/logout/', request);
      return response["message"];
    } on ApiException catch (e) {
      throw (e.message);
    } catch (e) {
      return "Error Occourded while Logout";
    }
  }

  static Future<String> deactivateAccount(String token) async {
    try {
      final request = {'token': token};
      final response = await ApiService.post(
          '/user/profile/edit-profile/deactivate-account/', request);
      return response["message"];
    } on ApiException catch (e) {
      throw (e.message);
    } catch (e) {
      return "Deactivation failed";
    }
  }
}
