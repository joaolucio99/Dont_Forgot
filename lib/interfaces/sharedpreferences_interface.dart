abstract class ISharedPreference{
  Future get(String key);
  Future delete(String key);
  Future put(String key, dynamic value);
}