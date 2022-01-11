/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package de.dhbw.rahmlab.urcl.api;

import de.dhbw.rahmlab.urcl.impl.timeval;
import java.io.FileNotFoundException;
import java.io.IOException;

/**
 * https://www.universal-robots.com/articles/ur/dashboard-server-e-series-port-29999/
 * https://s3-eu-west-1.amazonaws.com/ur-support-site/42728/DashboardServer_e-Series.pdf
 *
 * @author fabian
 */
public class DashboardClient {

    private de.dhbw.rahmlab.urcl.impl.urcl.DashboardClient actualDashboardClient;

    public DashboardClient(String serverIP) {
        actualDashboardClient = new de.dhbw.rahmlab.urcl.impl.urcl.DashboardClient(serverIP);
    }

    public void setReceiveTimeout(int sec, int usec) {
        timeval timeout = new timeval();
        timeout.setTv_sec(sec);
        timeout.setTv_usec(usec);
        actualDashboardClient.setReceiveTimeout(timeout);
    }

    /**
     * Opens a connection to the dashboard server on the host as specified in
     * the constructor.<br>
     * <br>
     *
     * @return True on successful connection, false otherwise.
     */
    public boolean connect() {
        return actualDashboardClient.connect();
    }

    /**
     * Makes sure no connection to the dashboard server is held inside the
     * object.
     */
    public void disconnect() {
        actualDashboardClient.disconnect();
    }

    private String sendAndReceive(String command) throws IOException {
        de.dhbw.rahmlab.urcl.impl.urcl.comm.SocketState socketState = actualDashboardClient.getState();
        if (socketState != socketState.Connected) {
            throw new IOException(socketState.toString());
        }
        return actualDashboardClient.sendAndReceive(command + "\n");
    }

    public boolean isRunning() throws IOException {
        String command = "running";
        String result = this.sendAndReceive(command);
        boolean isRunning = result.contains("true");
        return isRunning;
    }

    /**
     *
     * @param programName Format: programName.urp
     */
    public void loadProgram(String programName) throws FileNotFoundException, IOException {
        String command = "load " + programName;
        String result = this.sendAndReceive(command);
        boolean hasFailed = result.contains("File not found") || result.contains("Error");
        if (hasFailed) {
            throw new FileNotFoundException(result);
        }
    }

    public boolean playCurrentProgram() throws IOException {
        String command = "play";
        String result = this.sendAndReceive(command);
        boolean success = result.contains("Starting program");
        return success;
    }

    public boolean stopCurrentProgram() throws IOException {
        String command = "stop";
        String result = this.sendAndReceive(command);
        boolean success = result.contains("Stopped");
        return success;
    }

    public boolean isInRemoteControl() throws IOException {
        String command = "is in remote control";
        String result = this.sendAndReceive(command);
        boolean success = result.contains("true");
        return success;
    }
}
