abstract class InterfaceDao<Type> {
  get stream;

  void add(Type entity);

  void update(Type entity);

  void delete(String id);
}
