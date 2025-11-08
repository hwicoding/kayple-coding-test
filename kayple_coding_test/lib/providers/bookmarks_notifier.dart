import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kayple_coding_test/services/bookmark_service.dart';

// 북마크 상태관리 클래스
class BookmarksNotifier extends StateNotifier<Set<int>> {
  final BookmarkService _bookmarkService;
  bool _isInitialized = false;

  // 생성자
  BookmarksNotifier(this._bookmarkService) : super({}) {
    _initialize();
  }

  // 초기화
  Future<void> _initialize() async {
    if (!_isInitialized) {
      await _loadBookmarks();
      _isInitialized = true;
    }
  }

  // 북마크 목록 로드
  Future<void> _loadBookmarks() async {
    final bookmarks = await _bookmarkService.getBookmarks();
    state = bookmarks;
  }

  // 북마크 토글
  Future<void> toggleBookmark(int id) async {
    // 초기화가 완료되지 않았다면 대기
    if (!_isInitialized) {
      await _initialize();
    }

    final isBookmarked = await _bookmarkService.isBookmarked(id);
    if (isBookmarked) {
      await _bookmarkService.removeBookmark(id);
    } else {
      await _bookmarkService.addBookmark(id);
    }
    await _loadBookmarks();
  }

  // 북마크 여부 확인
  Future<bool> isBookmarked(int id) async =>
      await _bookmarkService.isBookmarked(id);
}

