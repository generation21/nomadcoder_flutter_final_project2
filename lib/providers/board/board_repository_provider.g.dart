// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$boardRepositoryHash() => r'46e87376a7dac648ef18954fa9ccfcb7ba9560f7';

/// See also [boardRepository].
@ProviderFor(boardRepository)
final boardRepositoryProvider = AutoDisposeProvider<BoardRepository>.internal(
  boardRepository,
  name: r'boardRepositoryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$boardRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BoardRepositoryRef = AutoDisposeProviderRef<BoardRepository>;
String _$boardListProviderHash() => r'18acf7b470688773eaa18482c216d5b5ba57bfd9';

/// See also [boardListProvider].
@ProviderFor(boardListProvider)
final boardListProviderProvider =
    AutoDisposeFutureProvider<List<BoardModel>>.internal(
      boardListProvider,
      name: r'boardListProviderProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$boardListProviderHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BoardListProviderRef = AutoDisposeFutureProviderRef<List<BoardModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
