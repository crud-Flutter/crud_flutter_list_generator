import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/list_stateless_flutter_generator.dart';
import 'src/list_stateful_flutter_generator.dart';

Builder listStatelessFlutterBuilder(BuilderOptions options) =>
    LibraryBuilder(ListStatelessFlutterGenerator(),
        generatedExtension: '.list.stateless.dart');
Builder listStateFulFlutterBuilder(BuilderOptions options) =>
    LibraryBuilder(ListStatefulFlutterGenerator(),
        generatedExtension: '.list.stateful.dart');
