import 'package:get/get.dart';

class SpEarningController extends GetxController {
  var transactions = <Map<String, String>>[].obs;
  @override
  void onInit() {
    super.onInit();
    loadTransctions();
  }

  void loadTransctions() {
    transactions.addAll([
      {
        'type': 'Cash - in',
        'amount': '\$100.00',
        'card': 'From Visa Card',
        'transactionId': '5621456325542',
        'date': '17 Sep 2025',
        'time': '10:30 am',
      },
      {
        'type': 'Cash - in',
        'amount': '\$150.00',
        'card': 'From Visa Card',
        'transactionId': '5621456000554',
        'date': '22 Sep 2025',
        'time': '12:30 am',
      },
      {
        'type': 'Cash - in',
        'amount': '\$100.00',
        'card': 'From Visa Card',
        'transactionId': '5621456325542',
        'date': '17 Sep 2025',
        'time': '10:30 am',
      },
      {
        'type': 'Cash - in',
        'amount': '\$150.00',
        'card': 'From Visa Card',
        'transactionId': '5621456000554',
        'date': '22 Sep 2025',
        'time': '12:30 am',
      },
      {
        'type': 'Cash - in',
        'amount': '\$150.00',
        'card': 'From Visa Card',
        'transactionId': '5621456000554',
        'date': '22 Sep 2025',
        'time': '12:30 am',
      },
      {
        'type': 'Cash - in',
        'amount': '\$150.00',
        'card': 'From Visa Card',
        'transactionId': '5621456000554',
        'date': '22 Sep 2025',
        'time': '12:30 am',
      },
      {
        'type': 'Cash - in',
        'amount': '\$2000.00',
        'card': 'From Visa Card',
        'transactionId': '562145600asdfsa4',
        'date': '25 Sep 2025',
        'time': '01:30 am',
      },
    ]);
  }
}
