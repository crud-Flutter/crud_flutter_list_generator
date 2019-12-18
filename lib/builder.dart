import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/list_flutter_generator.dart';

Builder listStatelessFlutterBuilder(BuilderOptions options) => LibraryBuilder(ListStatelessFlutterGenerator(), generatedExtension: '.list.stateless.dart');