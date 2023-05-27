# File Copying Applet 
##### A personal project crafted by Jacqueline Chan

Streamline your file management process with ease! Created with PowerShell and Windows Forms, this script enables users to seamlessly copy multiple files to a destination folder of their choice. Enjoy the convenience of an intuitive graphical user interface, making file organization a breeze.

<img width="254" alt="image" src="https://github.com/jacquelinechan09/FileCopyingApplet/assets/109058047/1efe69b3-4673-42cd-bba6-edca7e7c7e58">

## Steps to open the applet. Keyboard shortcuts are indicated in {}.
1. Select all {CTRL-A}, then copy {CTRL-C} the code in my "FileCopyingApplet.ps1" file.
2. Open PowerShell ISE as an Administrator.
3. Paste {CTRL-V} the selected code into the script pane of PowerShell ISE. The script pane is located above the console pane.
4. Run the script {F5} to execute the applet.
5. Within PowerShell ISE, the graphical user interface should automatically open in a new tab!

## How to use:
1. Multiple file paths can be taken by the "Source Files" text box. Click on the "Select Source" button to choose one or more files to copy over.
2. Only one destination folder is permitted (in the future, this is a feature that I am looking to expand upon!). In the "Destination Folder" text box, feel free to directly type in the path. Alternatively, use the "Get Destination" button to navigate to the desired folder. 
 If using the latter option to open a pop-up File Explorer window, please do this:
  a) Copy {CTRL-C} the folder path from the File Explorer pop-up, then close this window. Please do not close the applet itself!
  b) Paste the folder path into the "Destination Folder" text box.
3. Click the "Copy Files" button. If all inputs provided are valid, the files should successfully be copied over. Please note that no files will be deleted from the original source location.
  
