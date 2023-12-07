part of 'scores_cubit.dart';

class ScoresState extends Equatable {
  final bool isLoading;
  final List<Map<String, dynamic>> scores;

  const ScoresState({
    this.isLoading = false,
    this.scores = const [],
  });

  ScoresState copyWith({
    bool? isLoading,
    List<Map<String, dynamic>>? scores,
  }) =>
      ScoresState(
        isLoading: isLoading ?? this.isLoading,
        scores: scores ?? this.scores,
      );

  @override
  List<Object> get props => [isLoading, scores];
}
