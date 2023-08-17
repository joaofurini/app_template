// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on _HomeStore, Store {
  late final _$firstPostAtom =
      Atom(name: '_HomeStore.firstPost', context: context);

  @override
  Post? get firstPost {
    _$firstPostAtom.reportRead();
    return super.firstPost;
  }

  @override
  set firstPost(Post? value) {
    _$firstPostAtom.reportWrite(value, super.firstPost, () {
      super.firstPost = value;
    });
  }

  late final _$postsAtom = Atom(name: '_HomeStore.posts', context: context);

  @override
  List<Post>? get posts {
    _$postsAtom.reportRead();
    return super.posts;
  }

  @override
  set posts(List<Post>? value) {
    _$postsAtom.reportWrite(value, super.posts, () {
      super.posts = value;
    });
  }

  late final _$loadingAtom = Atom(name: '_HomeStore.loading', context: context);

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  @override
  String toString() {
    return '''
firstPost: ${firstPost},
posts: ${posts},
loading: ${loading}
    ''';
  }
}
