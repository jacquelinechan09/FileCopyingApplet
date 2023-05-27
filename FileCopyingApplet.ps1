Add-Type -AssemblyName System.Windows.Forms

$form = New-Object System.Windows.Forms.Form
$form.Text = "File Copying Applet"
$form.Width = 400
$form.Height = 400

$labelSource = New-Object System.Windows.Forms.Label
$labelSource.Text = "Source Files:"
$labelSource.Location = New-Object System.Drawing.Point(20, 20)
$labelSource.Width = 300
$form.Controls.Add($labelSource)

$textboxSource = New-Object System.Windows.Forms.TextBox
$textboxSource.Multiline = $true
$textboxSource.ScrollBars = "Vertical"
$textboxSource.Location = New-Object System.Drawing.Point(20, 50)
$textboxSource.Width = 350
$textboxSource.Height = 100
$form.Controls.Add($textboxSource)

$buttonSource = New-Object System.Windows.Forms.Button
$buttonSource.Text = "Select Source Files"
$buttonSource.Location = New-Object System.Drawing.Point(20, 170)
$buttonSource.Width = 120
$form.Controls.Add($buttonSource)

$labelDestination = New-Object System.Windows.Forms.Label
$labelDestination.Text = "Destination Folder:"
$labelDestination.Location = New-Object System.Drawing.Point(20, 220)
$labelDestination.Width = 300
$form.Controls.Add($labelDestination)

$textboxDestination = New-Object System.Windows.Forms.TextBox
$textboxDestination.Multiline = $true
$textboxDestination.ScrollBars = "Vertical"
$textboxDestination.Location = New-Object System.Drawing.Point(20, 250)
$textboxDestination.Width = 350
$textboxDestination.Height = 100
$form.Controls.Add($textboxDestination)

$buttonDestination = New-Object System.Windows.Forms.Button
$buttonDestination.Text = "Get Destination"
$buttonDestination.Location = New-Object System.Drawing.Point(20, 370)
$buttonDestination.Width = 150
$form.Controls.Add($buttonDestination)

$buttonCopy = New-Object System.Windows.Forms.Button
$buttonCopy.Text = "Copy Files"
$buttonCopy.Location = New-Object System.Drawing.Point(190, 370)
$buttonCopy.Width = 100
$form.Controls.Add($buttonCopy)

# Event handler for source button click
$buttonSource.Add_Click({
    $fileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $fileDialog.Title = "Select Source Files"
    $fileDialog.Multiselect = $true

    if ($fileDialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
        $textboxSource.Text = $fileDialog.FileNames -join "`n"
        foreach ($file in $fileDialog.FileNames) {
            Write-Host "Source File: $file"
        }
    }
})

# Event handler for destination button click
$buttonDestination.Add_Click({
    try {
        $openFileDialog = New-Object System.Windows.Forms.OpenFileDialog
        $openFileDialog.Title = "Select Destination Folder"
        $openFileDialog.Multiselect = $true
        $openFileDialog.CheckFileExists = $false
        $openFileDialog.CheckPathExists = $true
        $openFileDialog.FileName = ""
        $openFileDialog.Filter = "All Files (*.*)|*.*"

        if ($openFileDialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
            $textboxDestination.Text = $openFileDialog.FileNames -join "`n"
        }
    }
    catch {
        [System.Windows.Forms.MessageBox]::Show("Error selecting destination folder:`n$($_.Exception.Message)", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
    }
})

# Event handler for copy button click
$buttonCopy.Add_Click({
    try {
        $sourceFiles = $textboxSource.Text -split "`n" | Where-Object { $_ -ne "" }
        $destinationFolders = $textboxDestination.Text -split "`n" | Where-Object { $_ -ne "" }

        $errorEncountered = $false

        foreach ($sourceFile in $sourceFiles) {
            if (Test-Path -Path $sourceFile) {
                foreach ($destinationFolder in $destinationFolders) {
                    if (Test-Path -Path $destinationFolder -PathType Container) {
                        $destinationPath = Join-Path -Path $destinationFolder -ChildPath (Split-Path -Leaf $sourceFile)
                        Copy-Item -Path $sourceFile -Destination $destinationPath -Force
                        Write-Host "Copied '$sourceFile' to '$destinationPath'"
                    } else {
                        Write-Host "Invalid destination folder path: $destinationFolder"
                        $errorEncountered = $true
                    }
                }
            } else {
                Write-Host "Invalid source file path: $sourceFile"
                $errorEncountered = $true
            }
        }

        if ($errorEncountered) {
            [System.Windows.Forms.MessageBox]::Show("Errors encountered while copying files. Please check the console output.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
        } else {
            [System.Windows.Forms.MessageBox]::Show("Files copied successfully!", "Success", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
        }
    }
    catch {
        [System.Windows.Forms.MessageBox]::Show("Error copying files:`n$($_.Exception.Message)", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
    }
})

# Show the form
$form.Add_Shown({ $form.Activate() })
[void]$form.ShowDialog()
