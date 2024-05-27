import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/utils/extensions/map_failure_to_message.dart';
import '../../data/models/news.dart';
import '../../domain/use_cases/get_news_use_case.dart';

part 'news_event.dart';
part 'news_state.dart';
@injectable
class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetNewsUseCase getNewsUseCase ;
  NewsBloc({required this.getNewsUseCase}) : super(const NewsState()) {
    on<NewsEvent>((event, emit) async {
      if (event is GetNewsEvent) {
        emit(state
            .copyWith(newsStatus: NewsStatus.loading, newsValue: []));

        final failureOrSuggestedProducts = await getNewsUseCase();
        failureOrSuggestedProducts.fold(
                (suggestedOrFailure) => emit(state.copyWith(
              messages: mapFailureToMessage(suggestedOrFailure),
              newsStatus: NewsStatus.error,
            )),
                (newsValue) => emit(state.copyWith(
                newsStatus: NewsStatus.success, newsValue: newsValue)));
      }
    });
  }
}
String extractDate(String timestamp) {
  DateTime parsedDate = DateTime.parse(timestamp);
  String formattedDate = "${parsedDate.year}-${parsedDate.month.toString().padLeft(2, '0')}-${parsedDate.day.toString().padLeft(2, '0')}";
  return formattedDate;
}