part of 'package:flutter_multi_module_di/flutter_multi_module_di.dart';

class Optional<T> extends IterableBase<T> {
  const Optional.absent() : _value = null;

  Optional.of(T value) : _value = value {
    ArgumentError.checkNotNull(value);
  }

  const Optional.fromNullable(T? value) : _value = value;

  final T? _value;

  /// True when this optional contains a value.
  bool get isPresent => _value != null;

  /// True when this optional contains no value.
  bool get isNotPresent => _value == null;

  /// Gets the Optional value.
  ///
  /// Throws [StateError] if [value] is null.
  T get value {
    if (_value == null) {
      throw StateError('value called on absent Optional.');
    }
    return _value!;
  }

  /// Executes a function if the Optional value is present.
  void ifPresent(void ifPresent(T value)) {
    if (isPresent) {
      ifPresent(_value!);
    }
  }

  /// Execution a function if the Optional value is absent.
  void ifAbsent(void ifAbsent()) {
    if (!isPresent) {
      ifAbsent();
    }
  }

  /// Gets the Optional value with a default.
  ///
  /// The default is returned if the Optional is [absent()].
  ///
  /// Throws [ArgumentError] if [defaultValue] is null.
  T or(T defaultValue) {
    return _value ?? defaultValue;
  }

  /// Gets the Optional value, or [null] if there is none.
  T? get orNull => _value;

  /// Transforms the Optional value.
  ///
  /// If the Optional is [absent()], returns [absent()] without applying the transformer.
  ///
  /// The transformer must not return [null]. If it does, an [ArgumentError] is thrown.
  Optional<S> transform<S extends Object>(S transformer(T value)) {
    return _value == null
        ? Optional<S>.absent()
        : Optional<S>.of(transformer(_value!));
  }

  /// Transforms the Optional value.
  ///
  /// If the Optional is [absent()], returns [absent()] without applying the transformer.
  ///
  /// Returns [absent()] if the transformer returns [null].
  Optional<S> transformNullable<S extends Object>(S? transformer(T value)) {
    return _value == null
        ? Optional<S>.absent()
        : Optional<S>.fromNullable(transformer(_value!));
  }

  @override
  Iterator<T> get iterator =>
      isPresent ? <T>[_value!].iterator : Iterable<T>.empty().iterator;

  /// Delegates to the underlying [value] hashCode.
  @override
  int get hashCode => _value.hashCode;

  /// Delegates to the underlying [value] operator==.
  @override
  bool operator ==(Object o) => o is Optional<T> && o._value == _value;

  @override
  String toString() {
    return _value == null
        ? 'Optional { absent }'
        : 'Optional { value: $_value }';
  }
}
