import 'package:code_builder/code_builder.dart';
import 'package:crud_flutter_list_generator/crud_flutter_list_generator.dart';
import 'package:crud_generator/crud_generator.dart';

class ListStateFlutterBuilder
    extends GenerateFlutterWidgetForAnnotation<ListEntity> {
  @override
  String generateName() => '${element.name}ListFulPageState';

  @override
  void optionalClassInfo() {
    addImportPackage('${element.name.toLowerCase()}.list.stateful.dart');
    extend = refer('flutter.State<${element.name}ListFulPage>');
  }

  @override
  void generateFields() {
    addImportPackage('package:bloc_pattern/bloc_pattern.dart');
    addImportPackage('${element.name.toLowerCase()}.bloc.dart');
    declareField(
      refer('${element.name}Bloc'),
      '_bloc',
      assignment: Code('BlocProvider.getBloc<${element.name}Bloc>()'),
    );
  }

  @override
  void generateMethods() {
    // methodDispose();
    addImportPackage('${element.name.toLowerCase()}.entity.dart');
    addImportPackage('${element.name.toLowerCase()}.form.stateful.dart');
    var buildCode =
        StringBuffer('''return flutter.StreamBuilder<List<$entityClass>>(
      stream: _bloc.list,
      builder: (context, snapshot) {
        if (!snapshot.hasData) 
          return flutter.Center(child: flutter.CircularProgressIndicator());      
      return flutter.ListView(
        children: snapshot.data.map(($entityInstance) {
          return flutter.ListTile(
            onTap: () {
              _bloc.$entityInstance = $entityInstance;
              flutter.Navigator.push
              (context, flutter.MaterialPageRoute
              (builder: (context) => ${element.name}FormPage()));},
    ''');
    try {
      buildCode.writeln(
          '''title: flutter.Text
          ($entityInstance.${getAnnotationValue("listTitle").stringValue}),''');
    } finally {
      try {
        buildCode.writeln(
            '''subtitle: flutter.Text($entityInstance.${getAnnotationValue
            ("listSubTitle").stringValue}),''');
      } catch (e) {} finally {
        buildCode.writeln(''');
        }).toList()
        );
        },
        );''');
        methodBuild(Code(buildCode.toString()));
      }
    }
  }

  @override
  void generateConstructors() {}

  @override
  GenerateClassForAnnotation instance() => null;
}
