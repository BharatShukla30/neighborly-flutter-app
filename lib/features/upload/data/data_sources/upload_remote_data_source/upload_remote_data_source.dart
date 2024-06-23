import 'dart:io';

abstract class UploadRemoteDataSource {
  Future<void> uploadPost(
      {String? content,
      String? title,
      String? multimedia,
      required List<num> location});

  Future<String> uploadFile({required File file});
  Future<void> uploadPoll(
      {required String question, required List<String> options});
}