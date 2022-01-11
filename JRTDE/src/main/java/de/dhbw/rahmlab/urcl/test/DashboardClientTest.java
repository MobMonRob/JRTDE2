/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package de.dhbw.rahmlab.urcl.test;

import de.dhbw.rahmlab.urcl.api.DashboardClient;

/**
 *
 * @author fabian
 */
public class DashboardClientTest {

    public static void main(String argv[]) throws Exception {
        test();
    }

    public static void test() throws Exception {
        DashboardClient dashboardClient = new DashboardClient("192.168.12.1");
        boolean connected = dashboardClient.connect();
        if (!connected) {
            System.out.println("!connected");
            return;
        }

        boolean isRunning = dashboardClient.isRunning();
        System.out.println("isRunning: " + isRunning);

        boolean IsInRemoteControl = dashboardClient.isInRemoteControl();
        System.out.println("IsInRemoteControl: " + IsInRemoteControl);
    }
}
