# Import the Active Directory module
Import-Module ActiveDirectory

# Read the CSV file (adjust the path accordingly)
$path = ""
$users = Import-Csv -Path $path -Header samaccountname
$groupName = ""

# Initialize an empty array to store removed users
$removedUsers = @()

foreach ($user in $users) {
    try {
        Remove-ADGroupMember -Identity $groupName -Members $user.samaccountname -Confirm:$false 
        $removedUsers += $user.samaccountname
    } catch {
        Write-Host "Error removing user $($user.samaccountname): $_"
    }
}

# Display the list of removed users and exports it to a csv
Write-Host "Users removed from group $groupName"
$removedUsers
$removedUsers | Out-File "C:\UsersRemovedFrom-$groupName.txt"
