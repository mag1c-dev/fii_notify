/// {@template cache_client}
/// An in-memory cache client.
/// {@contemplate}
class Cache {
  /// {@macro cache_client}
  Cache() : _cache = <String, Object>{};

  final Map<String, Object> _cache;

  /// Writes the provide [key], [value] pair to the in-memory cache.
  /// Remove value when pass [value] null
  void write<T extends Object>({required String key, required T? value}) {
    if (value == null) {
      _cache.remove(key);
    } else {
      _cache[key] = value;
    }
  }

  /// Looks up the value for the provided [key].
  /// Defaults to `null` if no value exists for the provided key.
  T? read<T extends Object>({required String key}) {
    final value = _cache[key];
    if (value is T) return value;
    return null;
  }
}
