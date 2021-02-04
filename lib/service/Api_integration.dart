import 'package:http/http.dart' as http;

class NewsIntegration {
  Future newsData(String code) async {
    final url =
        'https://newsapi.org/v2/top-headlines?country=$code&apiKey=37d37262cd8b457fa9771769612fec35';
    var response = await http.get(url);
    print(response.body);
  }
}

// class ApiIntegration {
//   List<CountryNews> news = [];
//   Future<CountryNews> countryData(String code) async {
//     final url =
//         'https://newsapi.org/v2/top-headlines?country=$code&apiKey=37d37262cd8b457fa9771769612fec35';
//     var response = await http.get(url);
//     final countryNews = countryNewsFromJson(response.body);
//     print(countryNews.articles);
//     news.add(countryNews);
//     print(countryNews.articles.length);
//   }
// }
