import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kayple_coding_test/pages/notice_page.dart';
import 'package:kayple_coding_test/pages/notice_detail.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kayple Coding Test',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // 초기 라우트
      initialRoute: '/',
      // 라우트
      routes: {
        '/': (context) => const NoticePage(),
      },
      // 라우트 생성
      onGenerateRoute: (settings) {
        if (settings.name?.startsWith('/post/') ?? false) {
          final idString = settings.name?.split('/post/').last;
          final id = int.tryParse(idString ?? '');
          if (id != null) {
            return MaterialPageRoute(
              builder: (context) => NoticeDetailPage(id: id),
              settings: settings,
            );
          }
        }
        return null;
      },
    );
  }
}
