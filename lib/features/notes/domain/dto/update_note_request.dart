class UpdateNoteRequest {
  final String id;
  final String? title;
  final String? body;

  const UpdateNoteRequest({required this.id, this.title, this.body});
}
