import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kayple_coding_test/models/notice_model.dart';
import 'package:kayple_coding_test/services/notice_api_service.dart';
import 'package:kayple_coding_test/services/bookmark_service.dart';
import 'package:kayple_coding_test/providers/bookmarks_notifier.dart';

// 게시물 API 서비스 상태관리
final noticeApiServiceProvider = Provider<NoticeApiService>(
  (ref) => NoticeApiService(),
);

// 게시물 목록 상태관리
final noticesProvider = FutureProvider<List<Notice>>(
  (ref) async => ref.read(noticeApiServiceProvider).getNotices(),
);

// 게시물 상세 상태관리
final noticeDetailProvider = FutureProvider.family<Notice, int>(
  (ref, id) async => ref.read(noticeApiServiceProvider).getNoticeById(id),
);

// 북마크 서비스 상태관리
final bookmarkServiceProvider = Provider<BookmarkService>(
  (ref) => BookmarkService(),
);

// 북마크 상태관리
final bookmarksProvider = StateNotifierProvider<BookmarksNotifier, Set<int>>(
  (ref) => BookmarksNotifier(
    ref.read(bookmarkServiceProvider),
  ),
);
