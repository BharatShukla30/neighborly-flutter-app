import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/community_repositories.dart';

class AddUserCommunityUseCase {
  final CommunityRepositories repository;

  AddUserCommunityUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required String communityId,
  }) async {
    return await repository.addUser(communityId: communityId);
  }
}
