enum DownloadStatus { starting, downloading, success, error }

class FileDownload {
  const FileDownload({
    required this.id,
    required this.name,
    required this.path,
    required this.url,
    required this.size,
    required this.downloaded,
    required this.status,
  });

  final int id;
  final String name;
  final String path;
  final  String url;
  final int size;
  final int downloaded;
  final DownloadStatus status;
}
