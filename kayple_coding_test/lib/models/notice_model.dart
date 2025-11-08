// 게시물 모델
class Notice {
  final int userId; // 작성자 ID
  final int id; // 게시물 ID
  final String title; // 제목
  final String body; // 본문

  Notice({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory Notice.fromJson(Map<String, dynamic> json) {
    return Notice(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }
}
