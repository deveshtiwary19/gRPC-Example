import 'package:grpc/grpc.dart';
import 'package:grpc_tutorial/grpc_demo.dart';
import 'package:grpc_tutorial/src/generated/album.pbgrpc.dart';

class AlbumService extends AlbumServiceBase {
  @override
  Future<AlbumResponse> getAlbums(
      ServiceCall call, AlbumRequest request) async {
    //Filtering based on id
    if (request.id > 0) {
      final album = findAlbums(request.id);

      return AlbumResponse()..albums.addAll(album);
    }

    //Creating a item to add
    final albumList = albums.map(convertToAlbum).toList();

    // TODO: implement getAlbums
    return AlbumResponse()..albums.addAll(albumList);
  }

  @override
  Future<AlbumResponse> getAlbumsWithPhotos(
      ServiceCall call, AlbumRequest request) async {
    // TODO: implement getAlbumsWithPhotos

    //Filtering based on id
    if (request.id > 0) {
      final album = findAlbums(request.id)[0];
      final albumPhotos = findPhotos(album.id);

      return AlbumResponse()..albums.add(album..photo.addAll(albumPhotos));
    }

    return AlbumResponse()
      ..albums.addAll(albums.map((json) {
        final album = convertToAlbum(json);
        final albumPhotos = findPhotos(album.id);
        return album..photo.addAll(albumPhotos);
      }));
  }
}

List<Photo> findPhotos(int id) {
  return photos
      .where((photo) => photo['albumId'] == id)
      .map(convertToPhoto)
      .toList();
}

//Creating some helper functions

//To find the album with id
List<Album> findAlbums(int id) {
  return albums
      .where((album) => album['id'] == id)
      .map(convertToAlbum)
      .toList();
}

//To convert to album
Album convertToAlbum(Map album) =>
    Album.fromJson('{"1":${album['id']}, "2":"${album['title']}" }');

//To convert to photo
Photo convertToPhoto(Map photo) => Photo.fromJson(
    '{"1": ${photo['albumId']}, "2": ${photo['id']}, "3": "${photo['title']}", "4": "${photo['url']}"}');

//Creating the server that uses the function
void main() async {
  final server = Server([AlbumService()]);
  await server.serve(port: 3800);

  //Printing message, to check if server is ready
  print('Server listening on port ${server.port}');
}
