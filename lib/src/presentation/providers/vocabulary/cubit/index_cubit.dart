import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'index_state.dart';

class IndexCubit extends Cubit<IndexState> {
  IndexCubit() : super(const IndexState(index: 0));

  void increment() {
    emit(IndexState(index: state.index + 1));
  }
}
