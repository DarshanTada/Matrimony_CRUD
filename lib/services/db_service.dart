import 'package:matrimonycrud/models/persons_model.dart';
import 'package:matrimonycrud/utils/db_helper.dart';

class DBService {
  Future<List<PersonModel>> getPersons() async {
    await DBHelper.init();
    List<Map<String, dynamic>> persons =
        await DBHelper.query(PersonModel.table);

    return persons.map((item) => PersonModel.fromMap(item)).toList();
  }

  Future<List<PersonModel>> getSearch(String a) async {
    await DBHelper.init();

    List<Map<String, dynamic>> persons = await DBHelper.search(a);

    return persons.map((item) => PersonModel.fromMap(item)).toList();
  }

  Future<List<PersonModel>> getfav() async {
    await DBHelper.init();

    List<Map<String, dynamic>> persons = await DBHelper.getfav();

    return persons.map((item) => PersonModel.fromMap(item)).toList();
  }

  Future<bool> setFav(int n, int id) async {
    await DBHelper.init();

    int ret = await DBHelper.setfav(n, id);
    return ret > 0 ? true : false;
  }

  Future<bool> addPerson(PersonModel model) async {
    await DBHelper.init();

    int ret = await DBHelper.insert(PersonModel.table, model);

    return ret > 0 ? true : false;
  }

  Future<bool> updatePerson(PersonModel model) async {
    await DBHelper.init();

    int ret = await DBHelper.update(PersonModel.table, model);

    return ret > 0 ? true : false;
  }

  Future<bool> deletePerson(PersonModel model) async {
    await DBHelper.init();

    int ret = await DBHelper.delete(PersonModel.table, model);

    return ret > 0 ? true : false;
  }
}
