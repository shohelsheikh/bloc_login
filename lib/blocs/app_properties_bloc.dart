import 'dart:async';

final appBloc = AppPropertiesBloc();

class AppPropertiesBloc{
  // StreamController<String> _title = StreamController<String>(); // i can' use more than places

  StreamController<String> _title = StreamController<String>.broadcast(); // i use it ever wherer
  StreamController<String> _appbartitle = StreamController<String>.broadcast();

   Stream<String> get titleStream => _title.stream;
   Stream<String> get appbartitle => _appbartitle.stream;

  updateTitle(String newTitle){
    _title.sink.add(newTitle);
  }

  updateappbartitle(String newTitle){
    _appbartitle.sink.add(newTitle);
  }

  dispose() {
    _title.close();
  }




}