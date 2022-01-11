/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package de.dhbw.rahmlab.urcl.test;

import de.dhbw.rahmlab.urcl.impl.urcl.rtde_interface.DataPackage;
import de.dhbw.rahmlab.urcl.impl.urcl.rtde_interface.RTDEClient;
import java.time.Instant;
import java.util.Optional;

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
        final String ROBOT_IP = "192.168.12.1";
        //https://github.com/UniversalRobots/Universal_Robots_Client_Library/tree/1.0.0/examples/resources
        final String OUTPUT_RECIPE_PATH = "/home/fabian/Desktop/_tmp/rtde_output_recipe.txt";
        final String INPUT_RECIPE_PATH = "/home/fabian/Desktop/_tmp/rtde_input_recipe.txt";
        final long READ_TIMEOUT_MILLISECONDS = 100;

        Notifier notifier = new Notifier();
        RTDEClient myClient = new RTDEClient(ROBOT_IP, notifier, OUTPUT_RECIPE_PATH, INPUT_RECIPE_PATH);

        // Man muss auf eine Exception hier relativ lange warten wegen des langen Timeouts des TCP_Clients.
        boolean inited = myClient.init();
        if (!inited) {
            System.out.println("init failed");
            return;
        }

        // Once RTDE communication is started, we have to make sure to read from the interface buffer, as
        // otherwise we will get pipeline overflows. Therefor, do this directly before starting your main
        // loop.
        boolean started = myClient.start();
        if (!started) {
            System.out.println("start failed");
            return;
        }

        long iteration = 0;

        while (true) {
            System.out.println("...");
            System.out.println("time: " + Instant.now().toString());

            ++iteration;
            System.out.println("iteration: " + iteration);

            // Read latest RTDE package. This will block for READ_TIMEOUT, so the
            // robot will effectively be in charge of setting the frequency of this loop unless RTDE
            // communication doesn't work in which case the user will be notified.
            // In a real-world application this thread should be scheduled with real-time priority in order
            // to ensure that this is called in time.
            DataPackage data_pkg = myClient.getDataPackage(READ_TIMEOUT_MILLISECONDS);

            if (data_pkg != null) {
                //System.out.println(data_pkg.toString());

                //https://www.universal-robots.com/articles/ur/interface-communication/real-time-data-exchange-rtde-guide/
                Optional<Double> tool_temperature = data_pkg.getData_double("tool_temperature");
                if (tool_temperature.isPresent()) {
                    System.out.println("tool_temperature: " + tool_temperature.get());
                } else {
                    System.out.println("!tool_temperature.isPresent()");
                }

            } else {
                System.out.println("Could not get fresh data package from robot");
            }
        }
    }
}
