import 'package:code_builder/code_builder.dart';
import 'package:crud_flutter_list_generator/crud_flutter_list_generator.dart';
import 'package:crud_generator/crud_generator.dart';

class ListStatelessFlutterGenerator
    extends GenerateFlutterWidgetForAnnotation<ListEntity> {
  @override
  String generateName() => '${element.name}ListPage';

  @override
  void optionalClassInfo() {
    extend = refer('flutter.StatelessWidget');
  }

  @override
  void generateMethods() {
    var drawer = getAnnotationValue('drawer')?.boolValue;
    var titlePage = getAnnotationValue('titlePage')?.stringValue;
    var create = getAnnotationValue('create')?.boolValue;
    titlePage ??= '${element.name}s';
    drawer ??= false;
    create ??= true;
    addImportPackage('${element.name.toLowerCase()}.list.stateful.dart');
    var fab;
    if (create) {
      addImportPackage('${element.name.toLowerCase()}.form.stateful.dart');
      addImportPackage('package:bloc_pattern/bloc_pattern.dart');
      if (!manyToMany) {
        addImportPackage('${element.name.toLowerCase()}.bloc.dart');
      }
      fab = instanceFab(Code('flutter.Icon(flutter.Icons.add)'), Code('''(){
              BlocProvider.getBloc<${element.name}${manyToManyPosFix}Bloc>()
              .$entityInstance = null;
              flutter.Navigator.push
              (context, flutter.MaterialPageRoute
              (builder: (context) => ${element.name}FormPage()));}'''));
    }
    if (drawer) {
      addImportPackage('../drawer.dart');
    }
    methodBuild(Code(instanceScaffold(titlePage,
        body: Code('body: ${element.name}ListFulPage(),'),
        fab: fab,
        drawer: drawer)));
  }

  @override
  void generateConstructors() {}

  @override
  void generateFields() {}

  @override
  ListStatelessFlutterGenerator instance() => null;
}
