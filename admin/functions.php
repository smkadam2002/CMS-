<?php

// Check if the function exists before declaring it
if (!function_exists('redirect')) {
    function redirect($location)
    {
        header("Location: " . $location);
        exit;
    }
}

// Check if the function exists before declaring it
if (!function_exists('ifItIsMethod')) {
    function ifItIsMethod($method=null){

        if($_SERVER['REQUEST_METHOD'] == strtoupper($method)){

            return true;

        }

        return false;

    }
}

// Function to check if a user is logged in
if (!function_exists('isLoggedIn')) {
    function isLoggedIn(){

        if(isset($_SESSION['user_role'])){

            return true;

        }

        return false;

    }
}

// Function to check if a user is logged in and redirect if necessary
if (!function_exists('checkIfUserIsLoggedInAndRedirect')) {
    function checkIfUserIsLoggedInAndRedirect($redirectLocation=null){

        if(isLoggedIn()){

            redirect($redirectLocation);

        }

    }
}

// Function to register a user
if (!function_exists('register_user')) {
    function register_user($username, $email, $password){

        global $connection;

        $username = mysqli_real_escape_string($connection, $username);
        $email    = mysqli_real_escape_string($connection, $email);
        $password = mysqli_real_escape_string($connection, $password);

        $password = password_hash( $password, PASSWORD_BCRYPT, array('cost' => 12));

        $query = "INSERT INTO users (username, user_email, user_password, user_role) ";
        $query .= "VALUES('{$username}','{$email}', '{$password}', 'subscriber' )";
        $register_user_query = mysqli_query($connection, $query);

        confirmQuery($register_user_query);
    }
}

// Function to log in a user
if (!function_exists('login_user')) {
    function login_user($username, $password)
    {
        global $connection;

        $username = trim($username);
        $password = trim($password);

        $username = mysqli_real_escape_string($connection, $username);
        $password = mysqli_real_escape_string($connection, $password);

        $query = "SELECT * FROM users WHERE username = '{$username}' ";
        $select_user_query = mysqli_query($connection, $query);
        if (!$select_user_query) {

            die("QUERY FAILED" . mysqli_error($connection));

        }

        while ($row = mysqli_fetch_array($select_user_query)) {

            $db_user_id = $row['user_id'];
            $db_username = $row['username'];
            $db_user_password = $row['password'];
            $db_user_firstname = $row['user_firstname'];
            $db_user_lastname = $row['user_lastname'];
            $db_user_role = $row['user_role'];

            if (password_verify($password,$db_user_password)) {

                $_SESSION['username'] = $db_username;
                $_SESSION['firstname'] = $db_user_firstname;
                $_SESSION['lastname'] = $db_user_lastname;
                $_SESSION['user_role'] = $db_user_role;

                redirect("/CM/admin");

            } else {
                return false;
            }
        }

        return true;
    }
}

// Function to insert categories
if (!function_exists('insertCategories')) {
    function insertCategories() {
        global $connection;

        if(isset($_POST['submit'])) {
            $cat_title = mysqli_real_escape_string($connection, trim($_POST['cat_title']));

            if($cat_title == "" || empty($cat_title)) {
                echo "<p class='text-danger'>Please enter category!</p>";
            } else {
                $query = "INSERT INTO categories(cat_title) VALUES('$cat_title')";
                $result = mysqli_query($connection, $query);

                echo "<p class='text-success'>Record added successfully.</p>";

                if(!$result) {
                    die("Query failed! " . mysqli_error($connection));
                }
            }
        }
    }
}

// Function to show all categories
if (!function_exists('showAllCategories')) {
    function showAllCategories() {
        global $connection;

        $query = "SELECT * FROM categories";
        $result = mysqli_query($connection, $query);

        while($row = mysqli_fetch_array($result)) {
            $cat_id      = $row['cat_id'];
            $cat_title   = $row['cat_title'];

            echo "<tr>";
            echo "<td>$cat_id</td>";
            echo "<td>$cat_title</td>";
            echo "<td><a class='btn btn-danger' href='categories.php?delete=$cat_id '>DELETE</a></td>";
            echo "<td><a class='btn btn-warning' href='categories.php?edit=$cat_id '>EDIT</a></td>";
            echo "</tr>";
        }
    }
}

