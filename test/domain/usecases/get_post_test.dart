import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:projeto_flutter_test/domain/entities/post.dart';
import 'package:projeto_flutter_test/domain/errors/errors.dart';
import 'package:projeto_flutter_test/domain/repositories/post_repository.dart';
import 'package:projeto_flutter_test/domain/usecases/get_post.dart';
import 'package:mocktail/mocktail.dart';

class PostRepositoryMock implements PostRepository {
  @override
  FuturePostCall fetchPost(PostParamDTO params) async  {
    return Right(<Post>[]);
  }

}
void main() {
  final repository = PostRepositoryMock();
  final usecase = GetPostImpl(repository);
  test('deve retornar uma lista de post', () async {
    //arrange
    final params = PostParamDTO(page:1);
    //act
    final result = await usecase.call(params: params);
    //assert
    expect(result.isRight(), true);
    expect(result.fold(id, id), isA<List<Post>>());
  });

  test('deve dar erro se page == 0', () async {
    //arrange
    final params = PostParamDTO(page: 0);
    //act
    final result = await usecase.call(params: params);
    //assert
    expect(result.isLeft(), true);
    
    expect(result.fold(id, id), isA<InvalidPostParams>());
  });
  test('deve dar erro se offset < 1', () async {
    //arrange
    final params = PostParamDTO(page: 1, offset: 0);
    //act
    final result = await usecase.call(params: params);
    //assert
    expect(result.isLeft(), true);
    
    expect(result.fold(id, id), isA<InvalidPostParams>());
  });
}