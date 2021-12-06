/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package de.dhbw.rahmlab.urcl.test;

import de.dhbw.rahmlab.urcl.impl.urcl.LogLevel;
import de.dhbw.rahmlab.urcl.impl.urclLog;

/**
 *
 * @author fabian
 */
public class LogHandler extends de.dhbw.rahmlab.urcl.impl.urcl.LogHandler {

    /**
     * Do only use one LogHandler instance.
     */
    public LogHandler() {
        super();
    }

    /**
     * Needed. Use only once.
     */
    public void register() {
        urclLog.setLogLevel(LogLevel.DEBUG);
        urclLog.registerTheLogHandler(this);
    }

    @Override
    public void log(String file, int line, de.dhbw.rahmlab.urcl.impl.urcl.LogLevel loglevel, String log) {
        System.out.println(loglevel.toString() + " at line " + line + " (" + file + ")" + ": " + log);
    }

    @Override
    public synchronized void delete() {
        urclLog.unregisterLogHandler();
        super.delete();
    }
}
