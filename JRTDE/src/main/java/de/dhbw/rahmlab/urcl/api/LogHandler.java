/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package de.dhbw.rahmlab.urcl.api;

import de.dhbw.rahmlab.urcl.impl.urcl.LogLevel;
import de.dhbw.rahmlab.urcl.impl.urcl__log;

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
        urcl__log.setLogLevel(LogLevel.DEBUG);
        urcl__log.registerTheLogHandler(this);
    }

    @Override
    public void log(String file, int line, de.dhbw.rahmlab.urcl.impl.urcl.LogLevel loglevel, String log) {
        System.out.println(loglevel.toString() + " at line " + line + " (" + file + ")" + ": " + log);
    }

    @Override
    public synchronized void delete() {
        urcl__log.unregisterLogHandler();
        super.delete();
    }
}
