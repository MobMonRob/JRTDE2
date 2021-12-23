# JRTDE2
Java Fascade for RTDE based on the ROS UR driver code.

## Prepare build
Ensure you checked out all needed submodules properly. To do that, open a terminal and execute `./_git_pull_remote_super_repo_with_current_submodules.sh`.
Sometimes the previous command fails silently. It is therefore recommended to have a look into the submodule folders to ensure they are properly filled. If this is not the case, try to delete the respective submodule folder an re-run the command.

Build the Netbeans Maven project `https://github.com/MobMonRob/JNativeLibLoader`. You will need to rebuild it if it's codebase has changed and if you want to use the changes in JRTDE2.


## How to build
Open and build the Netbeans Maven project `./JRTDE`.

The deployable jar should now be in the following path: `./JRTDE/target/JRTDE-1.0-SNAPSHOT-jar-with-dependencies.jar`.
