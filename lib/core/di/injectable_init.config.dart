// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../feature/data/datasource/books_api_client.dart' as _i1056;
import '../../feature/data/repositories/default_books_repository.dart'
    as _i1010;
import '../../feature/domain/repositories/books_repository.dart' as _i158;
import '../../feature/domain/usecases/get_authors_by_query.dart' as _i830;
import '../../feature/presentation/authors/bloc/authors_view_bloc.dart'
    as _i579;
import 'api_module.dart' as _i804;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final apiModule = _$ApiModule();
    gh.lazySingleton<_i361.Dio>(() => apiModule.dio());
    gh.lazySingleton<_i1056.BooksApiClient>(
      () => apiModule.booksApiClient(gh<_i361.Dio>()),
    );
    gh.singleton<_i158.BooksRepository>(
      () => _i1010.DefaultBooksRepository(gh<_i1056.BooksApiClient>()),
    );
    gh.singleton<_i830.GetAuthorsByQuery>(
      () => _i830.GetAuthorsByQuery(gh<_i158.BooksRepository>()),
    );
    gh.factory<_i579.AuthorsViewBloc>(
      () => _i579.AuthorsViewBloc(
        getAuthorsByQuery: gh<_i830.GetAuthorsByQuery>(),
      ),
    );
    return this;
  }
}

class _$ApiModule extends _i804.ApiModule {}
