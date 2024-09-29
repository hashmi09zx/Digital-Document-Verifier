<!-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> -->
    <!DOCTYPE html>
    <html lang="en">
    <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Scan QR Code From Camera</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    </head>
    <body style="background-image: linear-gradient(rgba(0,0,50,0.8), rgba(0,0,50,0.8)),url(459-background.png);">
        <div class="container mt-5">
            <div class="row">
                <div class="col-md-6 offset-md-3">
                    <div class="card">
                        <div class="card-header bg-primary text-white">
                            <h1 class="text-center">Scan QR Code From Camera</h1>
                        </div>
                        <div class="card-body">
                            <div class="text-center">
                                <video id="preview" class="w-100"></video>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Include necessary libraries for QR code scanning -->
        <script src="https://rawgit.com/schmich/instascan-builds/master/instascan.min.js"></script>
        <script>
            // Initialize the camera and start scanning for QR codes
            let scanner = new Instascan.Scanner({ video: document.getElementById('preview') });
            scanner.addListener('scan', function (content) {
                // Once a QR code is scanned, redirect to DisplayDocumentServlet with the scanned document ID
                window.location.href = 'DisplayDocumentServlet?documentId=' + content;
            });
    
            // Function to set willReadFrvequently attribute to true on the canvas context
            function setWillReadFrequently() {
                let canvas = document.createElement('canvas');
                let ctx = canvas.getContext('2d');
                ctx.willReadFrequently = true;
            }
    
            Instascan.Camera.getCameras().then(function (cameras) {
                if (cameras.length > 0) {
                    scanner.start(cameras[0]); // Use the first available camera
                    // Set willReadFrequently attribute
                    setWillReadFrequently();
                } else {
                    console.error('No cameras found.');
                }
            }).catch(function (e) {
                console.error(e);
            });
        </script>
    </body>
    </html>
    