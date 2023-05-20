import 'package:movies/presentation/screens/home_screen.dart';

abstract class HomeState{}
class HomeInitialState extends HomeState{}
class HomeLoading extends HomeState{}
class HomeSuccess extends HomeState{}
class HomeFailure extends HomeState{}
class HomeNotConnected extends HomeState{}