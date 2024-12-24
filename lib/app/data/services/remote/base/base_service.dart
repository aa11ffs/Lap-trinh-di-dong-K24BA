import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../models/base/base_model.dart';

abstract class BaseService<T extends BaseModel> {
  final CollectionReference collection;

  BaseService(this.collection);
  T fromJson(Map<String, dynamic> json);

  Future<T?> create(T model) async {
    try {
      await collection.doc(model.id).set(model.toJson());
      return model;
    } catch (e) {
      print('Error in BaseService.create: $e');
      return null;
    }
  }

  Future<T?> update(T model) async {
    try {
      await collection.doc(model.id).update(model.toJson());
      return model;
    } catch (e) {
      print('Error in BaseService.update: $e');
      return null;
    }
  }

  Future<bool> delete(String id) async {
    try {
      await collection.doc(id).delete();
      return true;
    } catch (e) {
      print('Error in BaseService.delete: $e');
      return false;
    }
  }

  Future<T?> getById(String id) async {
    try {
      final doc = await collection.doc(id).get();
      if (doc.exists) {
        return fromJson(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      print('Error in BaseService.getById: $e');
      return null;
    }
  }

  Future<List<T>> getAll() async {
    try {
      final querySnapshot =
          await collection.orderBy('createdAt', descending: true).get();

      return querySnapshot.docs
          .map((doc) => fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error in BaseService.getAll: $e');
      return [];
    }
  }

  Future<QuerySnapshot> query({
    List<String>? whereFields,
    List<dynamic>? whereValues,
    String? orderBy,
    bool? descending,
    int? limit,
  }) async {
    Query query = collection;
    if (whereFields != null && whereValues != null) {
      for (var i = 0; i < whereFields.length; i++) {
        query = query.where(whereFields[i], isEqualTo: whereValues[i]);
      }
    }

    if (orderBy != null) {
      query = query.orderBy(orderBy, descending: descending ?? false);
    }
    if (limit != null) {
      query = query.limit(limit);
    }
    return query.get();
  }

  Future<void> batchDelete(List<String> ids) async {
    try {
      final batch = FirebaseFirestore.instance.batch();
      for (var id in ids) {
        batch.delete(collection.doc(id));
      }
      await batch.commit();
    } catch (e) {
      print('Error in BaseService.batchDelete: $e');
      rethrow;
    }
  }

  Future<void> batchUpdate(List<T> models) async {
    try {
      final batch = FirebaseFirestore.instance.batch();
      for (var model in models) {
        batch.update(collection.doc(model.id), model.toJson());
      }
      await batch.commit();
    } catch (e) {
      print('Error in BaseService.batchUpdate: $e');
      rethrow;
    }
  }
}
