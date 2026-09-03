final class SseFrame {
  const SseFrame({this.id, this.event, required this.data, this.retry});
  final String? id;
  final String? event;
  final String data;
  final Duration? retry;
}
