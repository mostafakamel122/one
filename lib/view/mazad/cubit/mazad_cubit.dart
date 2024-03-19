// import 'dart:convert';
import 'package:bloc/bloc.dart';
// import 'package:http/http.dart';

// import '../../../core/cache_helper.dart';
// import '../../../res/constant/AppLinks.dart';

part 'mazad_state.dart';

class MazadCubit extends Cubit<MazadState> {
  MazadCubit() : super(MazadInitial());
}
