import 'package:grpc/grpc.dart';
import 'package:grpc_tutorial/grpc_demo.dart';
import 'package:grpc_tutorial/src/generated/album.pbgrpc.dart';

void main() async {
  final channel = ClientChannel(
    'localhost',
    port: 3800,
    options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
  );

  final stub = AlbumServiceClient(channel);

  //Awaiting on stub, for response
  // var response = await stub.getAlbums(AlbumRequest()..id = 1);

  // print('Response recieved: ${response.writeToJson()}');

  var response2 = await stub.getAlbumsWithPhotos(AlbumRequest()..id = 3);

  print('Got response! ${response2}');
  print('Got resonse! ${response2.albums[0]}');
  print('Got resonse! ${response2.albums[0].writeToJson()}');
  print('Got resonse! ${response2.albums[0].writeToJsonMap()}');

  //Invoking the connection
  await channel.shutdown();
}
