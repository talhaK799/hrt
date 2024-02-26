import 'package:twilio_phone_verify/twilio_phone_verify.dart';

import '../constants/keys.dart';

class VerificationService {
  late TwilioPhoneVerify _twilioPhoneVerify;
  late TwilioResponse twilioResponse;

  VerificationService() {
    _twilioPhoneVerify = TwilioPhoneVerify(
      accountSid: Keys.account_sid,
      authToken: Keys.auth_token,
      serviceSid: Keys.service_id,
    );
  }

  sendVerificationCodeThroughPhoneNumber(String phoneNumber) async {
    _twilioPhoneVerify = TwilioPhoneVerify(
      accountSid: Keys.account_sid,
      authToken: Keys.auth_token,
      serviceSid: Keys.service_id,
    );
    try {
      twilioResponse = await _twilioPhoneVerify.sendSmsCode("$phoneNumber");
      print("Error msg ==> ${twilioResponse.errorMessage}");
      print("Error msg ==> ${twilioResponse.statusCode}");

      return twilioResponse.successful;
    } catch (e) {
      return twilioResponse.successful;
    }
  }

  verifyPhoneNumber(phoneNumber, otp) async {
    var twilioResponse = await _twilioPhoneVerify.verifySmsCode(
        phone: '$phoneNumber', code: '$otp');

    if (twilioResponse.successful == true) {
      if (twilioResponse.verification!.status == VerificationStatus.approved) {
        print('Phone number is approved');
        return "Phone number is verified";
      } else {
        print('Invalid code');
        return "Invalid code";
      }
    } else {
      return "${twilioResponse.errorMessage}";
      //print(twilioResponse.errorMessage);
    }
  }

  // sendCodeToEmail() async {
  //   twilioResponse =
  //       await _twilioPhoneVerify.sendEmailCode('hashimjan033@gmail.com');

  //   if (twilioResponse.successful!) {
  //     print("Code send successfully");
  //   } else {
  //     print(twilioResponse.errorMessage);
  //   }
  // }
}
