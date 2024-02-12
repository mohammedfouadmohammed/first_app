import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/componets/componets.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

class DoneTasksScreen extends StatelessWidget {
  const DoneTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppsCubit, AppStates>(
      listener: (BuildContext context, AppStates state)
      {  },
      builder: (BuildContext context, AppStates state)
      {
        var tasks = AppsCubit.get(context).doneTasks;
        return tasksBuilder(tasks: tasks,);
      },
    );
  }
}