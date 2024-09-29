<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Upload QR Code</title>
    <style>
        body {
            width: 100%;
    height: 100vh;
    background-image: linear-gradient(rgba(0,0,50,0.8), rgba(0,0,50,0.8)),url(459-background.png);
    background-size: cover;
    background-position: center;
    background-attachment: fixed;
            padding-top: 50px;
        }

        .container {
            max-width: 600px;
            margin: 50px auto;
            background-color: rgba(0,0,50,0.8);
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 30px;
            /* margin: 15px 0 15px 0; */
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
        }

        form {
            text-align: center;
        }

        label {
            font-weight: bold;
        }

        input[type="file"] {
            margin-bottom: 20px;
            display: none;
        }

        .file-label {
            padding: 8px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .file-label:hover {
            background-color: #45a049;
        }

        .file-selected {
            display: inline-block;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2 style="color: #fff;">Upload QR Code</h2>
        <form action="DecodeQRServlet" method="post" enctype="multipart/form-data">
            <label class="file-label" for="qrFile">Select QR Code Image</label>
            <span id="file-selected" class="file-selected"></span>
            <input type="file" id="qrFile" name="qrFile" accept=".png, .jpg, .jpeg" required>
            
            <input type="submit" value="Decode QR Code">
        </form>
    </div>

    <script>
        const fileInput = document.getElementById('qrFile');
        const fileSelected = document.getElementById('file-selected');

        fileInput.addEventListener('change', function() {
            if (fileInput.files.length > 0) {
                fileSelected.textContent = `File selected: ${fileInput.files[0].name}`;
            } else {
                fileSelected.textContent = '';
            }
        });
    </script>
</body>
</html>
