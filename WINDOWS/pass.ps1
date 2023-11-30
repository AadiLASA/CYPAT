$usernames = net user

foreach ($username in $usernames) {
    # Generate a strong password
    $password = PASSWORD1234!

    # Change the password
    net user $username $password
}

#changes passwords in system to PASSWORD1234!
