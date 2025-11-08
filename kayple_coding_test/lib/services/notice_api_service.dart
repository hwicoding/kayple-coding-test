import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kayple_coding_test/models/notice_model.dart';

// 게시물 API 서비스
class NoticeApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  // 게시물 목록 조회
  Future<List<Notice>> getNotices() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/posts'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        try {
          final List<dynamic> jsonList = json.decode(response.body);
          return jsonList.map((json) => Notice.fromJson(json)).toList();
        } catch (e) {
          throw Exception('게시물 목록 데이터 파싱에 실패했습니다: $e');
        }
      } else {
        throw Exception(
          '게시물 목록을 불러오는데 실패했습니다 (상태 코드: ${response.statusCode})\n'
          '응답: ${response.body}',
        );
      }
    } catch (e) {
      if (e is Exception) {
        rethrow;
      }
      throw Exception('네트워크 오류가 발생했습니다: $e');
    }
  }

  // 게시물 상세 조회
  Future<Notice> getNoticeById(int id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/posts/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        try {
          final json = jsonDecode(response.body);
          return Notice.fromJson(json);
        } catch (e) {
          throw Exception('게시물 데이터 파싱에 실패했습니다: $e');
        }
      } else {
        throw Exception(
          '게시물을 불러오는데 실패했습니다 (상태 코드: ${response.statusCode})\n'
          '응답: ${response.body}',
        );
      }
    } catch (e) {
      if (e is Exception) {
        rethrow;
      }
      throw Exception('네트워크 오류가 발생했습니다: $e');
    }
  }
}
