import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kayple_coding_test/providers/notice_providers.dart';

// 게시물 상세 페이지
class NoticeDetailPage extends ConsumerWidget {
  final int id;

  const NoticeDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noticeAsync = ref.watch(noticeDetailProvider(id));
    final bookmarks = ref.watch(bookmarksProvider);
    final isBookmarked = bookmarks.contains(id);

    return Scaffold(
      // 앱바
      appBar: AppBar(
        title: const Text('게시물 상세'),
      ),
      // 본문
      body: noticeAsync.when(
        data: (notice) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ID
              Text('ID: ${notice.id}'),
              const SizedBox(height: 16),

              // 제목
              Text('제목: ${notice.title}'),
              const SizedBox(height: 16),

              // 본문
              Text('본문: ${notice.body}'),
              const SizedBox(height: 16),

              // 작성자 ID
              Text('작성자 ID: ${notice.userId}'),
              const SizedBox(height: 16),

              // 북마크 표시
              IconButton(
                onPressed: () =>
                    ref.read(bookmarksProvider.notifier).toggleBookmark(id),
                icon: Icon(
                  isBookmarked ? Icons.star : Icons.star_border,
                  color: isBookmarked ? Colors.amber : Colors.grey,
                ),
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('에러 발생: $error'),
        ),
      ),
    );
  }
}
