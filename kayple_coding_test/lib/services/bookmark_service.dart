import 'package:shared_preferences/shared_preferences.dart';

// 북마크 서비스
class BookmarkService {
  static const String _bookmarkKey = 'bookmarks';

  // 북마크 목록 조회
  Future<Set<int>> getBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarksJson = prefs.getStringList(_bookmarkKey) ?? [];
    return bookmarksJson.map((e) => int.parse(e)).toSet();
  }

  // 북마크 추가
  Future<void> addBookmark(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarks = await getBookmarks();
    bookmarks.add(id);
    await prefs.setStringList(
      _bookmarkKey,
      bookmarks.map((e) => e.toString()).toList(),
    );
  }

  // 북마크 삭제
  Future<void> removeBookmark(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarks = await getBookmarks();
    bookmarks.remove(id);
    await prefs.setStringList(
      _bookmarkKey,
      bookmarks.map((e) => e.toString()).toList(),
    );
  }

  // 북마크 여부 확인
  Future<bool> isBookmarked(int id) async =>
      (await getBookmarks()).contains(id);
}
