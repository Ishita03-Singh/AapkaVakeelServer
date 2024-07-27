import 'dart:convert';
import 'dart:io';

void main() async {
  // Set up the server to listen on port 8080
  // Create a handler for serving static files
   // Create a handler for serving static files

      
  var server = await HttpServer.bind(
    '192.168.1.141',
    8080,
  );
  print('Listening on ${server.address.host}:${server.port}');

  // Handle requests
  await for (HttpRequest request in server) {
    if (request.uri.path == '/getAgreementFiles') {
      // print("recieved call");
      // Specify the file path
      // List all filenames in the directory
      final directoryPath = './AgreementDocument';
      final directory = Directory(directoryPath);

      if (await directory.exists()) {
    
        var list = directory.listSync().whereType<File>().map((file) {
          var fileName = file.uri.pathSegments.last.split(".")[0];
          return fileName.isNotEmpty ? '"$fileName"' : null;
        }).where((fileName) => fileName != null);
          var fileList=[];
        list.forEach((element) {
          if(element!="")
          fileList.add(element);
        });
        // print(fileList);
        // Set the response headers and send the list of filenames
        request.response
          ..headers.contentType = ContentType.json
          ..write(fileList)
          ..close();
      } else {
        // Handle directory not found
        request.response
          ..statusCode = HttpStatus.notFound
          ..write('Directory not found')
          ..close();
      }
  }

  else  if (request.uri.path == '/getAffidavitFiles') {
      // Specify the file path
      // List all filenames in the directory
      final directoryPath = './AffidavitDocument';
      final directory = Directory(directoryPath);

      if (await directory.exists()) {
       
        var list = directory.listSync().whereType<File>().map((file) {
          var fileName = file.uri.pathSegments.last.split(".")[0];
          return fileName.isNotEmpty ? '"$fileName"' : null;
        }).where((fileName) => fileName != null);
          var fileList=[];
        list.forEach((element) {
          if(element!="")
          fileList.add(element);
        });
        // print(fileList);
        // Set the response headers and send the list of filenames
          request.response
          ..headers.contentType = ContentType.json
          ..write(fileList)
          ..close();
      } else {
        // Handle directory not found
        request.response
          ..statusCode = HttpStatus.notFound
          ..write('Directory not found')
          ..close();
      }
  }
 else if (request.uri.path == '/file') {
      // Specify the file path
      final filename = request.uri.queryParameters['fileName'];
      // print(filename);
      final dirname= request.uri.queryParameters['dirName'];
      // print(dirname);


      if (filename != null) {
        // Specify the file path
        final filePath = './$dirname/$filename.pdf';
        // print(filePath);
        
        final file = File(filePath);
        // print(file);

        if (await file.exists()) {
          // Read the file content
          final fileContent = await file.readAsBytes();
          // print(fileContent);

          // Set the response headers and send the file content
          request.response
            // ..headers.contentType = ContentType.text
            ..statusCode = HttpStatus.ok
            ..headers.contentType = ContentType('application', 'pdf')
            ..add(fileContent)
            ..close();
        } else {
          // Handle file not found
          request.response
            ..statusCode = HttpStatus.notFound
            ..write('File not found')
            ..close();
        
}
      }}}
}

// Create a static file handler

