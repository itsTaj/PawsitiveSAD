<?php
session_start(); // Start the session

// Check if the user is logged in
if (!isset($_SESSION['email'])) {
    header('Location: login.php');
    exit();
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PAWSITIVE Adoption Guidelines</title>
    <link rel="stylesheet" href="style_adopt.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <?php include('templates/header.php'); ?>

    <main>
        <section class="banner">
            <div class="content">
                <h2 class="left">Information for Adopters</h2>
            </div>
        </section>

        <section class="grid grid-1">
            <figure>
                <img src="images/sich.png" alt="">
            </figure>
            <figure>
                <img src="images/3.png" alt="" class="autoRotate">
            </figure>
            <h2 class="autoShow">Adoption Guideline</h2>
            <p>Be 18 years of age or older. Have identification showing your present and current address. Have the knowledge and consent of your landlord, if you rent or lease your residence, proof of official lease agreement is required to show approval that pet(s) are allowed within the residence. Be able and willing to spend the time and money necessary to provide training, medical treatment, and proper care for your pet.</p>
        </section>

        <section class="grid grid-2">
            <div class="autoShow">
                <figure>
                    <img src="images/trio.png" alt="">
                </figure>
                <p>
                    • AWGs should maintain good relations and open communications with adopters to encourage adopters to approach them as soon as possible if they have issues post-adoption.<br><br>
                    Each AWG should develop their own policies relating to the adoption and rehoming of dogs under their care based on the guiding principles above.
                </p>
            </div>
            <div class="autoShow">
                Public health and safety as well as animal health and welfare are priority; where necessary, public health and safety take precedence over animal health and welfare.<br>
                • AWGs should screen and assess individual dogs for their suitability to be rehomed, especially if they have any history of aggression.<br>
                • Biting history (if any) should be assessed using objective assessment tools e.g. Dunbar Dog Bite Scale.<br>
                • Existing medical and behavioural conditions and history should be clearly assessed and made known to all relevant stakeholders before adoption.<br>
                • Pre-adoption screening, adoption processes, and post-adoption support should be robust, and clearly communicated to the adopter.<br>
                • The pre-adoption process should not be rushed, and may include completion of application forms, screening of prospective adopters, matching of prospective adopters to suitable animals, assessment, etc. prior to the decision.<br>
                • It is important to educate adopters on animal health, behaviour, appropriate socialisation and training.<br>
                • Key clauses of adoption agreements should be made transparent to potential adopters at the onset, and adopters should acquaint themselves with the stated obligations early, to minimise misalignment of expectations by both parties.
            </div>
        </section>

    </main>

    <?php include('templates/footer.php'); ?>

</body>
</html>
