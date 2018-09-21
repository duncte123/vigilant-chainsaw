<?php /** @noinspection SqlNoDataSourceInspection, SqlDialectInspection */

if (isset($_POST["fname"], $_POST["lname"], $_POST["email"], $_POST["message"], $_POST["g-recaptcha-response"]) &&
    !isEmpty($_POST["fname"], $_POST["lname"], $_POST["email"], $_POST["message"], $_POST["g-recaptcha-response"])) {

    $curl = curl_init();
    curl_setopt_array($curl, [
        CURLOPT_RETURNTRANSFER => 1,
        CURLOPT_URL => 'https://www.google.com/recaptcha/api/siteverify',
        CURLOPT_POST => 1,
        CURLOPT_POSTFIELDS => [
            //This key is public to run tests on
            // https://developers.google.com/recaptcha/docs/faq#id-like-to-run-automated-tests-with-recaptcha-v2-what-should-i-do
            'secret' => "6LeIxAcTAAAAAGG-vFI1TnRWxMZNFuojJ4WifJWe",
            'response' => $_POST["g-recaptcha-response"],
            "remoteip" => $_SERVER["HTTP_CF_CONNECTING_IP"],
        ],
    ]);

    $chapRes = json_decode(curl_exec($curl));
    curl_close($curl);

    if ($chapRes->success != true) {
        die("Captcha check failed, please try again later");
    }

    if (!filter_var($_POST["email"], FILTER_VALIDATE_EMAIL)) {
        die("That is not a valid email address.");
    }

    $sqlFields = [
        "fname" => $_POST["fname"],
        "lname" => $_POST["lname"],
        "email" => $_POST["email"],
        "message" => $_POST["message"],
        "ip" => $_SERVER["HTTP_CF_CONNECTING_IP"],
    ];

    $sql = "INSERT INTO guestbook VALUES(default, :fname , :lname, :email, NULL , :message, :ip , default)";

    if (isset($_POST["website"]) && !empty($_POST["website"])) {
        $sqlFields += ["website" => $_POST["website"]];
        $sql = "INSERT INTO guestbook VALUES(default, :fname , :lname , :email , :website , :message, :ip , default)";
    }

    try {
        $db = new PDO("mysql:hostname=localhost;dbname=guestbook", "root", "");

        $statement = $db->prepare($sql);

        if ($statement->execute($sqlFields)) {
            die("success");
        } else {
            die("Entry could not be saved in the database");
        }
    } catch (PDOException $e) {
        die($e->getMessage());
    }
} else {
    die("Some required fields where not set or where empty.");
}

/**
 * @param array ...$items the items to check
 *
 * @return bool true if one the items is empty
 */
function isEmpty(...$items)
{

    foreach ($items as $item) {
        if (empty($item)) {
            return true;
        }
    }

    return false;
}