import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teno_mindmap/dashboard/bloc/DashboardState.dart';

part 'DashboardEvent.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc(super.initialState);
}
