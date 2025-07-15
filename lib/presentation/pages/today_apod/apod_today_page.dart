import 'package:estudo_clean_arch_nasa/container_injection.dart';
import 'package:estudo_clean_arch_nasa/presentation/bloc/today_apod/today_apod_bloc.dart';
import 'package:flutter/material.dart';

class ApodTodayPage extends StatefulWidget {
  const ApodTodayPage({super.key});

  @override
  State<ApodTodayPage> createState() => _ApodTodayPageState();
}

class _ApodTodayPageState extends State<ApodTodayPage> {
  // chamando o bloc
  late TodayApodBloc _bloc;

  @override
  void initState() {
    _bloc = getIt<TodayApodBloc>();
    _bloc.input.add(FetchApodTodayEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: StreamBuilder<TodayApodState>(
        stream: _bloc.stream,
        builder: (context, snapshopt) {
          TodayApodState? state = snapshopt.data;
          Widget body = Container();

          if (state is LoadingTodayApodState) {
            body = Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ErrorTodayApodState) {
            body = Center(
              child: Text(state.msg),
            );
          }
          if (state is SuccessTodayApodState) {
            body = Column(
              children: [
                Text(state.apod.title ?? ''),
                Text(state.apod.explanation ?? ''),
              ],
            );
          }
          return Scaffold(
            body: body,
          );
        },
      ),
    );
  }
}
