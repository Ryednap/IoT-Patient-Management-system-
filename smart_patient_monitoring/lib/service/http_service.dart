// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

String host = "localhost:5000";

void createPostRequest(String endpoint, String state) async {
  final client = http.Client();
  try {
    print("Sending POST request");
    final response =
        await client.post(Uri.http(host, endpoint), body: {"state": state});
    final decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
    final uri = Uri.parse(decodedResponse['uri'] as String);
    print(await client.get(uri));
  } catch (e) {
    print(e.toString());
  } finally {
    client.close();
  }
}

Future<double> createGetRequest(String endpoint) async {
  final client = http.Client();
  try {
    print("Sending GET request");
    final response = await client.get(Uri.http(host, endpoint));
    final decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
    String value = decodedResponse["field1"];
    value = value.trim();
    value = value.substring(1, value.length - 1);
    return double.parse(value);
    //return value;
  } catch (e) {
    print(e);
    return 0.0;
  } finally {
    client.close();
  }
}
