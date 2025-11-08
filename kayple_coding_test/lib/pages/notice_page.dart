import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kayple_coding_test/providers/notice_providers.dart';

// 게시물 목록 페이지
class NoticePage extends ConsumerWidget {
  const NoticePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noticesAsync = ref.watch(noticesProvider);
    final bookmarks = ref.watch(bookmarksProvider);

    return Scaffold(
      // 앱바
      appBar: AppBar(
        title: const Text('게시물 목록'),
      ),
      // 본문
      body: noticesAsync.when(
        data: (notices) => ListView.builder(
          itemCount: notices.length,
          itemBuilder: (context, index) {
            final notice = notices[index];
            final isBookmarked = bookmarks.contains(notice.id);

            // 카드
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, '/post/${notice.id}'),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ID
                      Text('ID: ${notice.id}'),
                      const SizedBox(height: 8),

                      // 제목
                      Text('제목: ${notice.title}'),
                      const SizedBox(height: 8),

                      // 북마크 표시
                      IconButton(
                        onPressed: () => ref
                            .read(bookmarksProvider.notifier)
                            .toggleBookmark(notice.id),
                        icon: Icon(
                          isBookmarked ? Icons.star : Icons.star_border,
                          color: isBookmarked ? Colors.amber : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('에러 발생: $error'),
        ),
      ),
    );
  }
}
