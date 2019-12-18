import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:crud_flutter_list_generator/crud_flutter_list_generator.dart';
import 'package:source_gen/source_gen.dart';
import 'package:source_gen/src/constants/reader.dart';

import 'class_source.dart';

class ListFlutterGenerator extends GeneratorForAnnotation<ListEntity> {
  @override
  generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    return GenerateListFlutterClass(element.name).setTitlePage(element.name).build();    
  }

}