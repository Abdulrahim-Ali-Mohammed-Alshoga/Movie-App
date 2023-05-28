import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/business_logic/cubit/home/home_cubit.dart';
import 'package:movies/business_logic/cubit/movies_by_genre/movie_by_genre_cubit.dart';
import 'package:movies/business_logic/cubit/search_movies/search_movie_cubit.dart';
import 'package:movies/data/repository/movies_repository.dart';
import 'package:movies/data/web_services/movies_by_genre_web_service.dart';
import 'package:movies/presentation/screens/favorites_screen.dart';

import '../../app/dependency_injection.dart';
import '../../business_logic/cubit/favorite/favorite_cubit.dart';
import '../../business_logic/cubit/genre/genre_cubit.dart';
import '../../business_logic/cubit/now_playing_movies/now_playing_movies_cubit.dart';
import '../../business_logic/cubit/upcoming_movies/upcoming_movies_cubit.dart';
import '../../constants/font.dart';
import '../../constants/mycolor.dart';
import '../../data/network/network_information.dart';
import '../../data/repository/genre_repository.dart';
import '../../data/repository/now_playing_movies_repository.dart';
import '../../data/repository/upcoming_movies_repository.dart';
import '../../data/web_services/genre_web_service.dart';
import '../../data/web_services/now_playing_movies_web_service.dart';
import '../../data/web_services/upcoming_movies_web_services.dart';
import '../widgets/app_bar_widget.dart';
import 'home_screen.dart';

class NavigationBarScreen extends StatefulWidget {
   NavigationBarScreen({Key? key,required this.isSkip}) : super(key: key);
  bool isSkip;
  @override
  State<NavigationBarScreen> createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  int firstPage = 0;
  late ConnectivityResult connectivityResult;
  NowPlayingMovieCubit nowPlayingMovieCubit = NowPlayingMovieCubit(
      NowPlayingMoviesRepository(NowPlayingMoviesWebServices()));
  GenreCubit genreCubit = GenreCubit(GenreRepository(GenreWebService()));

  MoviesByGenreCubit moviesByGenreCubit =
  MoviesByGenreCubit(MoviesByGenreRepository(MoviesByGenreWebService()));
  late List<Widget> page;

  @override
  void initState() {
    // TODO: implement initState

    page = [
      MultiBlocProvider(
          providers: [
        BlocProvider<GenreCubit>(
          create: (context) => genreCubit,
        ),
        BlocProvider<UpcomingMovieCubit>(
          create: (context) => instance<UpcomingMovieCubit>(),
        ),
        BlocProvider<HomeCubit>(
          create: (context) => HomeCubit(instance<NetworkInfo>()),
        ),
        BlocProvider<NowPlayingMovieCubit>(
          create: (context) => instance<NowPlayingMovieCubit>(),
        ),
        BlocProvider<MoviesByGenreCubit>(
          create: (context) => moviesByGenreCubit,
        ),
      ], child: HomeScreen()),
      FavoritesScreen()
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        isSkip: widget.isSkip,
          nameAppBar: RichText(
        text: TextSpan(children: <TextSpan>[
          TextSpan(
              text: "Cinema",
              style: TextStyle(
                  fontFamily: MyFont.mainFont,
                  color: MyColors.white,
                  fontSize: 30.sp)),
          TextSpan(
              text: "Batool",
              style: TextStyle(
                  fontFamily: MyFont.mainFont,
                  color: MyColors.deepOrange,
                  fontSize: 30.sp)),
        ]),
      )),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          IndexedStack(index: firstPage, children: page.map((e) => e).toList())
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: MyColors.deepOrange,
        currentIndex: firstPage,
        unselectedItemColor: MyColors.grey,
        fixedColor: MyColors.white,
        onTap: (v) {
          setState(() {
            firstPage = v;
            //   BlocProvider.of<NewsCubit>(context).close();
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.movie),
              label: "Movies",
              backgroundColor: Colors.deepOrange),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: "Favorites",
              backgroundColor: Colors.deepOrange),
        ],
      ),
    );
  }
}
