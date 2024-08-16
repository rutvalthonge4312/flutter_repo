import 'package:sanchalak/services/api_services/index.dart';
import 'package:sanchalak/types/index.dart';

class SignUpOtp {
  static Future<String> veirfyOtp(
    final String value,
    final String otp,
    final String type,
  ) async {
    try{
      final request =VerifyRequest(value: value,otp: otp,type: type);
      if(type=="phone"){
        final responseJson =await ApiService.post('/users/request-user/confirm_phone_ver/', request.toJson());
        return responseJson['message'];
      }
      else{
        final responseJson =await ApiService.post('/users/request-user/confirm-email/', request.toJson());
        return responseJson['message'];
      }
    }
     on ApiException catch (e) {
      throw (e.message);
    }
    catch(e){
      return 'Error Occourd At Verify Otp';
    }
  }

  static Future<String> sendOtp(
    final String value,
    final String type,
  ) async {
    try{
      final request =SendOtp(value: value,type: type);
      if(type=='phone'){
        final responseJson =await ApiService.post('/users/request-user/verify_phone/', request.toJson());
        return responseJson['message'];
      }
      else if(type=='phone_number'){
        final responseJson =await ApiService.post('/users/login-using-otp-send/', request.toJson());
        return responseJson['message'];
      }else if(type=='forgot_password_otp'){
        final responseJson =await ApiService.post('/users/password_reset/', request.toJson());
        return responseJson['message'];
      }
      else{
        //users/request-user/verify-email/
        final responseJson =await ApiService.post('/users/request-user/verify-email/', request.toJson());
        return responseJson['message'];
      }
    }
     on ApiException catch (e) {
      throw (e.message);
    }
    catch(e){
      return 'Error Occourded while sending Otp';
    }
  } 
}
