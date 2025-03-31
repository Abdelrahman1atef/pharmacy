// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorite_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FavoriteState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() favorited,
    required TResult Function() notFavorited,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? favorited,
    TResult? Function()? notFavorited,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? favorited,
    TResult Function()? notFavorited,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Favorited value) favorited,
    required TResult Function(NotFavorited value) notFavorited,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Favorited value)? favorited,
    TResult? Function(NotFavorited value)? notFavorited,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Favorited value)? favorited,
    TResult Function(NotFavorited value)? notFavorited,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavoriteStateCopyWith<$Res> {
  factory $FavoriteStateCopyWith(
          FavoriteState value, $Res Function(FavoriteState) then) =
      _$FavoriteStateCopyWithImpl<$Res, FavoriteState>;
}

/// @nodoc
class _$FavoriteStateCopyWithImpl<$Res, $Val extends FavoriteState>
    implements $FavoriteStateCopyWith<$Res> {
  _$FavoriteStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FavoriteState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$FavoriteStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of FavoriteState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'FavoriteState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() favorited,
    required TResult Function() notFavorited,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? favorited,
    TResult? Function()? notFavorited,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? favorited,
    TResult Function()? notFavorited,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Favorited value) favorited,
    required TResult Function(NotFavorited value) notFavorited,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Favorited value)? favorited,
    TResult? Function(NotFavorited value)? notFavorited,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Favorited value)? favorited,
    TResult Function(NotFavorited value)? notFavorited,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class Initial implements FavoriteState {
  const factory Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$FavoritedImplCopyWith<$Res> {
  factory _$$FavoritedImplCopyWith(
          _$FavoritedImpl value, $Res Function(_$FavoritedImpl) then) =
      __$$FavoritedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FavoritedImplCopyWithImpl<$Res>
    extends _$FavoriteStateCopyWithImpl<$Res, _$FavoritedImpl>
    implements _$$FavoritedImplCopyWith<$Res> {
  __$$FavoritedImplCopyWithImpl(
      _$FavoritedImpl _value, $Res Function(_$FavoritedImpl) _then)
      : super(_value, _then);

  /// Create a copy of FavoriteState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$FavoritedImpl implements Favorited {
  const _$FavoritedImpl();

  @override
  String toString() {
    return 'FavoriteState.favorited()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FavoritedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() favorited,
    required TResult Function() notFavorited,
  }) {
    return favorited();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? favorited,
    TResult? Function()? notFavorited,
  }) {
    return favorited?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? favorited,
    TResult Function()? notFavorited,
    required TResult orElse(),
  }) {
    if (favorited != null) {
      return favorited();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Favorited value) favorited,
    required TResult Function(NotFavorited value) notFavorited,
  }) {
    return favorited(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Favorited value)? favorited,
    TResult? Function(NotFavorited value)? notFavorited,
  }) {
    return favorited?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Favorited value)? favorited,
    TResult Function(NotFavorited value)? notFavorited,
    required TResult orElse(),
  }) {
    if (favorited != null) {
      return favorited(this);
    }
    return orElse();
  }
}

abstract class Favorited implements FavoriteState {
  const factory Favorited() = _$FavoritedImpl;
}

/// @nodoc
abstract class _$$NotFavoritedImplCopyWith<$Res> {
  factory _$$NotFavoritedImplCopyWith(
          _$NotFavoritedImpl value, $Res Function(_$NotFavoritedImpl) then) =
      __$$NotFavoritedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NotFavoritedImplCopyWithImpl<$Res>
    extends _$FavoriteStateCopyWithImpl<$Res, _$NotFavoritedImpl>
    implements _$$NotFavoritedImplCopyWith<$Res> {
  __$$NotFavoritedImplCopyWithImpl(
      _$NotFavoritedImpl _value, $Res Function(_$NotFavoritedImpl) _then)
      : super(_value, _then);

  /// Create a copy of FavoriteState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$NotFavoritedImpl implements NotFavorited {
  const _$NotFavoritedImpl();

  @override
  String toString() {
    return 'FavoriteState.notFavorited()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NotFavoritedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() favorited,
    required TResult Function() notFavorited,
  }) {
    return notFavorited();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? favorited,
    TResult? Function()? notFavorited,
  }) {
    return notFavorited?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? favorited,
    TResult Function()? notFavorited,
    required TResult orElse(),
  }) {
    if (notFavorited != null) {
      return notFavorited();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Favorited value) favorited,
    required TResult Function(NotFavorited value) notFavorited,
  }) {
    return notFavorited(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Favorited value)? favorited,
    TResult? Function(NotFavorited value)? notFavorited,
  }) {
    return notFavorited?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Favorited value)? favorited,
    TResult Function(NotFavorited value)? notFavorited,
    required TResult orElse(),
  }) {
    if (notFavorited != null) {
      return notFavorited(this);
    }
    return orElse();
  }
}

abstract class NotFavorited implements FavoriteState {
  const factory NotFavorited() = _$NotFavoritedImpl;
}
