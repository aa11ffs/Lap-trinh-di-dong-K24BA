import '../../models/base/base_model.dart';

abstract class IBaseRepository<T extends BaseModel> {
  Future<T?> create(T model);
  Future<T?> update(T model);
  Future<bool> delete(String id);
  Future<T?> getById(String id);
  Future<List<T>> getAll();
}

abstract class BaseRepository<T extends BaseModel>
    implements IBaseRepository<T> {
  @override
  Future<T?> create(T model);

  @override
  Future<T?> update(T model);

  @override
  Future<bool> delete(String id);

  @override
  Future<T?> getById(String id);

  @override
  Future<List<T>> getAll();
}
