import "package:http/http.dart" as http;
import "dart:convert";
import 'dart:io';
import 'dart:typed_data';
import "package:toonflix/models/webtoon_model.dart";
import "package:toonflix/models/webtoon_detail_model.dart";
import "package:toonflix/models/webtoon_episode_model.dart";

class ApiService {
  static final String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev/";
  static final String today = "today";
  static var header = {
    'User-Agent':
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36',
  };
  static var header_netimage = const {
    'User-Agent':
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36',
    'Referer': 'https://comic.naver.com',
  };
  //static var header_netimage = const {'Referer': 'https://comic.naver.com'};
  static Future<List<WebtoonModel>> getTodaystoons() async {
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse("$baseUrl$today");
    final response = await http.get(url, headers: header);
    if (response.statusCode == 200) {
      final webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        webtoonInstances.add(WebtoonModel.fromJson(webtoon));
      }
      return webtoonInstances;
    }
    throw Error();
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final url = Uri.parse("$baseUrl/$id");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final webtoon = jsonDecode(response.body);
      return WebtoonDetailModel.fromJson(webtoon);
    }
    throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getLatestEpisodesById(
    String id,
  ) async {
    List<WebtoonEpisodeModel> episodesInstances = [];
    final url = Uri.parse("$baseUrl/$id/episodes");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final episodes = jsonDecode(response.body);
      for (var episode in episodes) {
        episodesInstances.add(WebtoonEpisodeModel.fromJson(episode));
      }
      return episodesInstances;
    }
    throw Error();
  }

  // Future<Image> fetchImageWithHeaders(String url) async {
  //   final client = HttpClient();
  //   final request = await client.getUrl(Uri.parse(url));
  //   request.headers.set('User-Agent', 'Mozilla/5.0');
  //   request.headers.set('Referer', 'https://comic.naver.com'); // 예시

  //   final response = await request.close();
  //   if (response.statusCode == 200) {
  //     final bytes = await consolidateHttpClientResponseBytes(response);
  //     return Image.memory(bytes);
  //   } else {
  //     throw Exception('Failed to load image: ${response.statusCode}');
  //   }
  // }
}
