import 'package:equatable/equatable.dart';
import 'package:space_battles/infrasctructure/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'scores_state.dart';

class ScoresCubit extends Cubit<ScoresState> {
  ScoresCubit() : super(const ScoresState());

  void getScores(String collectionPath) {
    emit(state.copyWith(isLoading: true, scores: []));
    List<Map<String, dynamic>> scores = [];
    FirestoreService().getScores(collectionPath).then((value) {
      for (var element in value.docs) {
        Map<String, dynamic> documentData = element.data();
        documentData['id'] = element.id;
        scores.add(documentData);
      }
    }).then((value) {
      emit(state.copyWith(isLoading: false, scores: scores));
    });
  }

  Future<void> addScores(String collectionPath, String email, int score) async {
    await FirestoreService().addScore(collectionPath, email, score);
    getScores(collectionPath);
  }
}
