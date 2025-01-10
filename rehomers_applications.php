<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rehomers Application</title>
    <link rel="stylesheet" href="style_rehomers.css"> <!-- Link to the CSS file -->
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        h2 {
            text-align: center;
            margin-top: 20px;
        }

        .form-container {
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 20px 0;
        }

        .form-box {
            width: 100%;
            max-width: 500px;
            padding: 20px;
            background: #fff; /* Retains a neutral form background */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        .form-box label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .form-box input,
        .form-box select {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .form-box input[type="file"] {
            padding: 5px;
        }

        .form-box input[type="submit"] {
            width: 100%;
            background-color: #4CAF50;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
        }

        .form-box input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <?php include('templates/header.php'); ?>

    <h2>Rehomers Application</h2>

    <div class="form-container">
        <form class="form-box" action="" method="post" enctype="multipart/form-data">
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" required>

            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>

            <label for="phone">Phone:</label>
            <input type="text" id="phone" name="phone" required>

            <label for="pet_choice">Pet Choice:</label>
            <select id="pet_choice" name="pet_choice" required>
                <option value="dog">Dog</option>
                <option value="cat">Cat</option>
                <option value="bird">Bird</option>
            </select>

            <label for="pet_age">Pet Age:</label>
            <input type="text" id="pet_age" name="pet_age" required>

            <label for="pet_picture">Upload Pet Picture:</label>
            <input type="file" id="pet_picture" name="pet_picture" accept="image/*" required>

            <input type="submit" value="Submit Application">
        </form>
    </div>

    <?php include('templates/footer.php'); ?>
</body>
</html>
