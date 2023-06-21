import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/business_logic/cubit/home/home_cubit.dart';
import 'package:movies/business_logic/cubit/movies_by_genre/genre_movies_cubit.dart';
import 'package:movies/constants/color_manager.dart';
import 'package:movies/presentation/screens/favorites_screen.dart';
import '../../app/dependency_injection.dart';
import '../../business_logic/cubit/genre/genre_cubit.dart';
import '../../business_logic/cubit/now_playing_movies/now_playing_movies_cubit.dart';
import '../../business_logic/cubit/upcoming_movies/upcoming_movies_cubit.dart';
import '../../constants/font.dart';
import '../../constants/screen_name.dart';
import '../../data/network/network_information.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/bottom_navigation_bar_item_widget.dart';
import 'home_screen.dart';

class NavigationBarScreen extends StatefulWidget {
  NavigationBarScreen({Key? key, required this.isSkip}) : super(key: key);
  bool isSkip;

  @override
  State<NavigationBarScreen> createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  int firstPage = 0;
  late ConnectivityResult connectivityResult;

  late List<Widget> page;

  @override
  void initState() {
    // TODO: implement initState

    page = [
      MultiBlocProvider(providers: [
        BlocProvider<GenreCubit>(
          create: (context) => instance<GenreCubit>(),
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
        BlocProvider<GenreMoviesCubit>(
          create: (context) => instance<GenreMoviesCubit>(),
        ),
      ], child: const HomeScreen()),
      const FavoritesScreen(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, ScreenName.trendingScreen);
        },
        backgroundColor: ColorManager.deepOrange,
        child: const Icon(Icons.local_fire_department,
            color: ColorManager.whiteOpacity90),
      ),
      appBar: AppBarWidget(
          isSkip: widget.isSkip,
          nameAppBar: RichText(
            text: TextSpan(children: <TextSpan>[
              TextSpan(
                  text: "Cinema",
                  style: TextStyle(
                      fontFamily: MyFont.mainFont,
                      color: ColorManager.white,
                      fontSize: 30.sp)),
              TextSpan(
                  text: "Batool",
                  style: TextStyle(
                      fontFamily: MyFont.mainFont,
                      color: ColorManager.deepOrange,
                      fontSize: 30.sp)),
            ]),
          )),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          IndexedStack(index: firstPage, children: page.map((e) => e).toList())
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        height: 55,
        color: ColorManager.greyOpacity10,
        elevation: 0,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            // Left Tab bar icons
            BottomNavigationBarItemWidget(
                icon: Icons.movie,
                label: "Movies",
                onPressed: () {
                  setState(() {
                    firstPage = 0;
                  });
                },
                isSelected: firstPage == 0),
            // Right Tab bar icons
            BottomNavigationBarItemWidget(
                label: "Favorites",
                icon: Icons.favorite,
                onPressed: () {
                  setState(() {
                    firstPage = 1;
                  });
                },
                isSelected: firstPage == 1),
          ],
        ),
      ),
    );
  }
}
// bottomNavigationBar: BottomNavigationBar(
// type: BottomNavigationBarType.fixed,
// backgroundColor: ColorManager.greyOpacity10,
// elevation: 1,
// currentIndex: firstPage,
// unselectedItemColor: ColorManager.grey,
// fixedColor: ColorManager.white,
// onTap: (v) {
// setState(() {
// firstPage = v;
// //   BlocProvider.of<NewsCubit>(context).close();
// });
// },
// items: const [
// BottomNavigationBarItem(
// icon: Icon(Icons.movie),
// label: "Movies",
// backgroundColor: ColorManager.deepOrange),
// BottomNavigationBarItem(
// icon: Icon(Icons.favorite),
// label: "Favorites",
// backgroundColor: ColorManager.deepOrange),
// ],
// ),
