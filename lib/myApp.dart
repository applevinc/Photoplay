import 'package:flutter/material.dart';
import 'package:movie_app/newUI/screens/home/home.dart';
import 'package:movie_app/ui/pages/bottomNavBar/events/pageViewState.dart';
import 'package:movie_app/viewModels/movieListViewModel.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PageViewState()),
        ChangeNotifierProvider(create: (context) => MovieListViewModel()),
      ],
      child: LayoutBuilder(
        builder: (context, constraints) => OrientationBuilder(
          builder: (context, orientation) {
            SizerUtil().init(constraints, orientation);
            return MaterialApp(
              title: 'Photoplay',
              theme: ThemeData.dark().copyWith(
                scaffoldBackgroundColor: Colors.black,
              ),
              debugShowCheckedModeBanner: false,
              home: NewHomePage(),
            );
          },
        ),
      ),
    );
  }
}