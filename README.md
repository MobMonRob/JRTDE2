# JRTDE2
Java Fascade for RTDE based on the ROS UR driver code.


## Tested prerequisites
* Kubuntu 20.04 x64 LTS
* git 2.25.1: `sudo apt install git`
* g++ 9.3.0: `sudo apt install build-essential`
* x86_64-w64-mingw32-g++ 9.3: `sudo apt install mingw-w64 mingw-w64-tools`
* CMake 3.16.3 `sudo apt install cmake`
* SWIG 4.0.1 (3.x does not work!) `sudo apt install swig`
* openjdk 11 LTS: `sudo apt install openjdk-11-jdk openjdk-11-demo openjdk-11-doc openjdk-11-jre-headless openjdk-11-source`
* Snap 2.51.7 `sudo apt install snap`
* Netbeans 12.0 LTS `sudo snap install netbeans --channel=12.0/stable --classic`


## Prepare build
Ensure you checked out all needed submodules properly. To do that, open a terminal and execute `./_git_pull_remote_super_repo_with_current_submodules.sh`.
Sometimes the previous command fails silently. It is therefore recommended to have a look into the submodule folders to ensure they are properly filled. If this is not the case, try to delete the respective submodule folder an re-run the command.

Build the Netbeans Maven project `https://github.com/MobMonRob/JNativeLibLoader`. You will need to rebuild it if it's codebase has changed and if you want to use the changes in JRTDE2.


## How to build
Open and build the Netbeans Maven project `./JRTDE`.

The deployable jar should now be in the following path: `./JRTDE/target/JRTDE-1.0-SNAPSHOT-jar-with-dependencies.jar`.