// Function to delete categories
if (!function_exists('deleteCategories')) {
    function deleteCategories() {
        global $connection;

        if(isset($_GET['delete'])) {
            if(isset($_SESSION['user_role'])) {
                if($_SESSION['user_role'] == 'Admin') {
                    $the_delete_cat_id = mysqli_real_escape_string($connection, trim($_GET['delete']));

                    $query = "DELETE FROM categories WHERE cat_id = {$the_delete_cat_id} LIMIT 1";
                    $result = mysqli_query($connection, $query);

                    header("Location: categories.php");
                }
            }
        }
    }
}

// Function to confirm query execution
if (!function_exists('confirmQuery')) {
    function confirmQuery($result) {
        global $connection;
        if (!$result) {
            die("Query failed! " . mysqli_error($connection));
        }
    }
}

// Function to check if a user is online
if (!function_exists('user_online')) {
    function user_online() {
        if(isset($_GET['onlineusers'])) {
            global $connection;

            if(!$connection) {
                session_start();
                include("../includes/db.php");

                $session = session_id();
                $time = time();
                $time_out_in_seconds = 05;
                $time_out = $time - $time_out_in_seconds;

                $query = "SELECT * FROM users_online WHERE session = '$session'";
                $send_query = mysqli_query($connection, $query);

                $count = mysqli_num_rows($send_query);

                if($count == NULL) {
                    mysqli_query($connection, "INSERT INTO users_online(session, time) VALUES('$session', '$time')");
                } else {
                    mysqli_query($connection, "UPDATE users_online SET time = '$time' WHERE session = '$session'");
                }

                $users_online_query = mysqli_query($connection, "SELECT * FROM users_online WHERE time > '$time_out'");
                echo $count_user = mysqli_num_rows($users_online_query);
            }
        }
    }
}

// Function to escape string for use in SQL queries
if (!function_exists('escape')) {
    function escape($string) {
        global $connection;
        return mysqli_real_escape_string($connection, trim($string));
    }
}

// Function to count records in a table
if (!function_exists('recordCount')) {
    function recordCount($table) {
        global $connection;
        $query = "SELECT * FROM " . $table;
        $select_all_posts = mysqli_query($connection, $query);

        $result = mysqli_num_rows($select_all_posts);

        confirmQuery($result);

        return $result;
    }
}

// Function to check status based on table name, column name, and status
if (!function_exists('checkStatus')) {
    function checkStatus($table_name, $column_name, $status) {
        global $connection;

        $query = "SELECT * FROM $table_name WHERE $column_name = '$status'";
        $select_all__published_posts = mysqli_query($connection, $query);
        return mysqli_num_rows($select_all__published_posts);
    }
}

// Function to check if a user is an admin
if (!function_exists('is_admin')) {
    function is_admin($username = "") {
        global $connection;

        $query = "SELECT user_role FROM users WHERE username = '$username'";

        $result = mysqli_query($connection, $query);

        confirmQuery($result);

        $row = mysqli_fetch_array($result);

        if($row['user_role'] == 'Admin') {
            return true;
        } else {
            return false;
        }
    }
}

// Function to check if a username exists
if (!function_exists('username_exists')) {
    function username_exists($username) {
        global $connection;

        $query = "SELECT username FROM users WHERE username = '$username'";
        $result = mysqli_query($connection, $query);

        confirmQuery($result);

        if(mysqli_num_rows($result) > 0) {
            return true;
        } else {
            return false;
        }
    }
}

// Function to check if an email exists
if (!function_exists('email_exists')) {
    function email_exists($email){
        global $connection;

        $query = "SELECT user_email FROM users WHERE user_email = '$email'";
        $result = mysqli_query($connection, $query);
        confirmQuery($result);

        if(mysqli_num_rows($result) > 0) {
            return true;
        } else {
            return false;
        }
    }
}

?>
