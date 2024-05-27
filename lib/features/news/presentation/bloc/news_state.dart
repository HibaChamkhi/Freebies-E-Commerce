part of 'news_bloc.dart';

 class NewsState extends Equatable {
  final List<NewsModel> newsValue;
  final NewsStatus newsStatus;
  final String messages;


  const NewsState(
      {
        this.newsValue = const [],
        this.messages = "",
        this.newsStatus = NewsStatus.loading,

      });

  NewsState copyWith({
    List<NewsModel>? newsValue,
    NewsStatus? newsStatus,
    String? messages,

  }) {
    return NewsState(
      newsValue: newsValue ?? this.newsValue,
      messages: messages ?? this.messages,
      newsStatus: newsStatus ?? this.newsStatus,
    );
  }

  @override
  List<Object> get props => [
    newsValue,
    newsStatus,
    messages,
  ];
}

enum NewsStatus {loading, success, error}
