import 'package:grpc_tutorial/src/db.dart';
import 'package:grpc_tutorial/src/generated/album.pb.dart';

void main(List<String> args) {
  //Printing with self given(harcoded value) just to check
  final album = Album()
    ..id = 1
    ..title = 'Album title';

  print(album);

  //Printing from the jSON Value

  final album2 =
      Album.fromJson('{"1":${albums[0]['id']}, "2":"${albums[0]['title']}" }');
  print(album2);
}
