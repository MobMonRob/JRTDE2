/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package de.dhbw.rahmlab.urcl.test;

import de.dhbw.rahmlab.urcl.impl.urcl.comm.INotifier;
import de.dhbw.rahmlab.urcl.impl.urcl.rtde_interface.DataPackage;
import de.dhbw.rahmlab.urcl.impl.urcl.rtde_interface.RTDEClient;
import de.dhbw.rahmlab.urcl.impl.urclSwig;

/**
 *
 * @author fabian
 */
public class UrclTest {

    public static void main(String argv[]) {
        RTDEClientExample();
    }

    public static void RTDEClientExample() {
        LogHandler loghandler = new LogHandler();
        loghandler.register();

        System.out.println("---------------------------------------------");

        //https://github.com/UniversalRobots/Universal_Robots_Client_Library/blob/1.0.0/examples/rtde_client.cpp
        final String ROBOT_IP = "192.168.12.2";
        //https://github.com/UniversalRobots/Universal_Robots_Client_Library/tree/1.0.0/examples/resources
        final String OUTPUT_RECIPE_PATH = "/home/fabian/Desktop/_tmp/rtde_output_recipe.txt";
        final String INPUT_RECIPE_PATH = "/home/fabian/Desktop/_tmp/rtde_input_recipe.txt";
        final long READ_TIMEOUT_MILLISECONDS = 100;

        // Es könnte sein, dass man hiervon erben soll in Java.
        // Dann bräuchte man dafür noch SWIG directors.
        INotifier notifier = new INotifier();
        RTDEClient myClient = new RTDEClient(ROBOT_IP, notifier, OUTPUT_RECIPE_PATH, INPUT_RECIPE_PATH);

        // Man muss auf eine Exception hier relativ lange warten wegen des langen Timeouts des TCP_Clients.
        boolean inited = myClient.init();
        if (!inited) {
            System.out.println("init failed");
            return;
        }

        // We will use the speed_slider_fraction as an example how to write to RTDE
        double speed_slider_fraction = 1.0;
        double speed_slider_increment = 0.01;

        // Once RTDE communication is started, we have to make sure to read from the interface buffer, as
        // otherwise we will get pipeline overflows. Therefor, do this directly before starting your main
        // loop.
        boolean started = myClient.start();
        if (!inited) {
            System.out.println("start failed");
            return;
        }

        while (true) {
            // Read latest RTDE package. This will block for READ_TIMEOUT, so the
            // robot will effectively be in charge of setting the frequency of this loop unless RTDE
            // communication doesn't work in which case the user will be notified.
            // In a real-world application this thread should be scheduled with real-time priority in order
            // to ensure that this is called in time.
            DataPackage data_pkg = myClient.getDataPackage(READ_TIMEOUT_MILLISECONDS);

            if (data_pkg != null) {
                System.out.println(data_pkg.toString());
            } else {
                System.out.println("Could not get fresh data package from robot");
            }

            if (!myClient.getWriter().sendSpeedSlider(speed_slider_fraction)) {
                // This will happen for example, when the required keys are not configured inside the input
                // recipe.

                System.out.println("Sending RTDE data failed.");
            }

            // Change the speed slider so that it will move between 0 and 1 all the time. This is for
            // demonstration purposes only and gains no real value.
            if (speed_slider_increment > 0) {
                if (speed_slider_fraction + speed_slider_increment > 1.0) {
                    speed_slider_increment *= -1;
                }
            } else if (speed_slider_fraction + speed_slider_increment < 0.0) {
                speed_slider_increment *= -1;
            }
            speed_slider_fraction += speed_slider_increment;
        }
    }
}
