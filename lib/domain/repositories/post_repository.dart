import 'package:projeto_flutter_test/domain/usecases/get_post.dart';

abstract class PostRepository {
  FuturePostCall  fetchPost(PostParamDTO params);
}