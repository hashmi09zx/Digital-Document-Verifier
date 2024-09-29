<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Registration</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Custom styles -->
    <style>
        body {
            width: 100%;
    height: 100vh;
    background-image: linear-gradient(rgba(0,0,50,0.8), rgba(0,0,50,0.8)),url(459-background.png);
    background-size: cover;
    background-position: center;
    background-attachment: fixed;

        }
        .container {
            margin-top: 20px; 

            position: relative;
    width: 700px;
    height: 600px;
    background: transparent;
    border: 2px solid rgba(225, 225, 225, 0.637);
    border-radius: 5px;
        }

        .container .input-box{
            display: flex;
    justify-content: space-between;
    flex-wrap: wrap;
        }


        .input-box .form-group{
    position: relative;
    width: 48%;
    height: 75px;
    margin: 10px 0;

}



        .form-group label {
            font-weight: bold;
            color: #ffffff;
        }
        .btn-register {
            background-color: #007bff;
            color: #ffffff;
            border: none;
            border-radius: 4px;
            padding: 10px 20px;
            margin-top: 20px;
            cursor: pointer;
            transition: 0.5s;
        }
        .btn-register:hover {
            background-color: transparent;
    border: 2px solid #007bff;
    cursor: pointer;
        }
        .form-control:focus {
            border-color: #007bff;
            box-shadow: none;
        }
        .form-control::placeholder {
            color: #aaa;
        }
        .form-check-input {
            margin-top: 0.3rem;
        }
    </style>
</head>
<body>

<div class="container">
    <h2  style="color: #ffffff;"  class="text-center mb-4">User Registration</h2>
    <form action="RegisterServlet" method="post">
        <div class="input-box">
            <div class="form-group">
                <label for="fullName">Full Name</label>
                <input type="text" class="form-control" id="fullName" name="fullName" required placeholder="Enter your full name">
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" class="form-control" id="email" name="email" required placeholder="Enter your email address">
            </div>
        </div>



        <div class="input-box">
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" class="form-control" id="password" name="password" required placeholder="Enter a password">
            </div>
            <div class="form-group">
                <label for="phoneNumber">Phone Number</label>
                <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" placeholder="Enter your phone number">
            </div>
        </div>



        <div class="input-box">
            <div class="form-group">
                <label for="address">Address</label>
                <textarea class="form-control" id="address" name="address" placeholder="Enter your address"></textarea>
            </div>
            <div class="form-group">
                <label for="dateOfBirth">Date of Birth</label>
                <input type="date" class="form-control" id="dateOfBirth" name="dateOfBirth">
            </div>
        </div>

        
        <div class="input-box">
            <div class="form-group">
                <label for="gender">Gender</label>
                <select class="form-control" id="gender" name="gender">
                    <option value="Male">Male</option>
                    <option value="Female">Female</option>
                    <option value="Other">Other</option>
                </select>
            </div>
            <div class="form-group">
                <label for="governmentIDType">Government ID Type</label>
                <select class="form-control" id="governmentIDType" name="governmentIDType">
                    <option value="Aadhar">Aadhar Card</option>
                    <option value="PAN">PAN Card</option>
                    <option value="Driving License">Driving License</option>
                    <option value="Passport">Passport</option>
                    <option value="Voter ID">Voter ID Card</option>
                    <option value="National ID">National ID Card</option>
                    <!-- Add more options as needed -->
                </select>
            </div>
        </div>
        
        <div class="form-group">
            <label for="governmentIDValue">Government ID Value</label>
            <input type="text" class="form-control" id="governmentIDValue" name="governmentIDValue" placeholder="Enter your government ID">
        </div>
        <button style="color: #ffffff;" type="submit" class="btn btn-register btn-block">Register</button>
    </form>
</div>

<!-- Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
