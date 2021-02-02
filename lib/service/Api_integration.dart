import 'package:http/http.dart' as http;
import 'package:newsapplication/models/country_wise_news.dart';

class ApiIntegration {
  Future<void> countryData(String code) async {
    final url =
        'https://newsapi.org/v2/top-headlines?country=$code&apiKey=37d37262cd8b457fa9771769612fec35';
    var response = await http.get(url);
    final countryNews = countryNewsFromJson(response.body);
    print(countryNews.articles.length);

  }
}
