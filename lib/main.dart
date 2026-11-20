import 'package:flutter/material.dart';

import 'app.dart';
import 'app_dependencies.dart';
import 'core/database/app_database.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final database = AppDatabase();
  runApp(PhantomApp(dependencies: AppDependencies.local(database)));
}
