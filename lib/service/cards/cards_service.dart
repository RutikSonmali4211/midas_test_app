// import 'dart:convert';
// import 'dart:developer';

// import 'package:midas/model/cards/cards_model.dart';
// import 'package:http/http.dart' as http;

// class CardsService {
//   static Future<List<CardsModel>> getCards() async {
//     var client = http.Client();
//     List<CardsModel> cards = [];
//     try {
//       var response =
//           await client.get(Uri.parse('http://10.0.2.2:3000/auth/cards'));

//       List result = jsonDecode(response.body);

//       for (int i = 0; i < result.length; i++) {
//         CardsModel card =
//             CardsModel.fromJson(result[i] as Map<String, dynamic>);
//         cards.add(card);
//       }

//       return cards;
//     } catch (e) {
//       log(e.toString());
//       return [];
//     }
//   }
// }
