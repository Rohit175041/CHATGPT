import 'dart:convert';
import 'package:http/http.dart' as http;

class QuesAns{
  //upload to firebase
  static uploadtofirebase(dynamic Answer, dynamic Question) async {
    // Future.delayed(const Duration(seconds: 4));
    const url =
        "https://geotemp-a2491-default-rtdb.asia-southeast1.firebasedatabase.app/location.json";
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({"Question": Question, "Answer": Answer}),
      );
      print(response.body);
      if (response.statusCode == 201) {
        // showSnackBar(Colors.green, "Submit");
        print("location send");
      }
    } catch (e) {
      print(e);
    }
  }
}