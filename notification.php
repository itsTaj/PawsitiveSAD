<?php
session_start(); // Start the session
include('db_connect.php');
// Check if the user is logged in
if (!isset($_SESSION['email'])) {
    header('Location: header.php');
    exit();
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notifications</title>
    <link rel="stylesheet" href="style_notifications.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <?php include('templates/header.php'); ?>

    <main>
        <section class="notification-banner">
            <h1>Notifications</h1>
        </section>
        
        <section class="notifications">
            <div class="notification">
                <i class="fas fa-paw"></i>
                <div>
                    <h2>Adoption Update</h2>
                    <p>Adoption form is in review.</p>
                </div>
            </div>

            <div class="notification">
                <i class="fas fa-paw"></i>
                <div>
                    <h2>Vaccination Update</h2>
                    <p>Your pet's vaccination is due.</p>
                </div>
            </div>

            <div class="notification">
                <i class="fas fa-paw"></i>
                <div>
                    <h2>New Pet Alert</h2>
                    <p>A new pet has arrived in the shelter. Will you have a look?</p>
                </div>
            </div>
        </section>
    </main>

    <?php include('templates/footer.php'); ?>
</body>
</html>
