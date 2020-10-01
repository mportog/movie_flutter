import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);
  final url;

//helper to get data from Omdb API
  Future getOmdbData() async {
    http.Response response = await http.get(url);
    print('url: $url');
    if (response.statusCode == 200) 
        return jsonDecode(response.body);
    else 
      print(response.statusCode.toString());        
  } 
  
}
