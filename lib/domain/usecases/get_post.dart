
import 'package:fpdart/fpdart.dart';
import 'package:projeto_flutter_test/domain/entities/post.dart';
import 'package:projeto_flutter_test/domain/errors/errors.dart';
import 'package:projeto_flutter_test/domain/repositories/post_repository.dart';
typedef FuturePostCall = Future<Either<PostException, List<Post>>>;

abstract class GetPost {
   FuturePostCall call({required PostParamDTO params});
}

class GetPostImpl implements GetPost{

  final PostRepository repository;

  GetPostImpl(this.repository);
  
  @override 
  FuturePostCall call({required PostParamDTO params}) async {
    if (params.page <= 0){ // você não tem paginas menores ou iguais a zero...elas começam com 1
      return Left(InvalidPostParams('Page não pode ser menor que 1'));
    }
    if (params.offset <= 0){ // você não tem paginas menores ou iguais a zero...elas começam com 1
      return Left(InvalidPostParams('offset não pode ser menor que 1'));
    }
    return repository.fetchPost(params);
  }
}

class PostParamDTO {
  final int page;
  final int offset;

  PostParamDTO({required this.page, this.offset = 10});
}