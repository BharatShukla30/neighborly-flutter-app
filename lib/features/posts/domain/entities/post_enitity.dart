import 'package:equatable/equatable.dart';
import 'package:neighborly_flutter_app/features/posts/domain/entities/option_entity.dart';

class PostEntity extends Equatable {
  final num id;
  final String userId;
  final String userName;
  final String? title;
  final String? content;
  final String? multimedia; // Made nullable
  final String createdAt;
  final num cheers;
  final num bools;
  final String? proPic;
  final String city;
  final num commentCount;
  final String type;
  final List<dynamic> awardType;
  final List<OptionEntity>? pollOptions;

  const PostEntity({
    required this.city,
    required this.awardType,
    required this.pollOptions,
    required this.type,
    required this.id,
    required this.userId,
    required this.userName,
    required this.commentCount,
    this.title,
    this.content,
    required this.createdAt,
    required this.cheers,
    required this.bools,
    this.proPic,
    this.multimedia, // Made nullable
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        userName,
        pollOptions,
        commentCount,
        awardType,
        type,
        title,
        content,
        createdAt,
        cheers,
        city,
        proPic,
        bools,
        multimedia, // Nullable in props list
      ];
}
