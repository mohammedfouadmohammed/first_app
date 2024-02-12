import 'package:bloc/bloc.dart';
import 'package:first_app/layout/news_app/cubit/cubit.dart';
import 'package:first_app/modules/messenger/Messenger_design.dart';
import 'package:first_app/modules/bmi_result/bmi_result_scree.dart';
import 'package:first_app/modules/counter/counter_screen.dart';
import 'package:first_app/modules/home/home_screen.dart';
import 'package:first_app/modules/login/login_screen.dart';
import 'package:first_app/modules/user/user_screen.dart';
import 'package:first_app/shared/Network/local/cache_helper.dart';
import 'package:first_app/shared/Network/remote/dio_helper.dart';
import 'package:first_app/shared/block_observe.dart';
import 'package:first_app/shared/cubit/cubit.dart';
import 'package:first_app/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'layout/news_app/news_layout.dart';
import 'layout/todo_app/todo_layout.dart';
import 'modules/bmi/bmi_calculator.dart';
import 'package:flutter/widgets.dart';

void main() async {
     //بيتاكد ان كل حاجة هنا في الميثود خلصت وبعدين يفتح الاب
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
 await CacheHelper.init();

 bool? isDark = CacheHelper.getBoolean(key: 'isDark');

  runApp( Myapp(isDark!));//
}
//  StatelessWidget
 // StatefulWidget
class Myapp extends StatelessWidget//this come  from library 'package:flutter/material.dart' calling from (important)
{
  final bool isDark;
  Myapp(this.isDark);


  @override
  Widget build(BuildContext context)
  {
  return MultiBlocProvider(
    providers: [
      BlocProvider(create: (context)=>  NewsCubit()..getBusiness()..getSports()..getScience(), ),
      BlocProvider(create: (BuildContext context) => AppsCubit()..changeAppMode(fromShared: isDark,),),
    ],
    child: BlocConsumer<AppsCubit, AppStates>(
      listener: (context, state) {  },
      builder: (context, state) {
        return MaterialApp(
          debugShowMaterialGrid: false,
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.deepOrange,
              foregroundColor: Colors.white,
            ),
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
              titleSpacing: 20.0,
              backgroundColor: Colors.white,
              elevation: 0.0,
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
              ),
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.deepOrange,
              unselectedItemColor: Colors.blueGrey,
              elevation: 20.0,
              backgroundColor: Colors.white,
            ),
            textTheme: TextTheme(
              bodyLarge: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          darkTheme: ThemeData(
            primarySwatch: Colors.deepOrange,
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.deepOrange,
              foregroundColor: Colors.white,
            ),
            scaffoldBackgroundColor: Color(0xFF333739), //add0xFF before the hex code
            appBarTheme: AppBarTheme(
              titleSpacing: 20.0,
              backgroundColor: Color(0xFF333739),
              elevation: 0.0,
              iconTheme: IconThemeData(
                color: Colors.grey,
              ),
              titleTextStyle: TextStyle(
                color: Colors.grey,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Color(0xFF333739),
                statusBarIconBrightness: Brightness.light,
              ),
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.deepOrange,
              unselectedItemColor: Colors.grey,
              elevation: 20.0,
              backgroundColor: Color(0xFF333739),
            ),
            textTheme: TextTheme(
              bodyLarge: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
          ),
          themeMode: AppsCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          home:   Directionality(
            textDirection: TextDirection.ltr,
            child: NewsLayout(),
          ),
        );
      },
    ),
  );
  }
}
