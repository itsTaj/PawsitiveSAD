<?php
session_start(); // Start the session

// Check if the user is logged in
if (!isset($_SESSION['email'])) {
    header('Location: login.php');
    exit();
}

$servername = "localhost";
$username = "root"; 
$password = "";     
$dbname = "pawsitive";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $name = $conn->real_escape_string($_POST['name']);
    $phone_number = $conn->real_escape_string($_POST['phoneNumber']);
    $email = $conn->real_escape_string($_POST['email']);
    $preference = $conn->real_escape_string($_POST['preference']);
    $adoption_date = $conn->real_escape_string($_POST['adoptionDate']);
    $experience = $conn->real_escape_string($_POST['experience']);
    $address = $conn->real_escape_string($_POST['city']);

    // Insert into adopters table
    $sql = "INSERT INTO adopters (name, phone_number, email, preferences, adoption_date, experience, address)
            VALUES ('$name', '$phone_number', '$email', '$preference', '$adoption_date', '$experience', '$address')";

    if ($conn->query($sql) === TRUE) {
        // After successfully adding the adopter, insert certificate details for them
        $certificate_number = uniqid('CERT_');
        $sql_certificate = "INSERT INTO certificates (date_of_issue, adopter_email, certificate_number)
                            VALUES ('$adoption_date', '$email', '$certificate_number')";

        if ($conn->query($sql_certificate) === TRUE) {
            echo "<script>alert('Your Adoption Request Is Pending!');</script>";
            echo "<p>Thank you for your application. You will receive a certificate shortly.</p>";
        } else {
            echo "<script>alert('Error generating certificate: " . $conn->error . "');</script>";
        }
    } else {
        echo "<script>alert('Error: " . $conn->error . "');</script>";
    }
}

$conn->close();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PAWSITIVE Adoption Application</title>
    <link rel="stylesheet" href="style_adopt.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <?php include('templates/header.php'); ?>

    <main>
        <section class="banner">
            <div class="content">
                <h2 class="left">Adoption Application Form</h2>
            </div>
        </section>

        <div>
            <h1>Please Fill Up The Given Form To Adopt Your Chosen Pet</h1>
        </div>

        <div class="page-wrapper">
            <div class="form-container">
                <h2>Adoption Application Form</h2>
                <form id="adoptionForm" method="POST" action="">
                
                    <div class="form-group">
                        <label for="name">Name:</label>
                        <input type="text" id="name" name="name" placeholder="Enter your Name" required>
                    </div>

                    <div class="form-group">
                        <label for="phoneNumber">Phone Number:</label>
                        <input type="tel" id="phoneNumber" name="phoneNumber" placeholder="Enter your Phone Number" required>
                    </div>

                    <div class="form-group">
                        <label for="address">Address:</label>
                        <div class="address-dropdown">
                            <select id="city" name="city" required>
                                <option value="" disabled selected>Select City</option>
                                <option value="Dhaka">Dhaka</option>
                                <option value="Rajshahi">Rajshahi</option>
                                <option value="Barishal">Barishal</option>
                                <option value="Chittagong">Chittagong</option>
                                <option value="Khulna">Khulna</option>
                                <option value="Sylhet">Sylhet</option>
                                <option value="Rangpur">Rangpur</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="email">Email:</label>
                        <input type="email" id="email" name="email" placeholder="Enter your Email" required>
                    </div>

                    <div class="form-group">
                        <label for="preference">Preference:</label>
                        <select id="preferences" name="preference" required>
                            <option value="" disabled selected>Select Preference</option>
                            <option value="Poodle">Poodle</option>
                            <option value="Exotic Shorthair">Exotic Shorthair</option>
                            <option value="Budgerigar">Budgerigar</option>
                            <option value="Bichon Frise">Bichon Frise</option>
                            <option value="Norwegian Forest Cat">Norwegian Forest Cat</option>
                            <option value="Cockatiel">Cockatiel</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="adoptionDate">Date of Adoption:</label>
                        <input type="date" id="adoption_date" name="adoptionDate" required>
                    </div>

                    <div class="form-group">
                        <label for="experience">Previous Experience:</label>
                        <textarea id="experience" name="experience" rows="4" placeholder="Describe any previous experience with pets" required></textarea>
                    </div>

                    <button type="submit">Submit Application</button>
                </form>
            </div>
        </div>
    </main>

    <?php include('templates/footer.php'); ?>

</body>
</html>
