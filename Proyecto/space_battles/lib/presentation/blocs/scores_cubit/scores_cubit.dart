import 'package:equatable/equatable.dart';
import 'package:space_battles/infrasctructure/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'scores_state.dart';

class ScoresCubit extends Cubit<ScoresState> {
  ScoresCubit() : super(const ScoresState());

  void getScores() {
    emit(state.copyWith(isLoading: true, scores: []));
    List<Map<String, dynamic>> scores = [];
    FirestoreService().getScores('scores').then((value) {
      for (var element in value.docs) {
        Map<String, dynamic> documentData = element.data();
        documentData['id'] = element.id;
        scores.add(documentData);
      }
    }).then((value) {
      emit(state.copyWith(isLoading: false, scores: scores));
    });
  }

  Future<void> addScore(String email, int score) async {
    await FirestoreService().addScore('scores', email, score);
    getScores();
  }
}
