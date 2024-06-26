import 'dart:convert';
import 'dart:io';

import 'package:neighborly_flutter_app/core/constants/constants.dart';
import 'package:neighborly_flutter_app/core/error/exception.dart';
import 'package:http/http.dart' as http;
import 'package:neighborly_flutter_app/core/utils/shared_preference.dart';

import 'upload_remote_data_source.dart';

class UploadRemoteDataSourceImpl implements UploadRemoteDataSource {
  final http.Client client;

  UploadRemoteDataSourceImpl({required this.client});

  @override
  Future<void> uploadPost({
    required String title,
    String? content,
    required String type,
    String? multimedia,
    required List<num> location,
    required String city,
  }) async {
    List<String>? cookies = ShardPrefHelper.getCookie();
    if (cookies == null || cookies.isEmpty) {
      throw const ServerException(message: 'No cookies found');
    }
    String cookieHeader = cookies.join('; ');
    String url = '$kBaseUrl/wall/create-post';

    final response = await client.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Cookie': cookieHeader,
      },
      body: jsonEncode({
        'title': title,
        'content': content,
        'type': type,
        'multimedia': multimedia,
        'location': location,
        'city': city,
      }),
    );

    if (response.statusCode == 200) {
      return;
    } else {
      throw ServerException(message: jsonDecode(response.body)['error']);
    }
  }

  @override
  Future<String> uploadFile({required File file}) async {
    List<String>? cookies = ShardPrefHelper.getCookie();
    if (cookies == null || cookies.isEmpty) {
      throw const ServerException(message: 'No cookies found');
    }
    String cookieHeader = cookies.join('; ');
    String url = '$kBaseUrl/user/upload-file';

    final request = http.MultipartRequest('POST', Uri.parse(url))
      ..headers['Cookie'] = cookieHeader
      ..files.add(
        http.MultipartFile(
          'file',
          file.readAsBytes().asStream(),
          file.lengthSync(),
          filename: file.path.split('/').last,
        ),
      );

    final response = await request.send();
    final responseString = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      return jsonDecode(responseString)['url'];
    } else {
      throw ServerException(message: jsonDecode(responseString)['message']);
    }
  }

  @override
  Future<void> uploadPoll(
      {required String question, required List<String> options}) async {
    List<String>? cookies = ShardPrefHelper.getCookie();
    if (cookies == null || cookies.isEmpty) {
      throw const ServerException(message: 'No cookies found');
    }
    String cookieHeader = cookies.join('; ');
    String url = '$kBaseUrl/wall/create-poll';

    final Map<String, dynamic> body = {
      'question': question,
      'options': options,
    };

    final response = await client.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Cookie': cookieHeader,
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return;
    } else {
      throw ServerException(message: jsonDecode(response.body)['error']);
    }
  }
}
